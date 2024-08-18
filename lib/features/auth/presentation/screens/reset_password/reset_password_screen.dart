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
                      "أدخل كلمة المرور الجديدة",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                    const CustomText(
                      "كلمة المرور الجديدة يجب ان تكون محتلفة عن كلمة المرور القديمة",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff64748B)),
                    ),
                    24.ph,
                    TextFormFieldWidget(
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      prefixWidget: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SvgPicture.asset(
                            "lock".svg(),
                          )),
                      backgroundColor: const Color(0xffF8FAFC),
                      type: TextInputType.visiblePassword,
                      controller: passwordController,
                      hintText: 'كلمة المرور الجديدة',
                      password: true,
                      validator: Utils.valid.passwordValidation,
                      borderRadius: 16,
                    ),
                    TextFormFieldWidget(
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 20, horizontal: 10),
                      prefixWidget: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SvgPicture.asset(
                            "lock".svg(),
                          )),
                      backgroundColor: const Color(0xffF8FAFC),
                      type: TextInputType.visiblePassword,
                      hintText: 'تأكيد كلمة المرور الجديدة',
                      password: true,
                      validator: (v) => Utils.valid.confirmPasswordValidation(
                          v, passwordController.text),
                      borderRadius: 16,
                      controller: confirmPasswordController,
                    ),
                    32.ph,
                    ButtonWidget(
                      title: "تأكيد",
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
