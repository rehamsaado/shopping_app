import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../local/app_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final AppPreferences _appPreferences;
  static const String _langKey = 'selected_language';


  LocaleCubit(this._appPreferences) : super(_getDeviceLocale()) {
    _loadSavedLanguage();
  }

  static Locale _getDeviceLocale() {
    final deviceLang = PlatformDispatcher.instance.locale.languageCode;
    if (deviceLang == 'ar') {
      return const Locale('ar');
    }
    return const Locale('en');
  }

  void _loadSavedLanguage() {
    final savedLang = _appPreferences.getData(key: _langKey) as String?;
    if (savedLang != null) {
      emit(Locale(savedLang));
    }
  }

  Future<void> toggle() async {
    final nextLang = state.languageCode == 'ar' ? 'en' : 'ar';
    await _appPreferences.setData(key: _langKey, value: nextLang);
    emit(Locale(nextLang));
  }
}