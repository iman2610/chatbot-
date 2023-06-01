part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
   final chatmodel modelc;
  ChatSuccess(this.modelc);
}

class ChatError extends ChatState {
  final String errorMessage;

  ChatError(this.errorMessage);
}
