import 'package:password_manager/core/http/api_config.dart';
import 'package:password_manager/core/http/request_handler.dart';
import 'package:password_manager/core/http/request_method.dart';

class UserApi extends ApiConfig {
  static const _getInfos =
      UserApi(path: 'my-informations', method: RequestMethod.get);

  const UserApi(
      {super.module = 'user/account',
      required super.path,
      required super.method,
      super.isAuth = true});

  static Future<ResponseModel> getInfos() => _getInfos.sendRequest();
}
