import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/services/map.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/home/presentation/widgets/widgets.dart';
import 'package:plate_test/features/item_details/presentation/widgets/widgets.dart';
import 'package:plate_test/shared/widgets/customtext.dart';

import '../../cubit/item_details_cubit.dart';
import '../../cubit/item_details_states.dart';

///// put it in routes
///  import '../../features/item_details/presentation/screens/ItemDetails.dart';

class ItemDetailsScreen extends StatefulWidget {
  final int id;
  final bool isMYAd;

  const ItemDetailsScreen({super.key, required this.id, this.isMYAd = false});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> titles = [
    "Plate Number",
    "Plate Code",
    "Plate Style",
    "Posted on",
  ];
  final List<String> subTitles = [
    "3514",
    "ARD",
    "New Design",
    "28/01/2024",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailsCubit()..getItemDetailsData(widget.id),
      child: BlocConsumer<ItemDetailsCubit, ItemDetailsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = ItemDetailsCubit.get(context);
          return Scaffold(
            body: state is GetItemDetailsDataSuccess
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (!widget.isMYAd)
                            FeatureItemRecentlyDropped(
                              isDetails: true,
                              itemDetails: state.data.item,
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                myDivider(),
                                const CustomText(
                                  "Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                8.ph,
                                ...List.generate(
                                    4,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                titles[index],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color(0xff64748B)),
                                              ),
                                              CustomText(
                                                state.data.item!.details!
                                                    .detailsItem[index]!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )),
                                myDivider(),
                                const CustomText(
                                  "Description",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                12.ph,
                                CustomText(
                                  state.data.item!.description!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff64748B)),
                                ),
                                myDivider(),
                                const CustomText(
                                  "Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Image.asset("location".png("icons")),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      CustomText(
                                        state.data.item!.location!.city!,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: MapItem(
                                    lightMode: true,
                                    lat: state.data.item!.location!.lat!
                                        .toDouble(),
                                    lng: state.data.item!.location!.lng!
                                        .toDouble(),
                                  ),
                                ),
                                myDivider(),
                                const CustomText(
                                  "Posted By",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff9A9A9A)),
                                ),
                                8.ph,
                                PostedByItem(
                                  user: state.data.item?.user,
                                ),
                                myDivider(),
                                const CustomText(
                                  "Similar Ads",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                16.ph,
                                SizedBox(
                                  height: context.height / 3.1,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 8,
                                    ),
                                    itemBuilder: (context, index) =>
                                        FeatureItem(
                                      item: state.data.related![index],
                                    ),
                                    itemCount: state.data.related!.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          16.ph,
                        ],
                      ),
                    ),
                  )
                : null,
            bottomNavigationBar:
                // widget.isMYAd
                //     ? Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 24, vertical: 16),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: List.generate(
                //               2,
                //               (index) => Padding(
                //                     padding: const EdgeInsets.only(bottom: 12.0),
                //                     child: ButtonWidget(
                //                       onTap: () {
                //                         if (index == 0) {
                //                           locator<GeneralRepo>().markAsSold("2");
                //                         }
                //                       },
                //                       width: MediaQuery.of(context).size.width,
                //                       height: 60,
                //                       buttonColor: index == 1 ? Colors.white : null,
                //                       textColor: index == 1
                //                           ? const Color(0xff5C44BB)
                //                           : Colors.white,
                //                       withBorder: index == 1 ? true : false,
                //                       gradient: index == 0
                //                           ? const LinearGradient(
                //                               colors:
                //                                   LightThemeColors.gradientPrimary)
                //                           : null,
                //                       title: index == 0
                //                           ? "Mark as Sold"
                //                           : "Deactivate",
                //                     ),
                //                   )),
                //         ),
                //       ) :
                const UserBottomNavigation(),
          );
        },
      ),
    );
  }
}
