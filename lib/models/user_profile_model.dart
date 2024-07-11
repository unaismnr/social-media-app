import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String uid;
  final String username;
  final String email;
  final String profilePicture;
  final String bio;
  final int followersCount;
  final int followingCount;

  UserProfileModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicture,
    required this.bio,
    required this.followersCount,
    required this.followingCount,
  });

  factory UserProfileModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfileModel(
      uid: doc.id,
      username: data['username'],
      email: data['email'],
      profilePicture: data['profilePicture'],
      bio: data['bio'],
      followersCount: data['followersCount'],
      followingCount: data['followingCount'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'bio': bio,
      'followersCount': followersCount,
      'followingCount': followingCount,
    };
  }
}
