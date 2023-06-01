import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firstapp/models/userModel.dart';

import '../regist.dart';

part 'regist_state.dart';

class RegistCubit extends Cubit<RegistState> {
  RegistCubit() : super(RegistInitial());

  Future<void> register(String email, String name, String password,
      String password2, String phone) async {
    emit(RegistLoading());
    try {
      final response =
          await Regist().register(email, name, password, password2, phone);
      if (response) {
        emit(RegistSuccess());
      }
    } catch (e) {
      emit(RegistError(e.toString()));
    }
  }
}
