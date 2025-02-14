part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class UserProfileGetEvent extends UserProfileEvent {}

class UserProfileImageUpdateEvent extends UserProfileEvent {
  final File image;
  final String uid;

  UserProfileImageUpdateEvent({
    required this.image,
    required this.uid,
  });
}
