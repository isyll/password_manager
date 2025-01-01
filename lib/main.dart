import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/app.dart';
import 'package:password_manager/core/constants/app_config.dart';
import 'package:password_manager/services/preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  await AppConfig.initApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const PasswordManagerApp());
}
