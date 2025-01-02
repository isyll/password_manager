import 'dart:convert';

class UserModel {
  final int id;
  final String email;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String countryCode;
  final DateTime dateOfBirth;
  final String firstName;
  final String lastName;

  const UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.countryCode,
    required this.dateOfBirth,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      phone: json['phone'] as String,
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
      updatedAt: DateTime.parse(json['updated_at'] as String).toLocal(),
      countryCode: json['country_code'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'country_code': countryCode,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
