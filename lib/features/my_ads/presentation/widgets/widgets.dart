import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/data_source/hive_helper.dart';
import 'package:plate_test/core/general/general_repo.dart';
import 'package:plate_test/core/services/alerts.dart';
import 'package:plate_test/core/utils/Locator.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/my_ads/cubit/my_ads_cubit.dart';
import 'package:plate_test/shared/widgets/button_widget.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/my_ads_states.dart';
import '../../domain/model/my_ads_model.dart';

class AdsItems extends StatelessWidget {
  final String filter;

  const AdsItems({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    int? userId;

    List<MyAdsItem>? list;
    return BlocProvider(
      create: (context) => MyAdsCubit()..getMyAdsData(filter),
      child: BlocConsumer<MyAdsCubit, MyAdsStates>(
        listener: (context, state) async {
          if (state is GetMyAdsDataSuccess) {
            final data = await DataManager.getUserData();
            userId = data["user"]["id"];
            print("User Id is $userId");
          }
        },
        builder: (context, state) {
          if (state is GetMyAdsDataSuccess) {
            list = state.date?.data?.items;

            return list!.isEmpty
                ? const Center(
                    child: Text("No Ads"),
                  )
                : ListView.separated(
                    itemCount: list!.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) => 8.ph,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.ItemDetailsScreen,
                                arguments: ItemDetailsToggle(
                                    id: list![index].id!,
                                    isMYAd: (list![index].id!) == userId));
                          },
                          child: AdsItem(item: list![index]));
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

class AdsItem extends StatelessWidget {
  final MyAdsItem? item;

  AdsItem({super.key, required this.item});

  final List<String> icons = [
    "eye",
    "chat_circle",
    "phone_circle",
    "heart_circle",
    "whatsapp_circle"
  ];

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {
                      Alerts.bottomSheet(context,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Column(
                              children: List.generate(
                                  2,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: ButtonWidget(
                                          onTap: () {
                                            if (index == 0) {
                                              locator<GeneralRepo>()
                                                  .markAsSold("2");
                                            }
                                          },
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60,
                                          buttonColor:
                                              index == 1 ? Colors.white : null,
                                          textColor: index == 1
                                              ? const Color(0xff5C44BB)
                                              : Colors.white,
                                          withBorder: index == 1 ? true : false,
                                          gradient: index == 0
                                              ? const LinearGradient(
                                                  colors: LightThemeColors
                                                      .gradientPrimary)
                                              : null,
                                          title: index == 0
                                              ? "Mark as Sold"
                                              : "Deactivate",
                                        ),
                                      )),
                            ),
                          ));
                    },
                    child: SvgPicture.asset("dots".svg()),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                        width: 300,
                        height: 150,
                        child: Image.network(
                          item!.image!,
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
                      4.pw,
                      CustomText(
                        item!.images!.length.toString(),
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
                      margin: const EdgeInsets.symmetric(vertical: 8),
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
                            item!.imagesCount!.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          4.ph,
                          CustomText(
                            item!.plate!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Row(
                            children: [
                              Image.asset("location".png("icons")),
                              const SizedBox(
                                width: 4,
                              ),
                              CustomText(
                                item!.location!.text!,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      if (item!.featured == true)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(
                      "${item!.currency}\t${item!.stringAmount}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 12),
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
