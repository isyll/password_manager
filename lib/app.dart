import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
    return GlobalLoaderOverlay(
      overlayColor: Colors.black.withValues(alpha: 0.25),
      overlayWidgetBuilder: (_) => Center(
        child: SpinKitRing(
          lineWidth: 4,
          color: Colors.black.withValues(alpha: 0.5),
          size: 50.0,
        ),
      ),
      child: MaterialApp(
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
        initialRoute: HomePage  .routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SigninPage.routeName: (context) => const SigninPage(),
        },
      ),
    );
  }
}
