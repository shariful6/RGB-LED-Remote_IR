import 'package:flutter/material.dart';
import 'package:rgbremote/screens/settings_screen.dart';
import 'package:rgbremote/utils/app_color.dart';
import 'package:rgbremote/utils/app_text.dart';
import 'package:rgbremote/widgets/remote_button.dart';

class RemoteScreen extends StatelessWidget {
  const RemoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Card(
          color: AppColor.kRemoteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: AppColor.kBorderColor, width: 10),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RemoteButton(0),
                    RemoteButton(1),
                    RemoteButton(2, labelStyle: AppTextStyle.kWS15W500),
                    RemoteButton(3, labelStyle: AppTextStyle.kWS15W500),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RemoteButton(4, labelStyle: AppTextStyle.kWS15W500),
                    RemoteButton(5, labelStyle: AppTextStyle.kWS15W500),
                    RemoteButton(6, labelStyle: AppTextStyle.kWS15W500),
                    RemoteButton(7, labelStyle: AppTextStyle.kBS15W500),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RemoteButton(12),
                    RemoteButton(16),
                    RemoteButton(20),
                    RemoteButton(8, labelStyle: AppTextStyle.kWS10W500),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RemoteButton(13),
                    RemoteButton(17),
                    RemoteButton(21),
                    RemoteButton(9, labelStyle: AppTextStyle.kWS10W500),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RemoteButton(14),
                    RemoteButton(18),
                    RemoteButton(22),
                    RemoteButton(10, labelStyle: AppTextStyle.kWS10W500),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RemoteButton(15),
                    RemoteButton(19),
                    RemoteButton(23),
                    RemoteButton(11, labelStyle: AppTextStyle.kWS10W500),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
