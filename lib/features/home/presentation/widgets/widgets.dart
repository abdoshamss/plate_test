import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/favorites/cubit/favorites_states.dart';
import 'package:plate_test/features/home/cubit/home_cubit.dart';
import 'package:plate_test/shared/widgets/customtext.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../favorites/cubit/favorites_cubit.dart';
import '../../../favorites/domain/model/favorites_model.dart';
import '../../../item_details/domain/model/item_details_model.dart';
import '../../domain/model/home_model.dart';

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
  final RelatedItem? item;

  const FeatureItem({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final List<String> images = ["message", "call", "whatsapp"];
    bool isLiked = false;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.ItemDetailsScreen,
            arguments: item!.id);
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
                        if (item!.userVerified == true)
                          Image.asset("verify_user".png("icons")),
                        const Spacer(),
                        Image.asset("share".png("icons")),
                        4.pw,
                        Image.asset("heart".png("icons"))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    child: SizedBox(
                        width: 200,
                        height: 80,
                        child: Image.network(
                          item!.image!,
                          fit: BoxFit.fill,
                        )),
                  ),
                  16.ph,
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
                  8.ph,
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
                                    item!.location!.city!,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (item!.featured == true)
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
                        CustomText(
                          "${item!.currency}\t${item!.amountString}",
                          style: const TextStyle(
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
  final Budget? budget;
  final Type? type;

  const SearchItem({super.key, this.budget, this.type});

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
          if (type?.image != null) Image.network(type!.image!),
          if (type?.image == null) Image.asset("money".png("icons")),
          CustomText(
            type?.name ?? budget!.name!,
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.VerifyUserScreen);
      },
      child: Container(
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
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
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
            16.pw
          ],
        ),
      ),
    );
  }
}

class FeatureItemRecentlyDropped extends StatelessWidget {
  final bool isDetails;
  final NewItem? item;
  final Item? itemDetails;
  final FavoritesItem? favoritesItem;

  const FeatureItemRecentlyDropped(
      {super.key,
      this.isDetails = false,
      this.item,
      this.itemDetails,
      this.favoritesItem});

  @override
  Widget build(BuildContext context) {
    final List<String> images = ["message", "call", "whatsapp"];
    final List<String> names = ["CHAT", "CALL", "WHATSAPP"];
    bool isLiked = false;
    return GestureDetector(
      onTap: () {
        if (!isDetails) {
          if (item != null) {
            Navigator.pushNamed(context, Routes.ItemDetailsScreen,
                    arguments: ItemDetailsToggle(id: item!.id!))
                .then(
              (value) {
                if (value == true) {
                  context.read<HomeCubit>().getHomeData();
                }
              },
            );
          } else if (favoritesItem != null) {
            Navigator.pushNamed(context, Routes.ItemDetailsScreen,
                    arguments: ItemDetailsToggle(id: favoritesItem!.id!))
                .then(
              (value) {
                if (value == true) {
                  context.read<FavoritesCubit>().getFavoritesData();
                }
              },
            );
          }
        }
      },
      child: Container(
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
                        if (isDetails)
                          GestureDetector(
                            onTap: () {
                              if (isDetails) {
                                Navigator.pop(context, isLiked);
                              }
                            },
                            child: Image.asset("back_arrow".png("icons")),
                          ),
                        if (item?.userVerified ??
                            false ||
                                itemDetails?.user?.userVerified == true ||
                                favoritesItem!.featured == true)
                          Image.asset("verify_user".png("icons")),
                        const Spacer(),
                        Image.asset("share".png("icons")),
                        SizedBox(
                          width: isDetails ? 8 : 4,
                        ),
                        StatefulBuilder(
                          builder: (context, setState2) {
                            return BlocProvider(
                              create: (context) => FavoritesCubit(),
                              child:
                                  BlocConsumer<FavoritesCubit, FavoritesStates>(
                                listener: (context, state) {
                                  if (state is ToggleFAVSuccessState &&
                                      item != null) {
                                    item?.isLiked = !(item!.isLiked!);
                                    setState2(() {});
                                    isLiked = true;
                                  } else if (state is ToggleFAVSuccessState &&
                                      itemDetails != null) {
                                    itemDetails?.isLiked =
                                        !(itemDetails!.isLiked!);
                                    setState2(() {});
                                    isLiked = true;
                                  } else if (state is ToggleFAVSuccessState &&
                                      favoritesItem != null) {
                                    favoritesItem?.isLiked =
                                        !(favoritesItem!.isLiked!);
                                    isLiked = true;
                                    setState2(() {});
                                  }
                                },
                                builder: (context, state) {
                                  final cubit = FavoritesCubit.get(context);
                                  return GestureDetector(
                                    onTap: () {
                                      if (item != null) {
                                        cubit.toggleLike(
                                            id: item!.id.toString());
                                      } else if (itemDetails != null) {
                                        cubit.toggleLike(
                                            id: itemDetails!.id.toString());
                                        if (state is ToggleFAVSuccessState) {
                                          itemDetails?.isLiked =
                                              !(itemDetails!.isLiked!);
                                          setState2(() {});
                                        }
                                      } else if (favoritesItem != null) {
                                        cubit.toggleLike(
                                            id: favoritesItem!.id.toString());
                                        if (state is ToggleFAVSuccessState) {
                                          favoritesItem?.isLiked =
                                              !(favoritesItem!.isLiked!);
                                          setState2(() {});
                                        }
                                      }
                                    },
                                    child: Image.asset(
                                      "heart".png("icons"),
                                      color: item?.isLiked == true ||
                                              itemDetails?.isLiked == true ||
                                              favoritesItem?.isLiked == true
                                          ? LightThemeColors.primary
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                          width: 300,
                          height: 150,
                          child: Image.network(
                            itemDetails?.images![0].image ??
                                item?.image ??
                                favoritesItem!.image!,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  16.ph,
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
                          item?.imagesCount.toString() ??
                              itemDetails?.images!.length.toString() ??
                              favoritesItem!.imagesCount.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w500),
                        ),
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
                            4.ph,
                            CustomText(
                                item?.plate ??
                                    itemDetails?.plate ??
                                    favoritesItem!.plate!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: isDetails ? 16 : 14)),
                            if (!isDetails)
                              Row(
                                children: [
                                  Image.asset("location".png("icons")),
                                  4.pw,
                                  CustomText(
                                    item?.location?.city ??
                                        favoritesItem!.location!.city!,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                          ],
                        ),
                        if (item?.featured == true ||
                            itemDetails?.featured == true ||
                            favoritesItem?.featured == true)
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
                  if (isDetails) 8.ph,
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
                        "${item?.currency ?? itemDetails?.currency ?? favoritesItem?.currency}\t${item?.amountString ?? itemDetails?.amountString ?? favoritesItem?.amountString}",
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
      ),
    );
  }
}
