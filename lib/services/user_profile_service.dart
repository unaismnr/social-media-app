import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sm_app/models/user_profile_model.dart';
import 'package:sm_app/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfileService {
  final auth = AuthService();
  final users = FirebaseFirestore.instance.collection('users');

  Future<UserProfileModel?> getMyProfile() async {
    try {
      final uid = auth.getCurrentUserId();
      if (uid == null) {
        print('Error: No authenticated user found');
        return null;
      }
      print('UID: $uid');
      final docSnapshot = await users.doc(uid).get();
      if (docSnapshot.exists) {
        return UserProfileModel.fromDocument(docSnapshot);
      } else {
        return null;
      }
    } catch (error) {
      print('Error getting user profile: $error');
      return null;
    }
  }

  Future<String?> uploadImage(File image, String uid) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child(
            'profile_pictures/$uid',
          );
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateProfilePicture(
    String uid,
    String profilePictureURL,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {'profilePicture': profilePictureURL},
      );
    } catch (e) {
      print(e);
    }
  }
}
