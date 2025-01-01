import 'package:password_manager/core/constants/app_config.dart';
import 'package:password_manager/core/http/apis/auth_api.dart';
import 'package:password_manager/core/http/request_handler.dart';
import 'package:password_manager/models/auth/signin_response.dart';
import 'package:password_manager/services/preferences_service.dart';
import 'package:password_manager/services/secure_storage.dart';

Future<void> initApp() async {
  RequestHandler.getLocaleFn = _getLocale;
  RequestHandler.getAccessTokenFn = SecureStorage.getAccessToken;
  RequestHandler.refreshTokenFn = _refreshToken;
}

String _getLocale() {
  return PreferencesService.getLocale() ?? AppConfig.defaultLocale.languageCode;
}

Future<String?> _refreshToken() async {
  final response = await AuthApi.refreshToken();

  if (response.status) {
    final data = SigninResponse.fromMap(response.data!);
    await SecureStorage.saveTokens(data.accessToken, data.refreshToken);
    return data.accessToken;
  }
  return null;
}
