// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:DNL/core/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required AuthRepository authenticationRepository})
      : authRepository = authenticationRepository,
        super(AppInitializing()) {
    on<SplashLoaded>((event, emit) async {
      if (authenticationRepository.isLoggedIn()) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    });

    on<PhoneSignInRequested>((event, emit) async {
      emit(AuthLoading(type: "PhoneSignInRequested"));
      try {
        await authRepository.signInWithPhone(event.phoneNumber,
            codeSentCallback: () {
          add(PhoneCodeSent());
        });
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<PhoneCodeSent>((event, emit) async {
      emit(AuthLoading(type: "SMSCodeSent"));
    });

    on<VerifyOTPRequested>((event, emit) async {
      emit(AuthLoading(type: "VerifyOTPRequested"));
      try {
        await authRepository.verifyOTP(event.code);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authenticationRepository.logout();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<MakeForceSignIn>((event, emit) async {
      emit(Authenticated());
    });
  }
}
