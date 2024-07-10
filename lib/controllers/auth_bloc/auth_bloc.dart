import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:sm_app/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    final auth = AuthService();

    //Signup
    on<AuthSignUpEvent>((event, emit) async {
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(AuthSignIn(user: userCredential!));
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });

    //Login
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await auth.loginUserWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(AuthSignIn(user: userCredential!));
      } catch (e) {
        log('Auth Bloc: $e');
        emit(AuthError(error: e.toString()));
      }
    });

    //Signout
    on<AuthSignOutEvent>((event, emit) async {
      auth.signOut();
      emit(AuthSignOut());
    });
  }
}
