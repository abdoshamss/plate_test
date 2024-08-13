import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/Router/Router.dart';
import '../../../../../core/extensions/all_extensions.dart';
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
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  late final AuthRequest _authRequest;
  final List<String> names = ["جوجل", "أبل"];
  final List<String> icons = ["google", "apple"];
  final formKey = GlobalKey<FormState>();
  AuthRequest authRequest = AuthRequest();
  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    _authRequest = AuthRequest();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
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
                      "قم بتسجيل الدخول إلي بليت",
                      fontSize: 32,
                      color: Colors.black,
                      weight: FontWeight.w700,
                    ),
                    8.ph,
                    const CustomText(
                      'مرحبا من فضلك أدخل بياناتك',
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
                      prefixWidget: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Transform.rotate(
                            angle: 3.14 / 2 * 3 - .5,
                            child: SvgPicture.asset(
                              "Phone".svg(),
                            )),
                      ),
                      hintText: 'رقم الجوال',
                      hintColor: const Color(0xff94A3B8),
                      password: false,
                      validator: (v) => Utils.valid.defaultValidation(v),
                      controller: phone,
                      borderRadius: 16,
                    ),

                    TextFormFieldWidget(
                      onSaved: (value) => _authRequest.password = value,
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      prefixWidget: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          "lock".svg(),
                        ),
                      ),
                      hintColor: const Color(0xff94A3B8),
                      backgroundColor: const Color(0xffF8FAFC),
                      // padding: const EdgeInsets.symmetric(horizontal: 18),
                      type: TextInputType.visiblePassword,

                      hintText: 'كلمة المرور',
                      password: true,
                      validator: (v) => Utils.valid.passwordValidation(v),
                      controller: password,
                      borderRadius: 16,
                    ),

                    TextButtonWidget(
                        text: 'هل نسيت كلمة المرور ؟',
                        size: 15,
                        color: Colors.black,
                        fontweight: FontWeight.w600,
                        function: () {
                          Navigator.pushNamed(
                              context, Routes.forget_passScreen);
                        }),

                    ButtonWidget(
                      title: 'تسجيل الدخول',
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
                            // Alerts.snack(
                            //     text: 'You have to activate your account'
                            //         .tr(),
                            //     state: SnackState.failed);
                            // Navigator.pushNamed(
                            //   context,
                            //   Routes.OtpScreen,
                            //   arguments: OtpArguments(
                            //       sendTo: email.text,
                            //       onSubmit: (s) async {
                            //         registerModel.code = s;
                            //         final res = await cubit.activate(
                            //             registerRequestModel: registerModel);

                            //         if (res == true) {
                            //           Navigator.pushNamedAndRemoveUntil(
                            //               context,
                            //               Routes.LayoutScreen,
                            //               (route) => false);
                            //         }
                            //       },
                            //       onReSend: () async {
                            //         await cubit.resenCode(
                            //             email: registerModel.email ?? '');
                            //       },
                            //       init: false),
                            // );
                          }
                        }
                      },
                    ),
                    8.ph,
                    ...List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ButtonWidget(
                          withBorder: true,
                          buttonColor: Colors.white,
                          textColor: Colors.black,
                          borderColor: const Color(0xffEEF2F6),
                          width: double.infinity,
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              Routes.LayoutScreen,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              20.pw,
                              SvgPicture.asset(icons[index].svg()),
                              70.pw,
                              Text("سجل الدحول بواسطة ${names[index]}",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
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
                    "ليس لديك حساب ؟",
                    fontSize: 16,
                    color: Colors.black,
                    weight: FontWeight.w500,
                  ),
                  TextButtonWidget(
                      text: "إنشاء حساب",
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
