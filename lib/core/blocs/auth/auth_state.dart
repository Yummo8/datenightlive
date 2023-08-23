part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AppInitializing extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  final String type;

  AuthLoading({this.type = "default"});

  @override
  List<Object?> get props => [type];
}

class Authenticated extends AuthState {
  Authenticated();

  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  final String? error;

  UnAuthenticated({this.error});

  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
