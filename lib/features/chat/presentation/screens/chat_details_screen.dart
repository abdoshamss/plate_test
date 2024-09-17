import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/chat/cubit/chat_cubit.dart';
import 'package:plate_test/shared/widgets/edit_text_widget.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/chat_states.dart';
import '../../domain/model/chat_details_model.dart';
import '../widgets/widgets.dart';

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
        ..addPageListener(
          id: widget.id.toString(),
        )
        ..initPusher(channelName: "${widget.id}"),
      child: BlocConsumer<ChatCubit, ChatStates>(
          listener: (BuildContext context, state) {
        if (state is MessagesLoadedState) {
          paginationMessagesModel = state.messagesModel;
        }
      }, builder: (BuildContext context, Object? state) {
        final cubit = BlocProvider.of<ChatCubit>(context);
        // print("print mapppp");
        // print(paginationMessagesModel?.map);
        return Scaffold(
          body: SafeArea(
            child: Column(children: [
              /// Headerrrrr
              if (state is MessagesLoadedState)
                HeaderChatDeatilsScreen(
                  data: paginationMessagesModel?.other,
                ),

              /// Plate Itemmmmmmmmmm
              if (state is MessagesLoadedState)
                PlateItemInChatDeatilsScreen(
                  item: paginationMessagesModel?.item,
                ),

              /// chattttt

              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification:
                      (OverscrollIndicatorNotification notification) {
                    notification.disallowIndicator();
                    return false;
                  },
                  child: PagedListView(
                      scrollController: cubit.scrollController,
                      reverse: true,
                      pagingController: cubit.messagecontroller,
                      builderDelegate: PagedChildBuilderDelegate<Message>(
                        itemBuilder: (context, item, index) {
                          return MessageWidget(
                            key: ValueKey("$index${item.createdAt}"),
                            message: item,
                            // sender: sender,
                            // previousSender: previousSender
                          );
                        },
                      )),
                ),
              ),
              // NotificationListener<OverscrollIndicatorNotification>(
              //     onNotification:
              //         (OverscrollIndicatorNotification notification) {
              //       // if(notification.me)
              //       notification.disallowIndicator();
              //       return false;
              //     },
              //     child: PagedListView(
              //       // itemCount: paginationMessagesModel!.map!.keys.length,
              //       padding: const EdgeInsets.symmetric(horizontal: 24),
              //       scrollController: cubit.scrollController,
              //       reverse: true,
              //       pagingController: cubit.messagecontroller,
              //       builderDelegate: PagedChildBuilderDelegate<Message>(
              //         itemBuilder: (context, item, index) {
              //           // print("index");
              //           // print(index);
              //           // print(
              //           //     "paginationMessagesModel!.map!.keys.elementAt(index)");
              //           // print(paginationMessagesModel!.map!.keys
              //           //     .elementAt(index));
              //           return MessageWidget(message: item);
              //           // ListView.builder(
              //           //   controller: cubit.scrollController,
              //           //   itemCount: paginationMessagesModel!
              //           //       .map!.values
              //           //       .elementAt(index)
              //           //       .length,
              //           //   shrinkWrap: true,
              //           //   physics: const NeverScrollableScrollPhysics(),
              //           //   reverse: true,
              //           //   itemBuilder: (context, i) {
              //           //     return
              //           //   },
              //           // );
              //         },
              //         // ),
              //       ),
              //     ))
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
                        // messageModel.roomId = widget.id.toString();
                        // messageModel.message = cubit.send.text.toString();
                        // cubit.messagecontroller.itemList!.insert(
                        //   0,
                        //   Message(
                        //     message: cubit.send.text.toString(),
                        //     isSender: true,
                        //     isSeen: false,
                        //     createdAt: DateTime.now().toString(),
                        //   ),
                        // );
                        await cubit.sendMessage(
                          messageModel
                            ..roomId = widget.id.toString()
                            ..message = cubit.send.text,
                        );
                        cubit.scrollController
                            .jumpTo(cubit.scrollController.initialScrollOffset);
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
class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    this.message,

    // required this.sender,
    // required this.previousSender,
  });

  final Message? message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  // final String sender;
  ChatCubit? cubit;

  @override
  void initState() {
    cubit = ChatCubit.get(context);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    // await sendMsg();
    // });

    super.initState();
  }

  // Future<void> sendMsg() async {
  //   if (widget.message?.id == null && widget.message?.isLoading == false) {
  //     widget.message?.isLoading = true;
  //     widget.message?.faildToSent = false;
  //     log("0");
  //     await Utils.dataManager.addMsg(
  //       widget.message!,
  //     );
  //     Message? send = await cubit?.sendMessage(widget.message!);
  //
  //     widget.message?.isLoading = false;
  //     if (send != null) {
  //       log("1");
  //       print(send.id);
  //
  //       widget.message?.id = send.id;
  //       widget.message?.attachMent = send.attachMent;
  //
  //       widget.message?.faildToSent = false;
  //       await Utils.dataManager.deleteMsg(widget.message?.createdAt ?? '');
  //
  //       widget.message?.createdAt = send.createdAt;
  //       // setState(() {});
  //     } else {
  //       log("2");
  //       widget.message?.faildToSent = true;
  //       await Utils.dataManager.updateMsg(
  //         widget.message?.createdAt ?? '',
  //         widget.message!,
  //       );
  //
  //       setState(() {});
  //     }
  //   }
  // }

  // final String previousSender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom:
              //  previousSender != sender ?
              //  16 :
              8.0,
          right: 8,
          left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: widget.message!.isSender!
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: widget.message!.isSender!
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              CustomText(
                widget.message?.createdAt ?? "",
                fontSize: 12,
                weight: FontWeight.w500,
                color: LightThemeColors.textSecondary,
              ),
              10.ph,
              Container(
                // height: 65,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: widget.message!.isSender!
                      ? LightThemeColors.primary
                      : const Color(0xffF2F0F8),
                  borderRadius: Utils.lang == "en"
                      ? widget.message!.isSender!
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )
                      : widget.message!.isSender!
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.message?.attachMent != ""
                        ? Column(
                            children: [
                              // if (widget.message?.attachMent != "")
                              //   Container(
                              //     height: 100,
                              //     child: (widget.message?.id == null &&
                              //             widget.message?.file != null)
                              //         ? ClipRRect(
                              //             child: Image.file(
                              //               fit: BoxFit.fill,
                              //               widget.message?.file ?? File(""),
                              //             ),
                              //           )
                              //         : (widget.message?.attachMent
                              //                     ?.isNotEmpty ==
                              //                 true)
                              //             ? ClipRRect(
                              //                 child: NetworkImagesWidgets(
                              //                   fit: BoxFit.fill,
                              //                   widget.message?.attachMent ??
                              //                       "",
                              //                 ),
                              //               ).onTap(
                              //                 () {
                              //                   Navigator.pushNamed(
                              //                     context,
                              //                     Routes.imageFullScreen,
                              //                     arguments: ImageArgs(
                              //                       url: widget.message
                              //                               ?.attachMent ??
                              //                           "",
                              //                     ),
                              //                   );
                              //                 },
                              //               )
                              //             : null,
                              //   ),
                              CustomText(
                                widget.message?.message ?? "",
                                color: widget.message!.isSender!
                                    ? Colors.white
                                    : LightThemeColors.textPrimary,
                              ),
                            ],
                          )
                        : CustomText(
                            widget.message?.message ?? "",
                            color: widget.message!.isSender!
                                ? Colors.white
                                : LightThemeColors.textPrimary,
                          ),
                  ),
                ),
              ),
              if (widget.message!.isSender! && widget.message!.isSeen!) 16.ph,
              if (widget.message!.isSender! && widget.message!.isSeen!)
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "seen_eye".svg(),
                    ),
                    6.pw,
                    const CustomText(
                      "Viewed",
                      fontSize: 12,
                      weight: FontWeight.w500,
                      color: LightThemeColors.textSecondary,
                    )
                  ],
                ),
            ],
          ),
          if (widget.message?.isSender == true) ...[
            4.pw,
            if (widget.message?.id == null)
              const Icon(
                Icons.av_timer_rounded,
                size: 15,
              ),
            if (widget.message?.id != null)
              const Icon(
                Icons.check,
                size: 15,
              ),
          ],
        ],
      ),
    );
  }
}
// class MessageItem extends StatelessWidget {
//   final Message item;
//
//   const MessageItem({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: item.isSender ?? false
//           ? CrossAxisAlignment.end
//           : CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           item.createdAt ?? "",
//           style: const TextStyle(
//               color: Color(0xff94A3B8),
//               fontSize: 12,
//               fontWeight: FontWeight.w500),
//         ),
//         Row(
//           mainAxisAlignment: item.isSender ?? false
//               ? MainAxisAlignment.end
//               : MainAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               margin: const EdgeInsetsDirectional.only(
//                 top: 4,
//               ),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: item.isSender ?? false
//                       ? const Color(0xff2E225E)
//                       : const Color(0xffF2F0F8)),
//               child: CustomText(
//                 item.message ?? "",
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color:
//                         item.isSender ?? false ? Colors.white : Colors.black),
//               ),
//             ),
//           ],
//         ),
//         if (item.isSeen!) 8.ph,
//         if (item.isSeen!)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SvgPicture.asset(
//                 "eye_chat".svg(),
//                 fit: BoxFit.fill,
//               ),
//               4.pw,
//               const CustomText(
//                 "Viewed",
//                 style: TextStyle(
//                     color: Color(0xff94A3B8),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           )
//       ],
//     );
//     ;
//   }
// }
