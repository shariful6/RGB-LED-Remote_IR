import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rgbremote/services/preferences_service.dart';
import 'package:rgbremote/utils/app_color.dart';
import 'package:rgbremote/utils/app_text.dart';
import 'package:rgbremote/widgets/hyper_link.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isVibrationEnabled = true;
  String _appVersion = "";

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _getAppVersion();
  }

  void _loadPreferences() {
    _isVibrationEnabled = vibrationNotifier.value;
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  void _toggleVibration(bool isEnabled) async {
    await PreferencesService.satVibration(isEnabled);
    setState(() {
      _isVibrationEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          ListTile(
            title: Text("Vibrate on Touch"),
            subtitle: Text(
              "Provides a subtle vibration when remote buttons are pressed",
              style: AppTextStyle.kGS13W400,
            ),
            trailing: Transform.scale(
              scale: 0.8,
              child: Switch(
                value: _isVibrationEnabled,
                onChanged: _toggleVibration,
                activeColor: AppColor.kWhiteColor,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            "Made with ❤️ by Chayan",
            textAlign: TextAlign.center,
            style: AppTextStyle.kWS14W400,
          ),
          Text(
            'Version: v$_appVersion',
            textAlign: TextAlign.center,
            style: AppTextStyle.kGS13W400,
          ),
          Hyperlink(
            "github.com/chayanforyou/RGB-LED-Remote",
            "https://github.com/chayanforyou/RGB-LED-Remote",
          ),
        ],
      ),
    );
  }
}
