import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../shared/widgets/customtext.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6HZJrBtIyi4XEnkjqQvH98pNq56FLhi600vOwJI1RWBYVFlZhGlf2nu5GiYl3FXdKRjA&usqp=CAU"),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  "Discount Available",
                  overflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const CustomText(
                  "We recommend a 5% discount for Plate",
                  overflow: TextOverflow.ellipsis,
                  maxLine: 2,
                  style: TextStyle(
                      color: Color(0xff64748B),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                Row(
                  children: [
                    SvgPicture.asset("clock_notification".svg(),
                        fit: BoxFit.fill),
                    2.pw,
                    const CustomText(
                      "09:00 AM",
                      overflow: TextOverflow.ellipsis,
                      maxLine: 1,
                      style: TextStyle(
                          color: Color(0xff94A3B8),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
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
