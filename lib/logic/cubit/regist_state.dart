part of 'regist_cubit.dart';

@immutable
abstract class RegistState {}

class RegistInitial extends RegistState {}
class RegistLoading extends RegistState {}

class RegistSuccess extends RegistState {
  // final UserModel model;

  // RegistSuccess(this.model);
}

class RegistError extends RegistState {
  final String errorMessage;

  RegistError(this.errorMessage);

}
