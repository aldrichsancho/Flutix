import 'dart:io';

class User {
  String name;
  String email;
  String password;
  File? photoProfile;

  User({required this.name, required this.email, required this.password, this.photoProfile});
}