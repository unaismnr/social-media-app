part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfileModel userProfile;

  UserProfileLoaded({
    required this.userProfile,
  });
}

class UserProfileError extends UserProfileState {
  final String errorMessege;
  UserProfileError({
    required this.errorMessege,
  });
}
