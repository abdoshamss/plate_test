import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';

class AdsItem extends StatelessWidget {
  const AdsItem({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      "eye",
      "chat_circle",
      "phone_circle",
      "heart_circle",
      "whatsapp_circle"
    ];
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE0EBFF)),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset("dots".svg()),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                        width: 300,
                        child: Image.asset(
                          "template".png(),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("image".png("icons")),
                      const SizedBox(
                        width: 4,
                      ),
                      const CustomText(
                        "2",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xffEEF2F6),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(2)),
                      child: Row(
                        children: [
                          SvgPicture.asset(icons[index].svg()),
                          const SizedBox(width: 4),
                          const CustomText(
                            "12",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          const CustomText(
                            "V8008",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Row(
                            children: [
                              Image.asset("location".png("icons")),
                              const SizedBox(
                                width: 4,
                              ),
                              const CustomText(
                                "Madina",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        alignment: AlignmentDirectional.topEnd,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: LightThemeColors.gradientPremium),
                            borderRadius: BorderRadius.circular(4)),
                        child: const CustomText(
                          "Premium",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                      )
                    ]),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(
                      "SAR 595,000",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
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
