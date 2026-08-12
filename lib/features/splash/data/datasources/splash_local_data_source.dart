import '../../../../core/local/app_preferences.dart';

abstract class SplashLocalDataSource {
  bool isFirstTime();
  String? getToken();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final AppPreferences _appPreferences;

  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keyToken = 'user_token';

  SplashLocalDataSourceImpl({required AppPreferences appPreferences})
      : _appPreferences = appPreferences;

  @override
  bool isFirstTime() {
    final result = _appPreferences.getData(key: _keyIsFirstTime);
    return (result as bool?) ?? true;
  }

  @override
  String? getToken() {
    final token = _appPreferences.getData(key: _keyToken);
    return token as String?;
  }
}