import 'package:flutter/material.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/chat/domain/model/chat_details_model.dart';

import '../../../../shared/widgets/customtext.dart';
import '../../domain/model/chat_rooms_model.dart';

class ChatItem extends StatelessWidget {
  Chats? chat;

  ChatItem({super.key, this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Container(
              alignment: Alignment.bottomRight,
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(
                      // chat!.image ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTg433spHM5uOwh3TSp0gt0uA59czhStXx8sg&s"))),
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff22C55E),
                    border: Border.all(color: Colors.white, width: 3)),
              )),
          12.pw,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomText(
                        chat!.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    CustomText(
                      chat!.createdAt!,
                      style: const TextStyle(
                          color: Color(0xff94A3B8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        chat!.lastMessage!,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xff2E225E), shape: BoxShape.circle),
                      child: CustomText(chat!.messagesCount.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HeaderChatDeatilsScreen extends StatelessWidget {
  final Other? data;

  const HeaderChatDeatilsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 12,
            blurStyle: BlurStyle.outer,
            color: const Color(0xff64748B).withOpacity(0.02),
            offset: const Offset(0, 8))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 24,
              // color: Colors.white,
            ),
          ),
          8.pw,
          CircleAvatar(
            backgroundImage: NetworkImage(data!.image ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6HZJrBtIyi4XEnkjqQvH98pNq56FLhi600vOwJI1RWBYVFlZhGlf2nu5GiYl3FXdKRjA&usqp=CAU"),
            radius: 25,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data?.name ?? "null",
                  overflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: data?.online ?? false
                          ? const Color(0xff22C55E)
                          : Colors.red,
                      radius: 4,
                    ),
                    4.pw,
                    CustomText(
                      data?.online ?? false ? "Online" : "Offline",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff64748B)),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PlateItemInChatDeatilsScreen extends StatelessWidget {
  final ItemChat? item;

  const PlateItemInChatDeatilsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xffEEF2F6))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 55,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: NetworkImage(
                              // item?.image ??
                              "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                          fit: BoxFit.fill)),
                ),
                12.pw,
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        item?.plate ?? "null",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      CustomText(
                        "${item?.currency ?? "SAR"}\t${item?.price}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ])
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
              ),
            )
          ],
        ));
  }
}
