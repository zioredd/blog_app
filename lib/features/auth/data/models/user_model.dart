import 'package:blog_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  final String id;

  UserModel({
    this.id = '',
    required super.name,
    required super.email,
    required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'].toHexString(),
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
