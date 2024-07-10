import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String email;
  String password;

  UserModel({
    this.id,
    required this.email,
    required this.password,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'],
      password: data['password'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'password': password,
    };
  }
}
