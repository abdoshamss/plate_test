import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/chat/cubit/chat_cubit.dart';
import 'package:plate_test/features/chat/presentation/widgets/widgets.dart';
import 'package:plate_test/shared/widgets/edit_text_widget.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/chat_states.dart';
import '../../domain/model/chat_details_model.dart';

class ChatDetailsScreen extends StatefulWidget {
  final int? id;

  const ChatDetailsScreen({super.key, required this.id});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  PaginationMessagesModel? paginationMessagesModel;

  @override
  void initState() {
    super.initState();
    Utils.room_id = widget.id.toString() ?? "";
  }

  bool isTyping = false;
  Message messageModel = Message();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatCubit()
        ..addPageLisnter(
          id: widget.id.toString(),
        )
        ..initPusher(channelName: "${widget.id}"),
      child: BlocConsumer<ChatCubit, ChatStates>(
          listener: (BuildContext context, state) {
        if (state is MessagesLoadedState)
          paginationMessagesModel = state.messagesModel;
      }, builder: (BuildContext context, Object? state) {
        final cubit = BlocProvider.of<ChatCubit>(context);
        print("print mapppp");
        print(paginationMessagesModel?.map);
        return Scaffold(
          body: SafeArea(
            child: Column(children: [
              /// Headerrrrr
              const HeaderChatDeatilsScreen(),

              /// Plate Itemmmmmmmmmm
              const PlateItemInChatDeatilsScreen(),

              /// chattttt
              Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification notification) {
                  // if(notification.ma)
                  notification.disallowIndicator();
                  return false;
                },
                child: PagedListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollController: cubit.scrollController,
                  reverse: true,
                  pagingController: cubit.messagecontroller,
                  builderDelegate: PagedChildBuilderDelegate<Message>(
                    itemBuilder: (context, item, index) {
                      print("index");
                      print(index);
                      return Column(
                        children: [
                          if (index < 2)
                            CustomText(
                              ////

                              paginationMessagesModel!.map!.keys
                                  .elementAt(index),
                              style: const TextStyle(
                                  color: Color(0xff94A3B8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          12.ph,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  item.createdAt ?? "",
                                  style: const TextStyle(
                                      color: Color(0xff94A3B8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                if (index < 2)
                                  ListView.builder(
                                    itemCount: paginationMessagesModel!
                                        .map!.values
                                        .elementAt(index)
                                        .length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    reverse: true,
                                    itemBuilder: (context, i) => Row(
                                      mainAxisAlignment: item.isSender ?? true
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          margin:
                                              const EdgeInsetsDirectional.only(
                                            top: 4,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: const Color(0xff2E225E)),
                                          child: CustomText(
                                            paginationMessagesModel!.map!.values
                                                        .elementAt(index)[i]
                                                    ["message"] ??
                                                "",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                8.ph,
                                if (item.isSeen ?? false)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                        "eye_chat".svg(),
                                        fit: BoxFit.fill,
                                      ),
                                      4.pw,
                                      const CustomText(
                                        "Viewed",
                                        style: TextStyle(
                                            color: Color(0xff94A3B8),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                              ])
                        ],
                      );
                    },
                  ),
                ),
              ))
            ]),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 7,
                    child: TextFormFieldWidget(
                      controller: cubit.send,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      hintText: "Write a message",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a message";
                        }
                        return null;
                      },
                    ),
                  ),
                  8.pw,
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        messageModel.roomId = widget.id.toString();
                        messageModel.message = cubit.send.text.toString();
                        cubit.sendMessage(messageModel);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: LightThemeColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Transform.scale(
                            scale: 1,
                            child: const Icon(
                              size: 16,
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
// {
// اليوم:
// [{id: 62, is_sender: true, is_seen: false, message: gggg, attachment: , created_at: 01:07 ص},
// {id: 61, is_sender: true, is_seen: false, message: ggfggvvv, attachment: , created_at: 01:06 ص},
// {id: 60, is_sender: true, is_seen: false, message: fff, attachment: , created_at: 12:57 ص},
// {id: 59, is_sender: true, is_seen: false, message: fff, attachment: , created_at: 12:56 ص},
// {id: 58, is_sender: true, is_seen: false, message: fff, attachment: , created_at: 12:56 ص},
// {id: 57, is_sender: true, is_seen: false, message: ddddfffgv, attachment: , created_at: 12:47 ص}],
//
// 2024-08-29: [{id: 37, is_sender: true, is_seen: false, message: tsssssssssssssst, attachment: , created_at: 03:12 م}]
// }
