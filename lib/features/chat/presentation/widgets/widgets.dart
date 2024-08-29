import 'package:flutter/material.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../shared/widgets/customtext.dart';
import '../../domain/model/chat_model.dart';

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
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(chat!.image!))),
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
