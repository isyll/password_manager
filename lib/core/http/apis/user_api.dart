import 'package:password_manager/core/http/api_config.dart';
import 'package:password_manager/core/http/request_method.dart';

class UserApi extends ApiConfig {
  static final userInfos =
      UserApi(path: 'my-informations', method: RequestMethod.get);

  UserApi(
      {super.module = 'user/account',
      required super.path,
      required super.method,
      super.isAuth = true});
}
