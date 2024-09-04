import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../shared/widgets/customtext.dart';
import '../../domain/model/item_details_model.dart';

Widget myDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Divider(),
  );
}

class PostedByItem extends StatelessWidget {
  final User? user;

  const PostedByItem({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                user!.image!,
              ))),
        ),
        4.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  user!.name!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                6.pw,
                if (user!.userVerified!) Image.asset("verify_icon".png("icons"))
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

class UserBottomNavigation extends StatelessWidget {
  const UserBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = ["message", "call", "whatsapp"];
    final List<String> names = ["CHAT", "CALL", "WHATSAPP"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(index == 2 ? 0xffF4FBF7 : 0xffF2F0FA),
                border: Border.all(
                    color: Color(index == 2 ? 0xff22C55E : 0xff2E225E))),
            child: Row(
              children: [
                SvgPicture.asset(
                  images[index].svg(),
                  width: 24,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  names[index],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: index == 2 ? const Color(0xff22C55E) : null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
