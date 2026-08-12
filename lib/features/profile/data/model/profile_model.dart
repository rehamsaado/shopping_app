import '../../../../core/constants/app_constants.dart';
import '../../domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.email,
    required super.username,
    required super.password,
    required super.name,
    required super.address,
    required super.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json[ApiConstants.keyId] as int? ?? 0,
      email: json[ApiConstants.keyEmail] as String? ?? '',
      username: json[ApiConstants.keyUsername] as String? ?? '',
      password: json[ApiConstants.keyPassword] as String? ?? '',
      name: ProfileNameModel.fromJson(
        json[ApiConstants.keyName] as Map<String, dynamic>? ?? {},
      ),
      address: ProfileAddressModel.fromJson(
        json[ApiConstants.keyAddress] as Map<String, dynamic>? ?? {},
      ),
      phone: json[ApiConstants.keyPhone] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyId: id,
      ApiConstants.keyEmail: email,
      ApiConstants.keyUsername: username,
      ApiConstants.keyPassword: password,
      ApiConstants.keyName: (name as ProfileNameModel).toJson(),
      ApiConstants.keyAddress: (address as ProfileAddressModel).toJson(),
      ApiConstants.keyPhone: phone,
    };
  }
}

class ProfileNameModel extends ProfileNameEntity {
  ProfileNameModel({required super.firstname, required super.lastname});

  factory ProfileNameModel.fromJson(Map<String, dynamic> json) {
    return ProfileNameModel(
      firstname: json[ApiConstants.keyFirstname] as String? ?? '',
      lastname: json[ApiConstants.keyLastname] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyFirstname: firstname,
      ApiConstants.keyLastname: lastname,
    };
  }
}

class ProfileAddressModel extends ProfileAddressEntity {
  ProfileAddressModel({
    required super.city,
    required super.street,
    required super.number,
    required super.zipcode,
    required super.geoLocation,
  });

  factory ProfileAddressModel.fromJson(Map<String, dynamic> json) {
    return ProfileAddressModel(
      city: json[ApiConstants.keyCity] as String? ?? '',
      street: json[ApiConstants.keyStreet] as String? ?? '',
      number: json[ApiConstants.keyNumber] as int? ?? 0,
      zipcode: json[ApiConstants.keyZipcode] as String? ?? '',
      geoLocation: ProfileGeoLocationModel.fromJson(
        json['geolocation'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyCity: city,
      ApiConstants.keyStreet: street,
      ApiConstants.keyNumber: number,
      ApiConstants.keyZipcode: zipcode,
      'geolocation': (geoLocation as ProfileGeoLocationModel).toJson(),
    };
  }
}

class ProfileGeoLocationModel extends ProfileGeoLocationEntity {
  ProfileGeoLocationModel({required super.lat, required super.long});

  factory ProfileGeoLocationModel.fromJson(Map<String, dynamic> json) {
    return ProfileGeoLocationModel(
      lat: json['lat'] as String? ?? '',
      long: json['long'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'long': long};
  }
}
