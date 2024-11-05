import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rgbremote/ir/ir_data.dart';
import 'package:rgbremote/plugin/ir_sensor_plugin.dart';
import 'package:rgbremote/services/preferences_service.dart';
import 'package:rgbremote/utils/hex_color.dart';
import 'package:rgbremote/widgets/neumorphic_button.dart';

class RemoteButton extends StatelessWidget {
  final int index;
  final TextStyle? labelStyle;

  const RemoteButton(
    this.index, {
    super.key,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final data = remoteData[index];
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ValueListenableBuilder<bool>(
        valueListenable: vibrationNotifier,
        builder: (context, isVibrationEnabled, child) {
          return NeumorphicButton(
            onTap: () async {
              try {
                if (isVibrationEnabled) await IrSensorPlugin.vibrate();
                await IrSensorPlugin.transmitString(pattern: data["pattern"]);
              } on PlatformException catch (e) {
                Fluttertoast.showToast(msg: "${e.message}", backgroundColor: Colors.red);
              }
            },
            width: 53,
            height: 53,
            borderWidth: 1,
            padding: EdgeInsets.zero,
            borderColor: Colors.black12,
            boxShape: BoxShape.circle,
            backgroundColor: HexColor(data["color"]),
            topLeftShadowColor: Colors.grey.shade200,
            bottomRightShadowColor: Colors.grey.shade500,
            child: _buildChild(data),
          );
        },
      ),
    );
  }

  Widget _buildChild(Map data) {
    return Center(
      child: labelStyle != null
          ? Text(data["name"], style: labelStyle)
          : Icon(data["icon"], color: Colors.black),
    );
  }
}
