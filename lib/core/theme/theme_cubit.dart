import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../local/app_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final AppPreferences _appPreferences;
  static const String _themeKey = 'is_dark_mode';


  ThemeCubit(this._appPreferences) : super(ThemeMode.system) {
    _loadSavedTheme();
  }

  void _loadSavedTheme() {
    final isDark = _appPreferences.getData(key: _themeKey) as bool?;
    if (isDark != null) {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    }
   }

  Future<void> toggle() async {
    final isCurrentlyLight = state == ThemeMode.light || state == ThemeMode.system;
    final newMode = isCurrentlyLight ? ThemeMode.dark : ThemeMode.light;
    final isDark = newMode == ThemeMode.dark;

    await _appPreferences.setData(key: _themeKey, value: isDark);
    emit(newMode);
  }
}