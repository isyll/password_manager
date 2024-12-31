import 'package:password_manager/core/http/api_config.dart';
import 'package:password_manager/core/http/request_handler.dart';
import 'package:password_manager/core/http/request_method.dart';

class PasswordApi extends ApiConfig {
  static final _generatePassword =
      PasswordApi(path: 'generate', method: RequestMethod.get);

  static final _checkStrength =
      PasswordApi(path: 'strength', method: RequestMethod.get);

  PasswordApi(
      {super.module = 'password',
      required super.path,
      required super.method,
      super.isAuth = false});

  static Future<ResponseModel> checkStrength(String password) =>
      _checkStrength.sendRequest(queryParams: {'password': password});

  static Future<ResponseModel> generatePassword([int? length]) =>
      _generatePassword
          .sendRequest(queryParams: {'length': length?.toString()});
}
