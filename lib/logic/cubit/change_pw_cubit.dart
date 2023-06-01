import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firstapp/models/UserModel.dart';

import '../changepw.dart';

part 'change_pw_state.dart';

class ChangePwCubit extends Cubit<ChangePwState> {
  ChangePwCubit() : super(ChangePwInitial());
  Future<void> changepw(String oldpassword,String newpassword, String newpassword2) async {
    emit(ChangePwLoading());
    try {
      final response = await ChangePW().changepw(oldpassword,newpassword, newpassword2);
      if (response) {
        emit(ChangePwSuccess());
      }
    } catch (e) {
      emit(ChangePwError(e.toString()));
    }
  }
}
