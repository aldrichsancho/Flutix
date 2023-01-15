import 'dart:io';

class User {
  String? name;
  String? email;
  String? password;
  File? photoProfile;
  double? saldo;

  User({this.name, this.email, this.password, this.photoProfile});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    saldo = json['saldo'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['saldo'] = this.saldo;
    return data;
  }
}