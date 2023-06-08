import 'package:bloc/bloc.dart';
import 'package:firstapp/models/loginmodel.dart';
import 'package:meta/meta.dart';
import '../changeinfo.dart';

part 'change_info_state.dart';

class ChangeInfoCubit extends Cubit<ChangeInfoState> {
  ChangeInfoCubit() : super(ChangeInfoInitial());
  Future<void> changeinfo(
    String id,
    String name,
    String email,
    String phone,
  ) async {
    emit(ChangeInfoLoading());
    try {
      final response = await Changeinfo.changeinfo(
        id,
        name,
        email,
        phone,
      );
      // if (response) {
      emit(ChangeInfoSuccess(response));
      // }
    } catch (e) {
      print(e);
      emit(ChangeInfoError(e.toString()));
    }
  }
}
