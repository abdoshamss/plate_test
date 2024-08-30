import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/model/chat_rooms_model.dart';
import '../domain/repository/repository.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  ChatRepository chatRepository = ChatRepository(locator<DioService>());

  chatRooms() async {
    emit(GetChatRoomsLoading());
    final response = await chatRepository.getChatRooms();
    if (response != null) {
      if (response["chats"] == null) {
        emit(GetChatRoomsError());
        return false;
      } else {
        emit(GetChatRoomsSuccess(Data.fromJson(response).chats));
        return true;
      }
    } else {
      emit(GetChatRoomsError());
      return null;
    }
  }
}
