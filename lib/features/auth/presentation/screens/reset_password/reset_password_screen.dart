import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/Router/Router.dart';
import '../../../../../core/utils/extentions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../shared/back_widget.dart';
import '../../../../../shared/widgets/button_widget.dart';
import '../../../../../shared/widgets/customtext.dart';
import '../../../../../shared/widgets/edit_text_widget.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.code, required this.phone});

  final String code, phone;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          // TODO: implement listener
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
                icon: Icons.arrow_back_sharp,
              ),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    24.ph,
                    const CustomText(
                      "Create your new password",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                    const CustomText(
                      "Your new password must be different from previous password.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff64748B)),
                    ),
                    24.ph,
                    TextFormFieldWidget(
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      prefixIconWidget: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          "lock".svg(),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      backgroundColor: const Color(0xffF8FAFC),
                      type: TextInputType.visiblePassword,
                      controller: passwordController,
                      hintText: 'New Password',
                      password: true,
                      validator: (v) => Utils.valid.defaultValidation(v),
                      borderRadius: 16,
                    ),
                    TextFormFieldWidget(
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      prefixIconWidget: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          "lock".svg(),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      backgroundColor: const Color(0xffF8FAFC),
                      type: TextInputType.visiblePassword,
                      hintText: 'Confirm New Password',
                      password: true,
                      validator: (v) => Utils.valid.defaultValidation(v),
                      borderRadius: 16,
                      controller: confirmPasswordController,
                    ),
                    32.ph,
                    ButtonWidget(
                      title: "Confirm",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final res = await cubit.resetPassword(
                              pass: passwordController.text.trim(),
                              phone: widget.phone,
                              code: widget.code);
                          if (res == true) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.LoginScreen, (route) => false);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
