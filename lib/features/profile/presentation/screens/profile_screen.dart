import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plate_test/core/Router/Router.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/core/utils/utils.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';

///// put it in routes
///  import '../../features/profile/presentation/screens/Profile.dart';
///

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> types = [
    "General",
    "Support",
  ];
  final List<String> typesNames = [
    "Settings",
    "Change Country",
    "My vouchers",
    "About Plate",
    "Get help",
    "Privacy policy",
    "Sign out",
    "Delete account",
  ];
  final List<String> typesIcons = [
    "settinges_profile",
    "earth_profile",
    "tickets_profile",
    "info_profile",
    "questions_profile",
    "privacy_profile",
    "sign_out_profile",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) async {
          if (state is LogOutSuccess || state is DeleteAccountSuccess) {
            await Utils.deleteUserData();
            print(Utils.token);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.splashScreen, (route) => false);
          }
          if (state is GetProfileDataSuccess) {
            Utils.isNotify = state.user.notify ?? false;
          }
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: state is GetProfileDataSuccess
                  ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: LightThemeColors.gradient)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Expanded(
                                child: Column(
                                  children: [
                                    const CustomText("Profile",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18)),
                                    42.ph,
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          image: DecorationImage(
                                              image: NetworkImage(state
                                                      .user.image ??
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6HZJrBtIyi4XEnkjqQvH98pNq56FLhi600vOwJI1RWBYVFlZhGlf2nu5GiYl3FXdKRjA&usqp=CAU"),
                                              fit: BoxFit.fill)),
                                    ),
                                    24.ph,
                                    CustomText(
                                      state.user.name ?? "User Name",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                    4.ph,
                                    CustomText(
                                      state.user.mobile ?? "+92 3036349520",
                                      style: const TextStyle(
                                          color: Color(0xffC6C3FF),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    8.ph,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(10, (index) {
                              if (index == 0 || index == 4) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                                          context, Routes.SettingsScreen);
                                    } else if (index == 5) {
                                      Navigator.pushNamed(
                                          context, Routes.AboutUsScreen);
                                    } else if (index == 6) {
                                      Navigator.pushNamed(
                                          context, Routes.ContactUs);
                                    } else if (index == 7) {
                                      Navigator.pushNamed(
                                          context, Routes.PolicyScreen);
                                    } else if (index == 8) {
                                      await cubit.logOut(Utils.uuid);
                                    } else if (index == 9) {
                                      await cubit.deleteAccount();
                                      debugPrint("Account Deleted");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              if (index != 9)
                                                SvgPicture.asset(typesIcons[
                                                        index < 5
                                                            ? index - 1
                                                            : index - 2]
                                                    .svg()),
                                              if (index == 9)
                                                Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: const Color(
                                                            0xffFFF0F0)),
                                                    child: const Icon(
                                                        Icons.delete_forever,
                                                        size: 20,
                                                        color:
                                                            Color(0xffFF4747))),
                                              16.pw,
                                              Expanded(
                                                child: CustomText(
                                                  typesNames[index < 5
                                                      ? index - 1
                                                      : index - 2],
                                                  style: TextStyle(
                                                      color: index > 7
                                                          ? const Color(
                                                              0xffFF4747)
                                                          : null,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Color(0xff94A3B8),
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
                    )
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
