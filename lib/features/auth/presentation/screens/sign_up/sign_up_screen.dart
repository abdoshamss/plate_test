import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/general/general_cubit.dart';
import 'package:plate_test/core/general/general_repo.dart';
import 'package:plate_test/core/utils/Locator.dart';
import 'package:plate_test/shared/widgets/autocomplate.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  late final AuthRequest _authRequest;
  final formKey = GlobalKey<FormState>();
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
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      24.ph,
                      const CustomText(
                        "قم بإنشاء حساب في بليت",
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
                        backgroundColor: context.primaryColor.withOpacity(.04),
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        type: TextInputType.name,
                        prefixIcon: "assets/icons/user.svg",
                        hintText: 'الإسم',
                        password: false,
                        onSaved: (e) {},
                        validator: (v) => Utils.valid.defaultValidation(v),
                        controller: name,
                        borderRadius: 16,
                      ),
                      TextFormFieldWidget(
                        backgroundColor: context.primaryColor.withOpacity(.04),
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        type: TextInputType.emailAddress,
                        prefixIcon: "assets/icons/user.svg",
                        hintText: 'البريد الإلكترونى',
                        password: false,
                        validator: (v) => Utils.valid.emailValidation(v),
                        controller: email,
                        borderRadius: 16,
                      ),
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
                      CustomAutoCompleteTextField<AreaModel>(
                        onChanged: (value) {
                          _authRequest.areaID = value.id;
                        },
                        function: (s) async =>
                            await locator<GeneralRepo>().getAreas() ?? [],
                        validator: (v) => Utils.valid.defaultValidation(v),
                        showSufix: true,
                        localData: false,
                        showLabel: false,
                        hint: "area",
                        itemAsString: (a) => a.name??'',
                        // border: InputBorder.none,
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
                      TextFormFieldWidget(
                        backgroundColor: context.primaryColor.withOpacity(.04),
                        // padding: const EdgeInsets.symmetric(horizontal: 18),
                        type: TextInputType.visiblePassword,
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        prefixIcon: "assets/icons/user.svg",
                        hintText: 'تأكيد كلمة المرور',
                        password: true,
                        validator: (v) => Utils.valid
                            .confirmPasswordValidation(v, password.text),
                        controller: confirmPassword,
                        borderRadius: 33,
                      ),
                      ButtonWidget(
                          title: "إنشاء حساب",
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
                            AuthRequest registerRequestModel = AuthRequest(
                              name: name.text.trim(),
                              email: email.text.trim(),
                              password: password.text.trim(),
                            );
                            if (formKey.currentState!.validate()) {
                              final response = await cubit.signUp(
                                registerRequestModel: registerRequestModel,
                              );
                              if (response == true) {
                                // Navigator.pushNamedAndRemoveUntil(
                                //   context,
                                //   Routes.OtpScreen,
                                // (route) => false,
                                //   arguments: OtpArguments(
                                //     sendTo: phone.text,
                                //     onSubmit: (s) async {
                                //       registerRequestModel.code = s;
                                //       final res = await cubit.activate(
                                //           registerRequestModel: registerRequestModel,);
                                //       if (res == true) {
                                //
                                //         Navigator.pushNamedAndRemoveUntil(context, Routes.LayoutScreen, (route) => false);
                                //       }
                                //
                                //     }, onReSend: ()async {
                                //     await cubit.resenCode(
                                //         mobile: registerRequestModel.mobile ?? '');
                                //   }
                                //   )
                                // );
                                // ignore: use_build_context_synchronously

                                // Navigator.pushNamed(
                                //   context,
                                //   Routes.OtpScreen,
                                //   arguments: OtpArguments(
                                //       sendTo: email.text,
                                //       onSubmit: (s) async {
                                //         registerRequestModel.code = s;
                                //         final res = await cubit.activate(
                                //             registerRequestModel:
                                //                 registerRequestModel);

                                //         if (res == true) {
                                //           Navigator.pushNamedAndRemoveUntil(
                                //               context,
                                //               Routes.LayoutScreen,
                                //               (route) => false);
                                //         }
                                //       },
                                //       onReSend: () async {
                                //         await cubit.resendCode(
                                //             registerRequestModel.email ??
                                //                 '');
                                //       },
                                //       init: false),
                                // );
                              }
                              // if (response['data']['active'] == true) {
                              //   // if (response['data']['type'] == 'client') {
                              //   await FBMessging.subscribeToTopic();
                              //   // }
                              //   context.pushNamedAndRemoveUntil(Routes.layout);
                              // } else if (response['data']['active'] == false) {
                              //   Navigator.pushNamed(
                              //     context,
                              //     Routes.otp,
                              //     arguments: OtpArguments(
                              //         sendTo: phone.text,
                              //         onSubmit: (s) async {
                              //           final res = await cubit.activate(
                              //               mobile: phone.text, code: s);
                              //           if (res == true) {
                              //             await FBMessging.subscribeToTopic();
                              //             context.pushNamedAndRemoveUntil(
                              //                 Routes.layout);
                              //           }
                              //         },
                              //         onReSend: () async {
                              //           await cubit.resendCode(phone.text);
                              //         },
                              //         init: false),
                              //   );
                            }
                          }),
                      20.ph,
                      ButtonWidget(
                        title: 'الدخول كزائر',
                        withBorder: true,
                        buttonColor: Colors.white,
                        textColor: context.primaryColor,
                        borderColor: context.primaryColor,
                        width: double.infinity,

                        // padding: const EdgeInsets.symmetric(horizontal: 15),
                        onTap: () async {
                          Navigator.pushNamed(
                            context,
                            Routes.LayoutScreen,
                          );
                        },
                      ),
                      64.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            "لديك حساب ؟",
                            fontSize: 16,
                            color: Colors.black,
                            weight: FontWeight.w500,
                          ),
                          TextButtonWidget(
                              text: "سجل الدخول",
                              size: 16,
                              // padding: const EdgeInsets.symmetric(horizontal: 15),
                              color: context.primaryColor,
                              fontweight: FontWeight.w700,
                              function: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.LoginScreen);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
