class ProfileEntity {
  final int id;
  final String email;
  final String username;
  final String password;
  final ProfileNameEntity name;
  final ProfileAddressEntity address;
  final String phone;

  ProfileEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });
}

class ProfileNameEntity {
  final String firstname;
  final String lastname;

  ProfileNameEntity({required this.firstname, required this.lastname});
}

class ProfileAddressEntity {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final ProfileGeoLocationEntity geoLocation;

  ProfileAddressEntity({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geoLocation,
  });
}

class ProfileGeoLocationEntity {
  final String lat;
  final String long;

  ProfileGeoLocationEntity({required this.lat, required this.long});
}