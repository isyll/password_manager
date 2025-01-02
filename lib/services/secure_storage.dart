import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/core/constants/app_keys.dart';
import 'package:password_manager/models/user/user_model.dart';

class SecureStorage {
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> clearAllData() async {
    await _secureStorage.deleteAll();
  }

  static Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: AppKeys.accessToken);
  }

  static Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: AppKeys.accessToken);
  }

  static Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: AppKeys.refreshToken);
  }

  static Future<UserModel?> getUserInfos() async {
    final value = await _secureStorage.read(key: AppKeys.userInfos);
    if (value == null) {
      return null;
    }
    return UserModel.fromJson(value);
  }

  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    await _secureStorage.write(key: AppKeys.accessToken, value: accessToken);
    await _secureStorage.write(key: AppKeys.refreshToken, value: refreshToken);
  }

  static Future<void> saveUserInfos(UserModel user) {
    return _secureStorage.write(key: AppKeys.userInfos, value: user.toJson());
  }
}
