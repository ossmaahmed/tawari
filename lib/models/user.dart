import 'dart:convert';

class User {
  final String id;
  final String phone;
  final String name;
  final String longitude;
  final String latitude;
  final String nationalID;
  final String password;
  final String profileImage;
  final String token;

  User({
    required this.id,
    required this.phone,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.nationalID,
    required this.password,
    required this.profileImage,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'nationalID': nationalID,
      'password': password,
      'profileImage': profileImage,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? "",
      phone: map['phone'] ?? "",
      name: map['name'] ?? "",
      longitude: map['longitude'] ?? "",
      latitude: map['latitude'] ?? "",
      nationalID: map['nationalID'] ?? "",
      password: map["password"] ?? "",
      profileImage: map['profileImage'] ?? "",
      token: map['token'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
