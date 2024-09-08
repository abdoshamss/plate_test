import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/shared/widgets/customtext.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../home/presentation/widgets/widgets.dart';
import '../../cubit/favorites_cubit.dart';
import '../../cubit/favorites_states.dart';
///// put it in routes

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()..getFavoritesData(),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = FavoritesCubit.get(context);
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
                      "Favourite",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  if (state is GetFavoritesDataSuccessState &&
                      state.data!.data!.item!.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemBuilder: (context, index) {
                          final item = state.data!.data!.item![index];
                          return FeatureItemRecentlyDropped(
                              favoritesItem: item);
                        },
                        itemCount: state.data!.data!.item!.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
