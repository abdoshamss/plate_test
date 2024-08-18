import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/Router/Router.dart';
import '../../../../../core/extensions/all_extensions.dart';
import '../../../../../core/utils/extentions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../shared/back_widget.dart';
import '../../../../../shared/widgets/button_widget.dart';
import '../../../../../shared/widgets/edit_text_widget.dart';
import '../../../../../shared/widgets/text_widget.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    phone.dispose();
    super.dispose();
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
                  icon: Icons.close_outlined,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      48.ph,
                      Image.asset(
                        "otp_img".png(),
                      ),
                      32.ph,
                      const TextWidget(
                        "تقريبا هناك!",
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      8.ph,
                      const TextWidget(
                        'تحقق من صندوق الوارد الخاص بك وأدخل رمز التحقق للتحقق من حسابك.',
                        fontSize: 16,
                        color: Color(0xff64748B),
                        fontWeight: FontWeight.w500,
                      ),
                      16.ph,
                      TextFormFieldWidget(
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
                        borderRadius: 16,
                        controller: phone,
                      ),
                      30.ph,
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonWidget(
                      title: 'تأكيد',
                      withBorder: true,
                      buttonColor: context.primaryColor,
                      textColor: Colors.white,
                      borderColor: context.primaryColor,
                      width: double.infinity,
                      // padding: const EdgeInsets.symmetric(horizontal: 15),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          final response = await cubit.forgetPass(phone.text);
                          if (response != null) {
                            Navigator.pushNamed(context, Routes.OtpScreen,
                                arguments: OtpArguments(
                                  sendTo: phone.text,
                                  onSubmit: (code) async {
                                    if (code == cubit.codeId) {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.ResetPasswordScreen,
                                        arguments: NewPasswordArgs(
                                          code: cubit.codeId,
                                          phone: phone.text,
                                        ),
                                      );
                                    }
                                  },
                                  onReSend: () async {
                                    await cubit.resendCode(phone.text);
                                  },
                                  init: false,
                                ));
                          }
                        }
                      },
                    ),
                    16.ph,
                    ButtonWidget(
                      title: "الرجوع لتسجيل الدخول",
                      withBorder: true,
                      buttonColor: Colors.white,
                      textColor: context.primaryColor,
                      borderColor: context.primaryColor,
                      width: double.infinity,
                      // padding: const EdgeInsets.symmetric(horizontal: 15),
                      onTap: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
