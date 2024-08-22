import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/my_ads_cubit.dart';
import '../../cubit/my_ads_states.dart';
import '../widgets/widgets.dart';

///// put it in routes
///  import '../../features/my_ads/presentation/screens/MyAds.dart';
/// static const String MyAdsScreen = "MyAdsScreen";
//  case Routes.MyAdsScreen:
// return CupertinoPageRoute(
//     settings: routeSettings,
//     builder: (_) {
//       return const MyAdsScreen();
//     });
class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> names = ["Filter", "All Ads", "Sold"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAdsCubit(),
      child: BlocConsumer<MyAdsCubit, MyAdsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = MyAdsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: LightThemeColors.gradient)),
                    child: const CustomText(
                      "My Ads",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: List.generate(
                            3,
                            (index) => Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsetsDirectional.only(
                                  end: 16, top: 16, bottom: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xffEEF2F6))),
                              child: Row(
                                children: [
                                  if (index == 0)
                                    Image.asset("filter_grey".png("icons")),
                                  if (index == 0) 8.pw,
                                  CustomText(
                                    names[index],
                                    style: const TextStyle(
                                        color: Color(0xff64748B),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) => const AdsItem(),
                      itemCount: 5,
                    ),
                  ),
                  16.ph
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
