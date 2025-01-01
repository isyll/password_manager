import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:password_manager/core/constants/app_config.dart';
import 'package:password_manager/pages/auth/singin/signin_page.dart';
import 'package:password_manager/pages/home/home_page.dart';
import 'package:password_manager/theme/app_theme.dart';

class PasswordManagerApp extends StatefulWidget {
  const PasswordManagerApp({super.key});

  @override
  State<PasswordManagerApp> createState() => _PasswordManagerAppState();
}

class _PasswordManagerAppState extends State<PasswordManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light,
      locale: AppConfig.defaultLocale,
      supportedLocales: AppConfig.availableLocales,
      initialRoute: SigninPage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        SigninPage.routeName: (context) => const SigninPage(),
      },
    );
  }
}
