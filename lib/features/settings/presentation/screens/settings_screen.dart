import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/Router/Router.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/core/utils/utils.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/settings_cubit.dart';
import '../../cubit/settings_states.dart';

///// put it in routes
///  import '../../features/settings/presentation/screens/Settings.dart';
///

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool isNotify = Utils.isNotify;

  final List<String> types = [
    "Account Settings",
    "App Settings",
  ];
  final List<String> typesNames = [
    "Account information",
    "Wallet",
    // "Link Account",
    "Language",
    "Push notifications",
  ];
  final List<String> typesIcons = [
    "account",
    "payment",
    // "link",
    "lang",
    "notifications_profile",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = SettingsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: LightThemeColors.gradient)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        const CustomText(
                          "Settings",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        SvgPicture.asset("dots_white".svg())
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(6, (index) {
                        if (index == 0 || index == 3) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              types[index == 0 ? 0 : 1],
                              style: const TextStyle(
                                  color: Color(0xff94A3B8),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              if (index == 1) {
                                Navigator.pushNamed(
                                    context, Routes.AccountInformationScreen);
                              } else if (index == 2) {
                                Navigator.pushNamed(
                                    context, Routes.WalletScreen);
                              } else if (index == 4) {
                                Navigator.pushNamed(context, Routes.LangScreen);
                              } else if (index == 5) {
                                // Navigator.pushNamed(
                                //     context, Routes.PushNotificationsScreen);
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(typesIcons[index < 3
                                                ? index - 1
                                                : index - 2]
                                            .svg()),
                                        16.pw,
                                        Expanded(
                                          child: CustomText(
                                            typesNames[index < 3
                                                ? index - 1
                                                : index - 2],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (index != 5)
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xff94A3B8),
                                    ),
                                  if (index == 5)
                                    GestureDetector(
                                      onTap: () {
                                        isNotify = !isNotify;
                                        Utils.isNotify = isNotify;
                                        cubit.notificationToggle();

                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: isNotify
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        width: 50,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: isNotify
                                                ? LightThemeColors.primary
                                                : Colors.white,
                                            border: Border.all(),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                    left: Radius.circular(1000),
                                                    right:
                                                        Radius.circular(1000))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1),
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: isNotify
                                                ? Colors.white
                                                : LightThemeColors.primary,
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
