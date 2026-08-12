import 'dart:convert';
import '../../../../core/local/app_preferences.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);

  String? getToken();

  Future<void> saveUser(UserModel user);

  UserModel? getUser();

  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AppPreferences _appPreferences;

  static const String _tokenKey = 'user_token';
  static const String _userKey = 'user_data';

  AuthLocalDataSourceImpl({required AppPreferences appPreferences})
    : _appPreferences = appPreferences;

  @override
  Future<void> saveToken(String token) async {
    await _appPreferences.setData(key: _tokenKey, value: token);
  }

  @override
  String? getToken() {
    return _appPreferences.getData(key: _tokenKey) as String?;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await _appPreferences.setData(key: _userKey, value: jsonString);
  }

  @override
  UserModel? getUser() {
    final jsonString = _appPreferences.getData(key: _userKey) as String?;
    if (jsonString == null || jsonString.isEmpty) return null;

    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(jsonMap);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearAuthData() async {
    await _appPreferences.removeData(key: _tokenKey);
    await _appPreferences.removeData(key: _userKey);
  }
}
