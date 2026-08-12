import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> setData({required String key, required dynamic value}) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is double) return await _sharedPreferences.setDouble(key, value);
    return false;
  }

  dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  Future<bool> clearAll() async {
    return await _sharedPreferences.clear();
  }
}