import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/features/chat/presentation/screens/chat_screen.dart';
import 'package:plate_test/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:plate_test/features/my_ads/presentation/screens/my_ads_screen.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../cubit/layout_cubit.dart';
import '../../cubit/layout_states.dart';
import '../widgets/widgets.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key, this.index});

  final int? index;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..initTabBar(this, widget.index ?? 0),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: TabBarView(
                controller: cubit.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  HomeScreen(),
                  FavoritesScreen(),
                  ChatScreen(),
                  MyAdsScreen()
                ],
              ),
              bottomNavigationBar: CustomBottomNavBar(
                currentIndex: cubit.tabController.index,
                onTap: cubit.changeTab,
              ),
              extendBody: true,
            ),
          );
        },
      ),
    );
  }
}
