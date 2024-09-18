import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/Router/Router.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/auth/domain/request/auth_request.dart';
import 'package:plate_test/features/profile/cubit/profile_cubit.dart';
import 'package:plate_test/features/profile/cubit/profile_states.dart';
import 'package:plate_test/shared/widgets/edit_text_widget.dart';

import '../../../../core/general/general_cubit.dart';
import '../../../../core/general/general_repo.dart';
import '../../../../core/services/alerts.dart';
import '../../../../core/services/media/alert_of_media.dart';
import '../../../../core/services/media/my_media.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/Locator.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/autocomplate.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../profile/domain/model/profile_model.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  File? image;
  var data;
  final AuthRequest _authRequest = AuthRequest();

  @override
  void initState() {
    phone = TextEditingController(text: "");
    name = TextEditingController(text: "");
    email = TextEditingController(text: "");
    city = TextEditingController(text: "");
    // getUserData();
    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    name.dispose();
    email.dispose();
    // city.dispose();
    super.dispose();
  }

  late TextEditingController phone;
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController city;
  final formKey = GlobalKey<FormState>();

  // getUserData() async {
  //   data = await DataManager.getUserData();
  //   if (data != null) {
  //     print(data);
  //     print(data["user"]["phone"]);
  //     phone.text = data["user"]["mobile"];
  //     name.text = data["user"]["name"];
  //     email.text = data["user"]["email"];
  //     // phone.text= data["user"]["phone"];
  //   }
  // }
  ProfileUser? userData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) async {
          if (state is GetProfileDataSuccess) {
            phone.text = state.user.mobile!;
            name.text = state.user.name!;
            email.text = state.user.email!;
            city.text = state.user.area!;
            userData = state.user;
          }
          if (state is MobileChanged) {
            // Navigator.pushNamed(context, Routes.LayoutScreen);

            Navigator.pushNamed(
              context,
              Routes.OtpScreen,
              arguments: OtpArguments(
                sendTo: _authRequest.phone ?? "",
                onSubmit: (val) async {
                  // authRequest.phone = Utils.userModel.mobile;
                  // authRequest.code = val;

                  _authRequest.code = val;
                  await ProfileCubit.get(context)
                      .activate(authRequest: _authRequest);
                },
                onReSend: () async {
                  _authRequest.phone = Utils.userModel.phone;
                  await ProfileCubit.get(context)
                      .resendCode(_authRequest.phone ?? "");
                },
              ),
            );
          }

          if (state is EditProfileSuccessState) {
            Navigator.pushNamed(context, Routes.LayoutScreen);
          }
          if (state is EditPasswordSuccessState) {
            Navigator.pushNamed(context, Routes.LayoutScreen);
          }

          if (state is ActivateMobileLoaded) {
            await Utils.saveUserInHive(state.userModel.toJson());
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.LayoutScreen, (route) => false);
          }
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: LightThemeColors.gradient)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Column(
                            children: [
                              const CustomText("Edit account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                              42.ph,
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          image: DecorationImage(
                                              image: image != null
                                                  ? FileImage(image!)
                                                  : NetworkImage(userData
                                                          ?.image ??
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6HZJrBtIyi4XEnkjqQvH98pNq56FLhi600vOwJI1RWBYVFlZhGlf2nu5GiYl3FXdKRjA&usqp=CAU"),
                                              fit: BoxFit.fill))),
                                  GestureDetector(
                                    onTap: () {
                                      Alerts.bottomSheet(context,
                                          backgroundColor:
                                              LightThemeColors.primary,
                                          child: AlertOfMedia(
                                            cameraTap: () async {
                                              image = await MyMedia
                                                  .pickImageFromCamera();
                                              if (image != null) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            galleryTap: () async {
                                              image = await MyMedia
                                                  .pickImageFromGallery();
                                              if (image != null) {
                                                Navigator.pop(context);
                                              }
                                            },
                                          )).then((v) {
                                        setState(() {});
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      fit: BoxFit.fill,
                                      "edit_profile".svg(),
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ],
                              ),
                              32.ph,
                            ],
                          ),
                          const SizedBox()
                        ])),
                Form(
                    key: formKey,
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(24),
                        children: [
                          TextFormFieldWidget(
                            controller: name,
                            backgroundColor:
                                context.primaryColor.withOpacity(.04),
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    vertical: 20, horizontal: 10),
                            type: TextInputType.name,
                            prefixIconWidget: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.person_2_outlined,
                                color: LightThemeColors.textHint,
                                size: 20,
                              ),
                            ),
                            label: 'Name',
                            password: false,
                            onSaved: (e) {
                              _authRequest.name = e;
                            },
                            validator: (v) => Utils.valid.defaultValidation(v),
                            borderRadius: 16,
                          ),
                          16.ph,
                          TextFormFieldWidget(
                            onSaved: (value) => _authRequest.phone = value,
                            backgroundColor: const Color(0xffF8FAFC),
                            type: TextInputType.phone,
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    vertical: 20, horizontal: 10),
                            prefixIconWidget: SvgPicture.asset(
                              "Phone".svg(),
                              fit: BoxFit.scaleDown,
                            ),
                            label: 'Phone Number',
                            hintColor: const Color(0xff94A3B8),
                            validator: (v) => Utils.valid.defaultValidation(v),
                            controller: phone,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  userData?.mobileVerified ?? false
                                      ? "Verified"
                                      : "Unverified",
                                  style: TextStyle(
                                      color: userData?.mobileVerified ?? false
                                          ? const Color(0xff22C55E)
                                          : const Color(0xffFF4747)),
                                )..onTap(() async {
                                    if (phone.text.isNotEmpty) {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.OtpScreen,
                                        arguments: OtpArguments(
                                          sendTo: _authRequest.phone ?? "",
                                          onSubmit: (val) async {
                                            _authRequest.phone =
                                                Utils.userModel.phone;
                                            _authRequest.code = val;
                                            await cubit.activate(
                                              authRequest: _authRequest
                                                ..code = val,
                                            );
                                          },
                                          onReSend: () async {
                                            _authRequest.phone =
                                                Utils.userModel.phone;
                                            await cubit.resendCode(
                                                _authRequest.phone ?? "");
                                          },
                                        ),
                                      );
                                    }
                                  }),
                                8.pw,
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color(0xff94A3B8),
                                ),
                              ],
                            ),
                          ),
                          16.ph,
                          TextFormFieldWidget(
                            controller: email,
                            backgroundColor:
                                context.primaryColor.withOpacity(.04),
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    vertical: 20, horizontal: 10),
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            password: false,
                            onSaved: (e) {
                              _authRequest.email = e;
                            },
                            prefixIconWidget: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.email_outlined,
                                color: LightThemeColors.textHint,
                                size: 20,
                              ),
                            ),
                            validator: (v) => Utils.valid.emailValidation(v),
                            borderRadius: 16,
                          ),
                          16.ph,
                          CustomAutoCompleteTextField<AreaModel>(
                            controller: city,
                            prefixIconWidget: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.flag_outlined,
                                color: LightThemeColors.textHint,
                                size: 20,
                              ),
                            ),
                            label: "City",
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    vertical: 20, horizontal: 10),

                            onChanged: (value) {
                              _authRequest.areaID = value.id;
                            },
                            function: (s) async =>
                                await locator<GeneralRepo>().getAreas() ?? [],
                            validator: (v) => Utils.valid.defaultValidation(v),
                            showSufix: true,
                            localData: false,
                            showLabel: false,

                            itemAsString: (a) => a.name ?? '',

                            // border: InputBorder.none,
                          ),
                          24.ph,
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.ChangePasswordScreen,
                                    arguments:
                                        (String oldpass, String newpass) async {
                                  _authRequest.password = oldpass;
                                  _authRequest.password_confirmation = newpass;
                                  // _authRequest.phone = Utils.userModel.phone;
                                  _authRequest.phone = userData?.mobile;
                                  final res = await cubit.editPasswordCubit(
                                      authRequest: _authRequest
                                      // ..password = oldpass
                                      // ..newPassword = newpass,
                                      );

                                  if (res == true) {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.LayoutScreen,
                                    );
                                  }
                                });
                              },
                              child: const CustomText(
                                "Change Password",
                                color: Color(0xff22C55E),
                                fontSize: 20,
                                weight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ))
              ],
            )),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24),
              child: ButtonWidget(
                title: 'Edit Profile',
                withBorder: true,

                gradient: const LinearGradient(
                  colors: LightThemeColors.gradientPrimary,
                ),
                textColor: Colors.white,
                borderColor: context.primaryColor,
                width: double.infinity,
                fontSize: 18,
                fontweight: FontWeight.bold,
                // padding: const EdgeInsets.symmetric(horizontal: 15),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    _authRequest.areaID ??= userData?.areaId;
                    if (image != null) _authRequest.image = image!.path;
                    cubit.editProfileCubit(authRequest: _authRequest);
                  }
                  // AuthRequest registerModel = AuthRequest(
                  //   password: password.text,
                  //   phone: phone.text,
                  // );
                  // if (formKey.currentState!.validate()) {
                  //   final response = await cubit.login(
                  //       loginRequestModel: registerModel);
                  //   if (response == true) {
                  //     Navigator.pushNamedAndRemoveUntil(
                  //         context, Routes.LayoutScreen, (route) => false);
                  //   } else if (response == false) {
                  //     Alerts.snack(
                  //         text: 'You have to activate your account'.tr(),
                  //         state: SnackState.failed);
                  //     Navigator.pushNamed(
                  //       context,
                  //       Routes.OtpScreen,
                  //       arguments: OtpArguments(
                  //           sendTo: phone.text,
                  //           onSubmit: (s) async {
                  //             registerModel.code = s;
                  //             final res = await cubit.activate(
                  //                 registerRequestModel: registerModel);
                  //
                  //             if (res == true) {
                  //               Navigator.pushNamedAndRemoveUntil(
                  //                   context,
                  //                   Routes.LayoutScreen,
                  //                       (route) => false);
                  //             }
                  //           },
                  //           onReSend: () async {
                  //             await cubit
                  //                 .resendCode(registerModel.phone ?? '');
                  //           },
                  //           init: false),
                  //     );
                  //   }
                  // }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
