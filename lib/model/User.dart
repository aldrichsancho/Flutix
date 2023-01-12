import 'dart:io';

class User {
  String? name;
  String? email;
  String? password;
  File? photoProfile;

  User({required this.name, required this.email, required this.password, this.photoProfile});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}