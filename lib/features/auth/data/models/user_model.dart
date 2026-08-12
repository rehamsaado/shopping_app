import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.firstName,
    required super.lastName,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final nameJson = json[ApiConstants.keyName] as Map<String, dynamic>?;

    return UserModel(
      id: json[ApiConstants.keyId] as int? ?? 0,
      email: json[ApiConstants.keyEmail] as String? ?? '',
      username: json[ApiConstants.keyUsername] as String? ?? '',
      firstName: nameJson?[ApiConstants.keyFirstname] as String? ?? '',
      lastName: nameJson?[ApiConstants.keyLastname] as String? ?? '',
      token: json[ApiConstants.keyToken] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyId: id,
      ApiConstants.keyEmail: email,
      ApiConstants.keyUsername: username,
      ApiConstants.keyName: {
        ApiConstants.keyFirstname: firstName,
        ApiConstants.keyLastname: lastName,
      },
      if (token != null) ApiConstants.keyToken: token,
    };
  }
}