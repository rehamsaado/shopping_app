import '../local/app_preferences.dart';

class CacheKeys {
  static const String userId = 'cached_user_id';
  static const String token = 'auth_token';
}

class UserSession {
  final AppPreferences _appPreferences;

  UserSession(this._appPreferences);

  // حفظ معرّف المستخدم عند تسجيل الدخول الناجح
  Future<void> saveUserId(String userId) async {
    await _appPreferences.setData(key: CacheKeys.userId, value: userId);
  }

  // استرجاع معرّف المستخدم ديناميكياً (يعيد null إذا لم يكن هناك مستخدم مسجل، بدون أي قيم افتراضية خطرة مثل '1')
  String? getUserId() {
    return _appPreferences.getData(key: CacheKeys.userId) as String?;
  }

  // مسح الجلسة عند تسجيل الخروج
  Future<void> clearSession() async {
    await _appPreferences.removeData(key: CacheKeys.userId);
    await _appPreferences.removeData(key: CacheKeys.token);
  }
}