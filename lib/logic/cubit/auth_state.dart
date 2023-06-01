part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginModel model;

  AuthSuccess(this.model);
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);

}
