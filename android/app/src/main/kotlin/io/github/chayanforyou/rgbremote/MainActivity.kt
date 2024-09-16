package io.github.chayanforyou.rgbremote

import android.content.Context
import android.hardware.ConsumerIrManager
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var vibrator: Vibrator
    private var irManager: ConsumerIrManager? = null
    private var frequency = 38028 // 38KHz

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "ir_sensor_plugin")
        channel.setMethodCallHandler(this)

        vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val vibratorManager =
                getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as VibratorManager
            vibratorManager.defaultVibrator
        } else {
            @Suppress("deprecation")
            getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        }

        irManager = getSystemService(Context.CONSUMER_IR_SERVICE) as? ConsumerIrManager
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "hasIrEmitter" -> hasIrEmitter(result)
            "codeForEmitter" -> transmitString(call, result)
            "setFrequency" -> setFrequency(call, result)
            "transmitListInt" -> transmitList(call, result)
            "getCarrierFrequencies" -> getCarrierFrequencies(result)
            "vibrate" -> vibrate(result)
            else -> result.notImplemented()
        }
    }

    /**
     * This method convert the Count Pattern to Duration Pattern by multiplying each value by the pulses
     *
     * @param data String in hex code.
     * @return a int Array with all of the Duration values.
     * @see [This method was created by Randy](http://stackoverflow.com/users/1679571/randy)>
     */
    private fun hex2dec(data: String): IntArray {
        val list = data.split(" ").toMutableList()
        list.removeAt(0)
        var frequency = list.removeAt(0).toInt(16)
        list.removeAt(0)
        list.removeAt(0)

        frequency = (1000000 / (frequency * 0.241246)).toInt()
        val pulses = 1000000 / frequency

        val pattern = IntArray(list.size)
        for (i in list.indices) {
            val count = list[i].toInt(16)
            pattern[i] = count * pulses
        }
        return pattern
    }

    /**
     * Transmit an infrared pattern,
     *
     * @param result return a String "Emitting" if there was no problem in the process.
     */
    private fun transmitString(call: MethodCall, result: MethodChannel.Result) {
        val pattern = call.argument<String>("codeForEmitter")
        if (pattern == null) {
            result.error("2", "Unexpected null parameter: codeForEmitter", null)
            return
        }

        if (!hasIrEmitter()) {
            result.error("1", "Device doesn't support IR", null)
            return
        }

        irManager?.transmit(frequency, hex2dec(pattern))
        result.success("Success")
    }

    private fun transmitList(call: MethodCall, result: MethodChannel.Result) {
        val listInt = call.argument<List<Int>>("transmitListInt")
        if (listInt == null) {
            result.error("2", "Unexpected null parameter: transmitListInt", null)
            return
        }

        if (!hasIrEmitter()) {
            result.error("1", "Device doesn't support IR", null)
            return
        }

        if (listInt.isNotEmpty()) {
            irManager?.transmit(frequency, listInt.toIntArray())
            result.success("Success")
        }
    }

    /**
     * Check whether the device has an infrared emitter.
     *
     * @return "true" if the device has an infrared emitter, else "false" .
     */
    private fun hasIrEmitter(result: MethodChannel.Result) {
        result.success(hasIrEmitter())
    }

    /**
     * Change the frequency with which it is transmitted
     */
    private fun setFrequency(call: MethodCall, result: MethodChannel.Result) {
        val newFrequency = call.argument<Int>("setFrequency")
        if (newFrequency == null) {
            result.error("2", "Unexpected null parameter: newFrequency", null)
            return
        }

        this.frequency = newFrequency
        result.success("Success")
    }

    /**
     * Query the infrared transmitter's supported carrier frequencies in `Hertz`.
     */
    private fun getCarrierFrequencies(result: MethodChannel.Result) {
        if (!hasIrEmitter()) {
            result.error("1", "Device doesn't support IR", null)
            return
        }

        val stringBuilder = StringBuilder()
        val freq = irManager!!.carrierFrequencies
        for (range in freq) {
            stringBuilder.append("${range.minFrequency} - ${range.maxFrequency}")
            stringBuilder.append("\n")
        }
        result.success(stringBuilder.toString())
    }

    /**
     * Make a soft vibration effect
     */
    @Suppress("deprecation")
    private fun vibrate(result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val vibrationEffect =
                VibrationEffect.createOneShot(20, VibrationEffect.DEFAULT_AMPLITUDE)
            vibrator.vibrate(vibrationEffect)
        } else {
            vibrator.vibrate(20)
        }
        result.success(null)
    }

    private fun hasIrEmitter(): Boolean {
        return irManager?.hasIrEmitter() == true
    }

    override fun detachFromFlutterEngine() {
        super.detachFromFlutterEngine()
        channel.setMethodCallHandler(null)
    }
}