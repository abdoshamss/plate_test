import 'package:flutter/material.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../shared/widgets/customtext.dart';

Widget myDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Divider(),
  );
}

class PostedByItem extends StatelessWidget {
  const PostedByItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6HZJrBtIyi4XEnkjqQvH98pNq56FLhi600vOwJI1RWBYVFlZhGlf2nu5GiYl3FXdKRjA&usqp=CAU"))),
        ),
        4.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  "Adel Shakal",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                6.pw,
                Image.asset("verify_icon".png("icons"))
              ],
            ),
            const CustomText(
              "view profile",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            )
          ],
        )
      ],
    );
  }
}
