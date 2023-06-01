import 'package:bloc/bloc.dart';
import 'package:firstapp/models/loginmodel.dart';
import 'package:meta/meta.dart';

import '../auth.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await Auth().login(email, password);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
