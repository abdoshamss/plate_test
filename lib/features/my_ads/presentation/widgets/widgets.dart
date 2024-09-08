import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/my_ads/cubit/my_ads_cubit.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/my_ads_states.dart';
import '../../domain/model/my_ads_model.dart';

class AdsItems extends StatelessWidget {
  final String filter;

  const AdsItems({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      "eye",
      "chat_circle",
      "phone_circle",
      "heart_circle",
      "whatsapp_circle"
    ];
    List<MyAdsItem>? list;
    return BlocProvider(
      create: (context) => MyAdsCubit()..getMyAdsData(filter),
      child: BlocConsumer<MyAdsCubit, MyAdsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GetMyAdsDataSuccess) {
            list = state.date?.data?.items;

            return ListView.separated(
              itemCount: list!.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) => 8.ph,
              itemBuilder: (context, index) {
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: SizedBox(
                                    width: 300,
                                    height: 150,
                                    child: Image.network(
                                      list![index].image!,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 2),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("image".png("icons")),
                                  4.pw,
                                  CustomText(
                                    list![index].images!.length.toString(),
                                    style: const TextStyle(
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
                                (i) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffEEF2F6),
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(icons[i].svg()),
                                      const SizedBox(width: 4),
                                      CustomText(
                                        list![index].imagesCount!.toString(),
                                        style: const TextStyle(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      4.ph,
                                      CustomText(
                                        list![index].plate!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset("location".png("icons")),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          CustomText(
                                            list![index].location!.text!,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (list![index].featured == true)
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      alignment: AlignmentDirectional.topEnd,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: LightThemeColors
                                                  .gradientPremium),
                                          borderRadius:
                                              BorderRadius.circular(4)),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CustomText(
                                  "${list![index].currency}\t${list![index].amount}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
