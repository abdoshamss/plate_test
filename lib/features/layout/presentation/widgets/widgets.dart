import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/Router/Router.dart';

import '../../../../core/extensions/all_extensions.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/extentions.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/layout_cubit.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar(
      {super.key, required this.onTap, required this.currentIndex});

  final Function(int)? onTap;
  final int currentIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final cubit = LayoutCubit.get(context);
    return Container(
      height: 120,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 30,
            offset: const Offset(0, -3),
            spreadRadius: 0,
            color: const Color(0xff000000).withOpacity(.1)),
      ], color: Colors.transparent),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipPath(
            clipper: BottomNavClipper(),
            child: Container(
              height: 88,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: LightThemeColors.primary,
                // gradient: LinearGradient(
                //   colors: LightThemeColors.gradientPrimary,
                // ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navBarItem(
                    "home".png('icons'),
                    "Home",
                    0,
                    "active_home".png('icons'),
                  ),
                  navBarItem(
                    "navigation_heart".png('icons'),
                    "Favourite",
                    1,
                    "active_heart".png('icons'),
                  ),
                  80.pw,
                  navBarItem(
                    "chat".png('icons'),
                    "Messages",
                    2,
                    "active_chat".png('icons'),
                  ),
                  navBarItem(
                    "ticket".png('icons'),
                    "My Ads",
                    3,
                    "active_ticket".png('icons'),
                  ),
                  // navBarItem(
                  //   "add".png("icons"),
                  //   LocaleKeys.navBar_settings.tr(),
                  //   5,
                  //   "add".png("icons"),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: LightThemeColors.primary,
                // gradient: LinearGradient(
                //   colors: LightThemeColors.gradientPrimary,
                // ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  height: 80,
                  width: 80,
                  "add".png("icons"),
                ),
              ),
            ).onTap(
              () async {
                Navigator.pushNamed(context, Routes.AddAdScreen);
                // if (Utils.userModel.is_verified == true) {
                // Utils.token.isEmpty
                //     ? Alerts.bottomSheet(
                //         context,
                //         child: LoginDialog(),
                //       )
                //     : await cubit.checkItem();
                // } else {
                //   Alerts.snack(
                //       text: "verifyAccountFirst".tr(),
                //       state: SnackState.failed);
                // }
              },
            ),
          ),
        ],
      ),
    );
    // ),
  }

  Widget navBarItem(String path, String title, int index, String pathActive,
      {VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<LayoutCubit>().changeTab(index);
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              context.read<LayoutCubit>().tabController.index == index
                  ? Column(
                      children: [
                        Image.asset(
                          pathActive,
                          width: 27,
                          height: 27,
                        ),
                        6.ph,
                        Text(
                          title,
                          style: context.bodySmall?.copyWith(
                            color: LightThemeColors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                        // TextWidget(
                        //   title,
                        //   color: context.primaryColor,
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w600,
                        // ),
                      ],
                    )
                  : Column(
                      children: [
                        Image.asset(
                          path,
                          width: 25,
                          height: 25,
                          // color: context.tertiaryColor,
                        ),
                        6.ph,
                        Text(
                          title,
                          style: context.bodySmall?.copyWith(
                            color: Colors.transparent,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                        // TextWidget(
                        //
                        //
                        //
                        // ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double curveHeight = 60;
    const double curveWidth = 70;

    Path path = Path()
      ..lineTo((size.width - curveWidth) / 2, 0)
      ..relativeQuadraticBezierTo(
          curveWidth / 2, curveHeight / 2, curveWidth, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CompleteAdDialog extends StatelessWidget {
  const CompleteAdDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          16.ph,
          CustomText(
            "resumeAd".tr(),
            color: Colors.black,
          ),
          32.ph,
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  title: "resume".tr(),
                  withBorder: true,
                  buttonColor: context.primaryColor,
                  textColor: Colors.white,
                  borderColor: context.primaryColor,
                ),
              ),
              12.pw,
              Expanded(
                child: ButtonWidget(
                  borderColor: context.primaryColor,
                  textColor: context.primaryColor,
                  withBorder: true,
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  title: "no".tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar(
//       {super.key, required this.onTap, required this.currentIndex});
//   final Function(int)? onTap;
//   final int currentIndex;
//
//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }
//
// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(color: context.background),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           navBarItem(Assets.icons.workspace, LocaleKeys.home.tr(), 0,
//               Assets.icons.workspaceOn),
//           navBarItem(Assets.icons.req, LocaleKeys.navBar_approval.tr(), 1,
//               Assets.icons.reqOn),
//           navBarItem(
//               Assets.icons.notification,
//               LocaleKeys.navBar_notifications.tr(),
//               2,
//               Assets.icons.notificationOn),
//           navBarItem(Assets.icons.settings, LocaleKeys.navBar_settings.tr(), 3,
//               Assets.icons.settingsOn),
//         ],
//       ),
//     );
//     // ),
//   }
//
//   Widget navBarItem(String path, String title, int index, String pathActive,
//       {VoidCallback? onTap}) {
//     return Expanded(
//       child: InkWell(
//         onTap: () {
//           context.read<LayoutCubit>().changeTab(index);
//           setState(() {});
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               context.read<LayoutCubit>().tabController.index == index
//                   ? Column(
//                       children: [
//                         SvgPicture.asset(
//                           pathActive,
//                           width: 27,
//                           height: 27,
//                         ),
//                         6.ph,
//                         Text(
//                           title,
//                           style: context.bodySmall?.copyWith(
//                             color: context.primaryColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                         // TextWidget(
//                         //   title,
//                         //   color: context.primaryColor,
//                         //   fontSize: 14,
//                         //   fontWeight: FontWeight.w600,
//                         // ),
//                       ],
//                     )
//                   : Column(
//                       children: [
//                         SvgPicture.asset(
//                           path,
//                           width: 25,
//                           height: 25,
//                           color: context.tertiaryColor,
//                         ),
//                         6.ph,
//                         Text(
//                           title,
//                           style: context.bodySmall?.copyWith(
//                             color: context.tertiaryColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         )
//                         // TextWidget(
//                         //
//                         //
//                         //
//                         // ),
//                       ],
//                     )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
