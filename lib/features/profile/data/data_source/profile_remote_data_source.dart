import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_service.dart';
import '../model/profile_model.dart';


abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfileDetails(String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService _apiService;

  ProfileRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<ProfileModel> getProfileDetails(String userId) async {
    final response = await _apiService.get(
      path: '${ApiConstants.users}/$userId',
    );
    final data = response as Map<String, dynamic>;
    return ProfileModel.fromJson(data);
  }
}