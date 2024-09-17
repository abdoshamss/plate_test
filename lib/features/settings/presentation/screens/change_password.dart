import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../../auth/domain/request/auth_request.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Function(String, String)? onSubmit;

  const ChangePasswordScreen({super.key, this.onSubmit});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController password = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final AuthRequest _authRequest = AuthRequest();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: LightThemeColors.gradient)),
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
                    "Change Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  SvgPicture.asset("dots_white".svg())
                ],
              ),
            ),
            Expanded(
                child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  TextFormFieldWidget(
                    label: 'Old Password',
                    onSaved: (value) => _authRequest.password = value,
                    contentPadding: const EdgeInsetsDirectional.symmetric(
                        vertical: 20, horizontal: 10),
                    prefixIconWidget: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SvgPicture.asset(
                        "lock".svg(),
                        fit: BoxFit.scaleDown,
                      ),
                    ),

                    hintColor: const Color(0xff94A3B8),
                    backgroundColor: const Color(0xffF8FAFC),
                    // padding: const EdgeInsets.symmetric(horizontal: 18),
                    type: TextInputType.visiblePassword,
                    controller: password,
                    hintText: 'Password',
                    password: true,
                    // validator: (v) => Utils.valid.passwordValidation(v),
                    validator: (v) => Utils.valid.defaultValidation(v),
                    borderRadius: 16,
                  ),
                  24.ph,
                  TextFormFieldWidget(
                    label: 'New Password',
                    backgroundColor: context.primaryColor.withOpacity(.04),
                    // padding: const EdgeInsets.symmetric(horizontal: 18),
                    type: TextInputType.visiblePassword,
                    contentPadding: const EdgeInsetsDirectional.symmetric(
                        vertical: 20, horizontal: 10),
                    prefixIconWidget: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SvgPicture.asset(
                        "lock".svg(),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    hintText: 'Confirm Password',
                    password: true,
                    controller: newPassword,
                    validator: (v) => Utils.valid.defaultValidation(v),
                    borderRadius: 33,
                    onSaved: (value) =>
                        _authRequest.password_confirmation = value,
                  ),
                  32.ph,
                  ButtonWidget(
                    title: 'Edit Password',
                    withBorder: true,
                    onTap: () =>
                        widget.onSubmit?.call(password.text, newPassword.text),
                    // onTap: () {},
                    gradient: const LinearGradient(
                      colors: LightThemeColors.gradientPrimary,
                    ),
                    textColor: Colors.white,
                    borderColor: context.primaryColor,
                    width: double.infinity,
                    fontSize: 18,
                    fontweight: FontWeight.bold,
                    // padding: const EdgeInsets.symmetric(horizontal: 15),
                    // onTap: () async {
                    //   FocusScope.of(context).unfocus();
                    //   if (formKey.currentState!.validate()) {
                    //     formKey.currentState!.save();
                    //
                    //     cubit.editPasswordCubit(
                    //         authRequest: _authRequest);
                    //   }
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
                    // },
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
