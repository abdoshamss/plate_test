import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/Router/Router.dart';
import '../../../../../core/extensions/all_extensions.dart';
import '../../../../../core/services/alerts.dart';
import '../../../../../core/theme/light_theme.dart';
import '../../../../../core/utils/extentions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../shared/back_widget.dart';
import '../../../../../shared/widgets/button_widget.dart';
import '../../../../../shared/widgets/customtext.dart';
import '../../../../../shared/widgets/edit_text_widget.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';
import '../../../domain/request/auth_request.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController(text: "0512341234");
  TextEditingController password = TextEditingController(text: "123456");
  late final AuthRequest _authRequest;
  final List<String> names = ["Google", "Apple"];
  final List<String> icons = ["google", "apple"];
  final formKey = GlobalKey<FormState>();
  AuthRequest authRequest = AuthRequest();

  @override
  void initState() {
    getFcmToken();

    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    _authRequest = AuthRequest();
    super.dispose();
  }

  Future<void> getFcmToken() async => await Utils.getFCMToken();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..cancheckbio(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) async {
          final cubit = AuthCubit.get(context);
          if (state is LoginSuccessState) {
            bool isBiometricState =
                await Utils.dataManager.getbiometric() ?? false;
            if (isBiometricState == true) {
              // await cubit.checkBiometric(value)
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.LayoutScreen,
                (route) => false,
              );
            } else if (isBiometricState == false &&
                cubit.canCheckBiometrics == true) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.fingerprintScreen,
                (route) => false,
              );
            }
          } else if (state is NeedActivate) {
            Alerts.snack(
              text: "need_activate_message".tr(),
              state: SnackState.success,
            );
            Navigator.pushNamed(
              context,
              Routes.OtpScreen,
              arguments: OtpArguments(
                sendTo: authRequest.phone ?? "",
                onSubmit: (vaue) async {
                  await AuthCubit.get(context).activate(
                    registerRequestModel: authRequest..code = vaue,
                  );
                },
                onReSend: () async {
                  await AuthCubit.get(context)
                      .resendCode(authRequest.phone ?? "");
                },
              ),
            );
          } else if (state is ActivateCodeSuccessState) {
            // await Utils.saveUserInHive(state.userModel.toJson());
            // await Utils.saveUserInHive(state.userModel.toJson());
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.LayoutScreen, (route) => false);
          }
          // else if (state is NeedAddArea) {
          //   Navigator.pushNamedAndRemoveUntil(
          //       context, Routes.ChooseCountryScreen, (route) => false);
          // }
        },
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leadingWidth: 80,
              leading: const BackWidget(
                size: 26,
                color: Colors.black,
                icon: Icons.close_outlined,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    24.ph,
                    const CustomText(
                      "Sign in to Plate",
                      fontSize: 32,
                      color: Colors.black,
                      weight: FontWeight.w700,
                    ),
                    8.ph,
                    const CustomText(
                      'Welcome back! Please enter your details.',
                      fontSize: 16,
                      color: Color(0xff64748B),
                      weight: FontWeight.w500,
                    ),

                    24.ph,
                    TextFormFieldWidget(
                      onSaved: (value) => _authRequest.phone = value,
                      backgroundColor: const Color(0xffF8FAFC),
                      type: TextInputType.phone,
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      prefixIconWidget: SvgPicture.asset(
                        "Phone".svg(),
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: 'Phone Number',
                      hintColor: const Color(0xff94A3B8),
                      validator: (v) => Utils.valid.defaultValidation(v),
                      controller: phone,
                    ),

                    TextFormFieldWidget(
                      onSaved: (value) => _authRequest.password = value,
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      prefixIconWidget: SvgPicture.asset(
                        "lock".svg(),
                        fit: BoxFit.scaleDown,
                      ),
                      hintColor: const Color(0xff94A3B8),
                      backgroundColor: const Color(0xffF8FAFC),
                      // padding: const EdgeInsets.symmetric(horizontal: 18),
                      type: TextInputType.visiblePassword,

                      hintText: 'Password',
                      password: true,
                      // validator: (v) => Utils.valid.passwordValidation(v),
                      controller: password,
                      borderRadius: 16,
                    ),
                    16.ph,
                    TextButtonWidget(
                        text: "Forgot password? Reset it",
                        size: 15,
                        color: Colors.black,
                        fontweight: FontWeight.w600,
                        function: () {
                          Navigator.pushNamed(
                              context, Routes.forget_passScreen);
                        }),

                    ButtonWidget(
                      title: 'Sign in',
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
                        AuthRequest registerModel = AuthRequest(
                          password: password.text,
                          phone: phone.text,
                        );
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          final response = await cubit.login(
                              loginRequestModel: registerModel);
                          if (response == true) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.LayoutScreen, (route) => false);
                          } else if (response == false) {
                            Alerts.snack(
                                text: 'You have to activate your account'.tr(),
                                state: SnackState.failed);
                            Navigator.pushNamed(
                              context,
                              Routes.OtpScreen,
                              arguments: OtpArguments(
                                  sendTo: phone.text,
                                  onSubmit: (s) async {
                                    registerModel.code = s;
                                    final res = await cubit.activate(
                                        registerRequestModel: registerModel);
                                    if (res == true) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.LayoutScreen,
                                          (route) => false);
                                    }
                                  },
                                  onReSend: () async {
                                    await cubit
                                        .resendCode(registerModel.phone ?? '');
                                  },
                                  init: false),
                            );
                          }
                        }
                      },
                    ),
                    if (Platform.isAndroid) 16.ph,
                    if (Platform.isAndroid)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ButtonWidget(
                          withBorder: true,
                          buttonColor: Colors.white,
                          textColor: Colors.black,
                          borderColor: const Color(0xffEEF2F6),
                          width: double.infinity,
                          onTap: () async {
                            await cubit.googleLogin();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              20.pw,
                              SvgPicture.asset(icons[0].svg()),
                              70.pw,
                              Text("Sign in with ${names[0]}",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    16.ph,
                    if (Platform.isIOS)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ButtonWidget(
                          withBorder: true,
                          buttonColor: Colors.white,
                          textColor: Colors.black,
                          borderColor: const Color(0xffEEF2F6),
                          width: double.infinity,
                          onTap: () async {
                            await cubit.appleLoginIn();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              20.pw,
                              SvgPicture.asset(icons[1].svg()),
                              70.pw,
                              Text("Sign in with ${names[1]}",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    // signupBtn(context),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    "Don’t have and account? ",
                    fontSize: 16,
                    color: Colors.black,
                    weight: FontWeight.w500,
                  ),
                  TextButtonWidget(
                      text: "Sign Up",
                      size: 16,
                      // padding: const EdgeInsets.symmetric(horizontal: 15),
                      color: context.primaryColor,
                      fontweight: FontWeight.w700,
                      function: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.RegisterScreen);
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
