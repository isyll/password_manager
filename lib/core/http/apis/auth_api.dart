import 'package:password_manager/core/http/api_config.dart';
import 'package:password_manager/core/http/request_handler.dart';
import 'package:password_manager/core/http/request_method.dart';
import 'package:password_manager/models/auth/signin_credentials.dart';

class AuthApi extends ApiConfig {
  static const _refreshToken =
      AuthApi(path: 'refresh-token', method: RequestMethod.post, isAuth: true);

  static const _signin = AuthApi(path: 'signin', method: RequestMethod.post);

  const AuthApi(
      {super.module = 'auth',
      required super.path,
      required super.method,
      super.isAuth = false});

  static Future<ResponseModel> refreshToken() => _refreshToken.sendRequest();

  static Future<ResponseModel> signin(SigninCredentials credentials) =>
      _signin.sendRequest(body: credentials.toMap());
}
