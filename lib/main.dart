import 'package:flutter/material.dart';
import 'package:rgbremote/screens/remote_screen.dart';
import 'package:rgbremote/screens/settings_screen.dart';
import 'package:rgbremote/services/preferences_service.dart';
import 'package:rgbremote/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: RemoteScreen(),
      routes: {
        SettingsScreen.routeName: (_) => SettingsScreen(),
      },
    );
  }
}
