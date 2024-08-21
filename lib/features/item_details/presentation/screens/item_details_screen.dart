import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/home/presentation/widgets/widgets.dart';
import 'package:plate_test/features/item_details/presentation/widgets/widgets.dart';
import 'package:plate_test/shared/widgets/customtext.dart';
import '../../cubit/item_details_cubit.dart';
import '../../cubit/item_details_states.dart';
///// put it in routes
///  import '../../features/item_details/presentation/screens/ItemDetails.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

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
  final List<String> images = ["message", "call", "whatsapp"];
  final List<String> names = ["CHAT", "CALL", "WHATSAPP"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailsCubit(),
      child: BlocConsumer<ItemDetailsCubit, ItemDetailsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = ItemDetailsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const FeatureItemRecentlyDropped(
                      isDetails: true,
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
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          8.ph,
                          ...List.generate(
                              4,
                              (index) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
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
                                          subTitles[index],
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
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          12.ph,
                          const CustomText(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fermentum, magna vel pellentesque vulputate, sem lacus tempus eros, nec vehicula lacus quam ut tellus.",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xff64748B)),
                          ),
                          myDivider(),
                          const CustomText(
                            "Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
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
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          24.ph,
                          myDivider(),
                          const CustomText(
                            "Posted By",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xff9A9A9A)),
                          ),
                          8.ph,
                          const PostedByItem(),
                          myDivider(),
                          const CustomText(
                            "Similar Ads",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          16.ph,
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.45,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 8,
                              ),
                              itemBuilder: (context, index) =>
                                  const FeatureItem(),
                              itemCount: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.ph,
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding:   const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
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
                            color: Color(
                                index == 2 ? 0xff22C55E : 0xff2E225E))),
                                        child: Row(

                      children: [
                        SvgPicture.asset(
                          images[index].svg(),
                          width: 24,fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          names[index],
                          style:   TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700,color:  index == 2 ? const Color(0xff22C55E) :null),
                        )
                      ],
                                        ),
                                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
