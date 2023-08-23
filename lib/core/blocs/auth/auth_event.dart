part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashLoaded extends AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class AppleSignInRequested extends AuthEvent {}

class GoogleSignUpRequested extends AuthEvent {}

class AppleSignUpRequested extends AuthEvent {}

class PhoneSignInRequested extends AuthEvent {
  final String phoneNumber;

  PhoneSignInRequested(this.phoneNumber);
}

class PhoneSignUpRequested extends AuthEvent {
  final String phoneNumber;

  PhoneSignUpRequested(this.phoneNumber);
}

class PhoneCodeSent extends AuthEvent {}

class VerifyOTPRequested extends AuthEvent {
  final String code;

  VerifyOTPRequested(this.code);
}

// for testing purpose
class MakeForceSignIn extends AuthEvent {
  MakeForceSignIn();
}

class SignOutRequested extends AuthEvent {}
