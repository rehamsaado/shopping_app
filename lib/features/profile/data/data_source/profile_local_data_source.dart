import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/local/app_preferences.dart';
import '../model/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<void> cacheProfileDetails(ProfileModel profileToCache);
  Future<ProfileModel> getCachedProfileDetails();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final AppPreferences _appPreferences;


  static const String cachedProfileKey = 'CACHED_PROFILE';

  ProfileLocalDataSourceImpl({required AppPreferences appPreferences})
      : _appPreferences = appPreferences;

  @override
  Future<void> cacheProfileDetails(ProfileModel profileToCache) async {
    final jsonString = json.encode(profileToCache.toJson());
    await _appPreferences.setData(key: cachedProfileKey, value: jsonString);
  }

  @override
  Future<ProfileModel> getCachedProfileDetails() async {
    final jsonString = _appPreferences.getData(key: cachedProfileKey);
    if (jsonString != null && jsonString is String) {
      return ProfileModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);
    } else {
      throw CacheException();
    }
  }
}