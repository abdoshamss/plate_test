import 'package:plate_test/features/chat/domain/model/chat_rooms_model.dart';

import '../domain/model/chat_details_model.dart';

abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class GetChatRoomsLoading extends ChatStates {}

class GetChatRoomsSuccess extends ChatStates {
  List<Chats>? chats;

  GetChatRoomsSuccess(this.chats);
}

class GetChatRoomsError extends ChatStates {}

final class MessagesLoadingState extends ChatStates {}

final class MessagesFailed extends ChatStates {}

final class MessagesLoadedState extends ChatStates {
  final PaginationMessagesModel messagesModel;

  MessagesLoadedState(this.messagesModel);
}

class ReceivedMessageState extends ChatStates {}

class MessageSentState extends ChatStates {}

class MessageSentErrorState extends ChatStates {}
