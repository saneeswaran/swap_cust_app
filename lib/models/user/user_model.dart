// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

class UserModel {
  final String name;
  final String email;
  final String? image;
  final String password;
  UserModel({
    required this.name,
    required this.email,
    this.image,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
