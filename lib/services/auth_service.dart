import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final users = FirebaseFirestore.instance.collection('users');

  //Sign Up
  Future<User?> createUserWithEmailAndPassword(
    final String username,
    final String email,
    final String password,
  ) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        await users.doc(user.uid).set({
          'uid': user.uid,
          'username': username,
          'email': email,
          'profilePicture': '',
          'bio': '',
          'followersCount': 0,
          'followingCount': 0,
        });
        return user;
      } else {
        log('User creation failed: No user returned');
        return null;
      }
    } catch (e) {
      log('Error in createUserWithEmailAndPassword: $e');
      return null;
    }
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

  // Get UID
  String? getCurrentUserId() {
    User? user = auth.currentUser;
    return user?.uid;
  }
}
