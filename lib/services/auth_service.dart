import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  //Sign Up
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Login
  Future<User?> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      log('Firebase Auth Login Error: $e');
      throw Exception('An unknown error occurred');
    }
  }

  //signout
  Future<void> signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      log('Firebase Auth SignOut Error: $e');
    }
  }

  //email check
  Future<bool> isEmailRegistered(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  //Reset password
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
    }
  }
}
