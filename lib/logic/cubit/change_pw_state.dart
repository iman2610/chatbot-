part of 'change_pw_cubit.dart';

@immutable
abstract class ChangePwState {}

class ChangePwInitial extends ChangePwState {}

class ChangePwLoading extends ChangePwState {}

class ChangePwSuccess extends ChangePwState {
  // final UserModel model1;
  // final String successMessage;

  // ChangePwSuccess(this.model1);
}

class ChangePwError extends ChangePwState {
  final String errorMessage;

  ChangePwError(this.errorMessage);
}
