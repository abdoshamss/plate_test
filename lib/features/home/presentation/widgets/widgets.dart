import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/shared/widgets/customtext.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/theme/light_theme.dart';

class CustomRow extends StatelessWidget {
  final String title, subTitle;

  const CustomRow({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        CustomText(
          subTitle,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        )
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = ["message", "call", "whatsapp"];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.ItemDetailsScreen);
      },
      child: Container(
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
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        Image.asset("verify_user".png("icons")),
                        const Spacer(),
                        Image.asset("share".png("icons")),
                        const SizedBox(width: 4,),
                        Image.asset("heart".png("icons"))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                        width: 250,
                        child: Image.asset(
                          "template".png(),
                          fit: BoxFit.fill,
                        )),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          "2",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Image.asset("image".png("icons")),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 250,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              const CustomText(
                                "ARD 3514",
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
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
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
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(),
                  ),
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        const CustomText(
                          "SAR 595,000",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 12),
                        ),
                        const Spacer(),
                        ...List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color:
                                    Color(index == 2 ? 0xffF4FBF7 : 0xffF2F0FA),
                                border: Border.all(
                                    color: Color(
                                        index == 2 ? 0xff22C55E : 0xff2E225E))),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  images[index].svg(),
                                  width: 12,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String? image, text;

  const SearchItem({super.key, this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE0EBFF)),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Image.asset(image?.png("icons") ?? "money".png("icons")),
          CustomText(
            text ?? "Less than SAR 25k",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}

class VerifyItem extends StatelessWidget {
  const VerifyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.15),
          offset: const Offset(0, 2),
          blurRadius: 20,
        )
      ]),
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 110,
            color: const Color(0xffF3F7FE),
            child: Image.asset("verify".png("icons")),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Become a verified user",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    CustomText(
                      "Build Trust",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xff5D5D5D)),
                    ),
                    CustomText(
                      "Get increased visibility",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xff5D5D5D)),
                    ),
                    CustomText(
                      "Unlock Exclusive Awards",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xff5D5D5D)),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    CustomText(
                      "Get Started",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xff1976D2)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward),
          const SizedBox(width: 16)
        ],
      ),
    );
  }
}

class FeatureItemRecentlyDropped extends StatelessWidget {
  final bool isDetails;

  const FeatureItemRecentlyDropped({super.key, this.isDetails = false});

  @override
  Widget build(BuildContext context) {
    final List<String> images = ["message", "call", "whatsapp"];
    final List<String> names = ["CHAT", "CALL", "WHATSAPP"];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(
              color: isDetails ? Colors.white : const Color(0xffE0EBFF)),
          borderRadius: BorderRadius.circular(isDetails ? 0 : 16)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 400,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (isDetails) {
                            Navigator.pop(context);
                          }
                        },
                        child: Image.asset(isDetails
                            ? "back_arrow".png("icons")
                            : "verify_user".png("icons")),
                      ),
                      const Spacer(),
                      Image.asset("share".png("icons")),
                      SizedBox(width: isDetails?8:4,),
                      Image.asset("heart".png("icons"))
                    ],
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
                      const CustomText(
                        "2",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Image.asset("image".png("icons")),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                          CustomText(
                            "ARD 3514",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: isDetails ? 16 : 14),
                          ),
                          if (!isDetails)
                            Row(
                              children: [
                                Image.asset("location".png("icons")),
                                const SizedBox(
                                  width: 4,
                                ),
                                const CustomText(
                                  "Madina",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
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
                if (!isDetails)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(
                      "SAR 595,000",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: isDetails ? 16 : 12),
                    ),
                    if (!isDetails) const Spacer(),
                    if (!isDetails)
                      ...List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color:
                                  Color(index == 2 ? 0xffF4FBF7 : 0xffF2F0FA),
                              border: Border.all(
                                  color: Color(
                                      index == 2 ? 0xff22C55E : 0xff2E225E))),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                images[index].svg(),
                                width: 12,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              CustomText(
                                names[index],
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: index == 2
                                        ? const Color(0xff22C55E)
                                        : null),
                              )
                            ],
                          ),
                        ),
                      )
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
