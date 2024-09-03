import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pusher_client/pusher_client.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/model/chat_details_model.dart';
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

  TextEditingController send = TextEditingController();

  ScrollController scrollController = ScrollController();
  Directory? appDirectory;
  String? path;

  PagingController<int, Message> messagecontroller =
      PagingController<int, Message>(firstPageKey: 1);

  addPageListener({String? id}) async {
    messagecontroller.addPageRequestListener((pageKey) {
      getChatMessages(
        page: pageKey,
        id: id,
      );
    });
  }

  Future sendMessage(Message messageModel) async {
    final res = await chatRepository.sendMessageRequest(messageModel);
    if (res != null) {
      emit(MessageSentState());
      send.clear();
      messagecontroller.itemList?.insert(0, Message.fromMap(res["chat"]));
      // log(messagecontroller.itemList?[0].id!.toString() ?? "ashraf");
      // return true;
      return Message.fromMap(res["chat"]);
    } else {
      emit(MessageSentErrorState());
      return null;
    }
  }

  getChatMessages({required int page, String? id}) async {
    if (page == 1) {
      emit(MessagesLoadingState());
      // final localMsgs = await Utils.dataManager
      //     .getMsgs(id ?? "", Utils.userModel.id?.toString() ?? "");

      // messagecontroller.itemList?.insertAll(0, localMsgs ?? []);
    }
    final res = await chatRepository.getMessages(
      id: id,
      page: page,
    );

    if (res != null) {
      var isLastPage = res.page == page;
      // currentUserId = res.other?.id.toString() ?? "";

      if (isLastPage) {
        messagecontroller.appendLastPage(res.messages ?? []);
      } else {
        var nextPageKey = page + 1;
        messagecontroller.appendPage(res.messages ?? [], nextPageKey);
        // emit(RefreshState());
      }
      emit(MessagesLoadedState(res));
    } else {
      emit(MessagesFailed());

      messagecontroller.error = 'error';
    }
  }

  String channelName = "";
  late Channel channel;
  late PusherClient pusher = PusherClient(
    "0d55c40fe80d13ebe167",
    PusherOptions(
      encrypted: false,
      cluster: "eu",
    ),
  );
  String currentUserId = '';

  initPusher({required String channelName}) async {
    await pusher.connect();
    this.channelName = "Chat-$channelName";
    pusher.onConnectionStateChange((state) {});
    pusher.onConnectionError((error) {
      log(error?.message.toString() ?? "", name: "pusher");
    });

    channel = pusher.subscribe(
      this.channelName,
    );

    channel.bind("Chat", (event) {
      log(event?.data.toString() ?? "", name: "pusher");
      final data = event?.data ?? "";
      Message message = Message.fromJson(data);
      log((message.isSender == false).toString(), name: "dddd");
      log("${message.id}ashraffff");
      if (message.isSender == false) {
        messagecontroller.itemList?.insert(0, message);

        log(event?.data.toString() ?? "", name: "h333333333333333");
        emit(ReceivedMessageState());
      }
    });
  }
}
