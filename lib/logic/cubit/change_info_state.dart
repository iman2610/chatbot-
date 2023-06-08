part of 'change_info_cubit.dart';

@immutable
abstract class ChangeInfoState {}

class ChangeInfoInitial extends ChangeInfoState {}

class ChangeInfoLoading extends ChangeInfoState {}

class ChangeInfoSuccess extends ChangeInfoState {
  final DataModel infoModel;
  ChangeInfoSuccess(this.infoModel);
}

class ChangeInfoError extends ChangeInfoState {
  final String errorMessage;

  ChangeInfoError(this.errorMessage);
}
