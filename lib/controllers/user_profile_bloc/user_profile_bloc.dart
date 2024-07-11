import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sm_app/models/user_profile_model.dart';
import 'package:sm_app/services/user_profile_service.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<UserProfileGetEvent>((event, emit) async {
      final userProSer = UserProfileService();
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
  }
}
