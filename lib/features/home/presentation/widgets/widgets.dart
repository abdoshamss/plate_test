import 'package:flutter/material.dart';
import 'package:plate_test/shared/widgets/customtext.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          "المميزات",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        CustomText(
          "عرض الكل",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        )
      ],
    );
  }
}
