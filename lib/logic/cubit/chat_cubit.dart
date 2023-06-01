import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/chatmodel.dart';
import '../chat.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> chat(String question) async {
    emit(ChatLoading());
    try {
      final response = await Chat().chat(question);
          emit(ChatSuccess(response));

    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
