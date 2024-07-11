import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sm_app/models/user_profile_model.dart';
import 'package:sm_app/services/user_profile_service.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    final userProSer = UserProfileService();
    on<UserProfileGetEvent>((event, emit) async {
      try {
        emit(UserProfileLoading());
        final userPro = await userProSer.getMyProfile();
        if (userPro != null) {
          emit(UserProfileLoaded(userProfile: userPro));
        }
      } catch (e) {
        print('User Profile Bloc Get Error: $e');
        emit(
          UserProfileError(errorMessege: e.toString()),
        );
      }
    });

    on<UserProfileImageUpdateEvent>((event, emit) async {
      try {
        final imageUrl = await userProSer.uploadImage(
          event.image,
          event.uid,
        );
        await userProSer.updateProfilePicture(
          event.uid,
          imageUrl!,
        );
      } catch (e) {
        print(e);
      }
    });
  }
}
