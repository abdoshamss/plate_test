import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/shared/widgets/edit_text_widget.dart';

import '../../../../shared/widgets/customtext.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          /// Headerrrrr
          Container(
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
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6HZJrBtIyi4XEnkjqQvH98pNq56FLhi600vOwJI1RWBYVFlZhGlf2nu5GiYl3FXdKRjA&usqp=CAU"),
                  radius: 25,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        "Adel Shakal",
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xff22C55E),
                            radius: 4,
                          ),
                          4.pw,
                          const CustomText(
                            "Online",
                            style: TextStyle(
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
          ),

          /// Plate Itemmmmmmmmmm
          Container(
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
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6HZJrBtIyi4XEnkjqQvH98pNq56FLhi600vOwJI1RWBYVFlZhGlf2nu5GiYl3FXdKRjA&usqp=CAU"),
                                fit: BoxFit.fill)),
                      ),
                      12.pw,
                      const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "V8008",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            CustomText(
                              "SAR 595,000",
                              style: TextStyle(
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
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const CustomText(
                  "Today",
                  style: TextStyle(
                      color: Color(0xff94A3B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                12.ph,
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const CustomText(
                    "04:00",
                    style: TextStyle(
                        color: Color(0xff94A3B8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  ...List.generate(
                    3,
                    (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          margin: const EdgeInsetsDirectional.only(
                            top: 4,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xff2E225E)),
                          child: const CustomText(
                            "Hi",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.ph,
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
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: TextFormFieldWidget(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            hintText: "Write a message",
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a message";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
