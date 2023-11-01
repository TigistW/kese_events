import 'dart:convert';
import 'package:hive/hive.dart';

part 'user.g.dart';
@HiveType(typeId: 12)
class User {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? profilePicture;
  @HiveField(5)
  final String? phoneNumber;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePicture,
    this.phoneNumber,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePicture': profilePicture,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] ?? "",
      map['firstName'] ?? '',
      map['lastName'] ?? '',
      map['email'] ?? '',
      map['profilePicture'] ?? '',
      map['phone_number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
