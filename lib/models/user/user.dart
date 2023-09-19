import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userName': userName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['_id'] ?? "",
      map['firstName'] ?? '',
      map['lastName'] ?? '',
      map['email'] ?? '',
      map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
