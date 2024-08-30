import 'package:plate_test/features/chat/domain/model/chat_rooms_model.dart';

abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class GetChatRoomsLoading extends ChatStates {}

class GetChatRoomsSuccess extends ChatStates {
  List<Chats>? chats;

  GetChatRoomsSuccess(this.chats);
}

class GetChatRoomsError extends ChatStates {}
