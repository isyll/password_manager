import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/core/constants/app_keys.dart';

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

  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    await _secureStorage.write(key: AppKeys.accessToken, value: accessToken);
    await _secureStorage.write(key: AppKeys.refreshToken, value: refreshToken);
  }
}
