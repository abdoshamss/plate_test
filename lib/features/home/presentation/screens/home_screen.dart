import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/theme/light_theme.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/core/utils/utils.dart';
import 'package:plate_test/features/home/presentation/widgets/widgets.dart';
import 'package:plate_test/shared/widgets/edit_text_widget.dart';

import '../../../../core/Router/Router.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController search = TextEditingController();
  final List<String> namesSearchItem = ["Price Dropped", "Negotiable"];
  final List<String> iconsSearchItem = ["fire", "sms"];
  int sliderIndex = 0;

// Timer? timer;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: LightThemeColors.gradient)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.ProfileScreen);
                                  },
                                  child: SvgPicture.asset(
                                    'user'.svg(),
                                  ),
                                ),
                                Image.asset("home_logo".png("icons")),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.NotificationsScreen);
                                  },
                                  child: SvgPicture.asset(
                                    'notifications'.svg(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          TextFormFieldWidget(
                            onChanged: (value) {
                              // cubit.search(value);
                            },
                            // onSaved: (value) => _authRequest.phone = value,
                            backgroundColor: const Color(0xff5237C0),
                            filledColor: const Color(0xff5237C0),

                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    vertical: 16, horizontal: 8),
                            prefixIconWidget: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Image.asset(
                                color: Colors.white,
                                "search".png("icons"),
                              ),
                            ),
                            suffixIconWidget: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                color: Colors.white,
                                "filters".png("icons"),
                              ),
                            ),

                            hintText: "Search for plate number",
                            hintColor: const Color(0xff94A3B8),
                            validator: (v) => Utils.valid.defaultValidation(v),
                            controller: search,
                            borderRadius: 16,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    if (state is GetHomeDataSuccess)
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32))),
                        child: Column(
                          children: [
                            if (state.data.sliders!.isNotEmpty)
                              StatefulBuilder(
                                  builder: (context, setState0) => Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          CarouselSlider(
                                              items: state.data.sliders!
                                                  .map((e) => Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              e.image!),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      )))
                                                  .toList(),
                                              options: CarouselOptions(
                                                height: 200,
                                                aspectRatio: 16 / 9,
                                                viewportFraction: 1,
                                                initialPage: 0,
                                                enableInfiniteScroll: true,
                                                autoPlay: true,
                                                autoPlayInterval:
                                                    const Duration(seconds: 2),
                                                autoPlayAnimationDuration:
                                                    const Duration(
                                                        milliseconds: 1000),
                                                autoPlayCurve:
                                                    Curves.fastOutSlowIn,
                                                enlargeCenterPage: true,
                                                enlargeFactor: 1,
                                                onPageChanged: (index, reason) {
                                                  sliderIndex = index;
                                                  setState0(() {});
                                                },
                                                scrollDirection:
                                                    Axis.horizontal,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                state.data.sliders!.length,
                                                (index) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 3),
                                                  child: CircleAvatar(
                                                      radius:
                                                          sliderIndex == index
                                                              ? 9
                                                              : 5,
                                                      backgroundColor:
                                                          sliderIndex == index
                                                              ? LightThemeColors
                                                                  .primary
                                                              : Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                            16.ph,

                            /// Featured Items Hereeeeeee
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 16.0),
                            //   child: CustomRow(
                            //     title: 'Featured',
                            //     subTitle: 'View all',
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height / 3.45,
                            //   child: ListView.separated(
                            //     shrinkWrap: true,
                            //     scrollDirection: Axis.horizontal,
                            //     separatorBuilder: (context, index) =>
                            //         const SizedBox(
                            //       width: 8,
                            //     ),
                            //     itemBuilder: (context, index) =>
                            //         const FeatureItem(),
                            //     itemCount: 5,
                            //   ),
                            // ),
                            if (state.data.budgets!.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: CustomRow(
                                    title: 'Search by Budget',
                                    subTitle: 'View all'),
                              ),
                            if (state.data.budgets!.isNotEmpty)
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 7,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 8,
                                  ),
                                  itemBuilder: (context, index) => SearchItem(
                                    budget: state.data.budgets![index],
                                  ),
                                  itemCount: state.data.budgets!.length,
                                ),
                              ),

                            /// Verifyyy Itemmmm
                            const VerifyItem(),
                            if (state.data.types!.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: CustomRow(
                                  title: 'Search by Ad type',
                                  subTitle: 'View all',
                                ),
                              ),
                            if (state.data.types!.isNotEmpty)
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 7,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                  // padding: EdgeInsetsDirectional.only(end: 100),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 8,
                                  ),
                                  itemBuilder: (context, index) => SearchItem(
                                    type: state.data.types![index],
                                  ),
                                  itemCount: state.data.types!.length,
                                ),
                              ),

                            if (state.data.newItems!.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: CustomRow(
                                  title: 'Recently Dropped',
                                  subTitle: 'View all',
                                ),
                              ),
                            if (state.data.newItems!.isNotEmpty)
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 8,
                                ),
                                itemBuilder: (context, index) =>
                                    FeatureItemRecentlyDropped(
                                  item: state.data.newItems![index],
                                ),
                                itemCount: state.data.newItems!.length,
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
