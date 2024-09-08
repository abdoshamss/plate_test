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

class _MyAdsScreenState extends State<MyAdsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAdsCubit(),
      child: BlocConsumer<MyAdsCubit, MyAdsStates>(
        listener: (context, state) {},
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
                  TabBar(
                      automaticIndicatorColorAdjustment: true,
                      labelStyle: const TextStyle(color: Colors.white),
                      padding: const EdgeInsets.all(8),
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                              colors: LightThemeColors.gradientPrimary)),
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: _tabController,
                      onTap: (i) {
                        print(i);
                      },
                      tabs: const [
                        Tab(
                          child: Text(
                            "All Ads",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Sold",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ]),
                  Expanded(
                    child:
                        TabBarView(controller: _tabController, children: const [
                      AdsItems(
                        filter: "all",
                      ),
                      AdsItems(
                        filter: "sold",
                      ),
                    ]),
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
