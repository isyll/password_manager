import 'package:password_manager/core/constants/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static SharedPreferences? _sharedPreferences;

  static String? getLocale() {
    return _sharedPreferences?.getString(AppKeys.locale);
  }

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveLocale(String countryCode) async {
    await _sharedPreferences?.setString(AppKeys.locale, countryCode);
  }
}
