import 'package:flutter/material.dart';
import 'package:password_manager/core/http/apis/auth_api.dart';
import 'package:password_manager/core/http/request_handler.dart';
import 'package:password_manager/models/auth/signin_response.dart';
import 'package:password_manager/services/preferences_service.dart';
import 'package:password_manager/services/secure_storage.dart';

class AppConfig {
  static const appName = 'Password Manager';
  static const author = 'Ibrahima Sylla';
  static const email = 'tech@isyll.com';
  static const availableLocales = [Locale('fr')];
  static const defaultLocale = Locale('fr');
  static const baseUrl = 'http://localhost:8080/api/v1';

  static Future<void> initApp() async {
    RequestHandler.getLocaleFn = _getLocale;
    RequestHandler.getAccessTokenFn = SecureStorage.getAccessToken;
    RequestHandler.refreshTokenFn = _refreshToken;
  }

  static String _getLocale() {
    return PreferencesService.getLocale() ??
        AppConfig.defaultLocale.languageCode;
  }

  static Future<String?> _refreshToken() async {
    final response = await AuthApi.refreshToken();

    if (response.status) {
      final data = SigninResponse.fromMap(response.data!);
      await SecureStorage.saveTokens(data.accessToken, data.refreshToken);
      return data.accessToken;
    }
    return null;
  }
}
