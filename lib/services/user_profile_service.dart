import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sm_app/models/user_profile_model.dart';
import 'package:sm_app/services/auth_service.dart';

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
}
