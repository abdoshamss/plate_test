import 'package:pinput/pinput.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../core/extensions/all_extensions.dart';
import '../../../../../core/services/alerts.dart';
import '../../../../../core/theme/light_theme.dart';
import '../../../../../core/utils/extentions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../shared/back_widget.dart';
import '../../../../../shared/widgets/button_widget.dart';
import '../../../../../shared/widgets/text_widget.dart';

class OtpScreen extends StatefulWidget {
  final String sendTo;
  final Function(String code) onSubmit;
  final bool? init;
  final VoidCallback onReSend;
  const OtpScreen({
    super.key,
    required this.sendTo,
    required this.onSubmit,
    required this.onReSend,
    this.init,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime target = DateTime.now().add(const Duration(minutes: 5));
  DateTime now = DateTime.now();
  Timer? timer;
  String remainigTime = '02:00';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.init == true) widget.onReSend.call();
      startTimer();
    });
    super.initState();
  }

  void startTimer() {
    target = DateTime.now().add(const Duration(minutes: 2));
    now = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (s) {
      if (now.isBefore(target)) {
        now = now.add(const Duration(seconds: 1));
        remainigTime =
            '${target.difference(now).inMinutes}:${target.difference(now).inSeconds.remainder(60)}';
        setState(() {});
      } else {
        remainigTime = '';
        timer!.cancel();
        setState(() {});
      }
    });
  }

  TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    timer!.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                24.ph,
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Pinput(
                    // androidSmsAutofillMethod:
                    //     AndroidSmsAutofillMethod.smsUserConsentApi,
                    // smsCodeMatcher: PinputConstants.defaultSmsCodeMatcher,
                    length: 5,
                    autofocus: false,
                    // errorText: otpError,
                    // onClipboardFound: (s) {},
                    controller: otpController,
                    defaultPinTheme: PinTheme(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      width: 65.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: context.primaryColor.withOpacity(.05),
                        borderRadius: BorderRadius.circular(16.0),

                        border: Border.all(
                          color: LightThemeColors.primary,
                          width: 1.0,
                        ),
                        // border: Border.all(
                        //   color: Colors.black,
                        //   width: 1.0,
                        // ),
                        //shape: BoxShape.circle,
                      ),
                    ),
                    followingPinTheme: PinTheme(
                        // padding: EdgeInsets.symmetric(horizontal: 6),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        textStyle: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: context.primaryColor),
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffF8FAFC),

                          borderRadius: BorderRadius.circular(16.0),

                          //shape: BoxShape.circle,
                        )),
                    pinAnimationType: PinAnimationType.scale,

                    validator: Utils.valid.defaultValidation,
                    onCompleted: (pin) async => await widget.onSubmit(pin),
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const TextWidget(
                //       "لم يتم إرسال الكود ؟",
                //     ),
                //     8.pw,
                //     16.ph,
                //     remainigTime.isEmpty
                //         ? GestureDetector(
                //             onTap: remainigTime.isEmpty
                //                 ? () async {
                //                     widget.onReSend.call();

                //                     remainigTime = '60';
                //                     setState(() {});
                //                     startTimer();
                //                     setState(() {});
                //                   }
                //                 : null,
                //             child: TextWidget(
                //               "إعادة إرسالة",
                //               color: context.primaryColor,
                //               fontWeight: FontWeight.w500,
                //             ))
                //         : Center(
                //             child: TextWidget(
                //               '$remainigTime ',
                //               color: context.secondaryColor,
                //             ),
                //           ),
                //   ],
                // )
              ],
            ),
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
                // Navigator.pushNamed(context, Routes.layout);
                if (formKey.currentState!.validate()) {
                  if (otpController.text.length < 5) {
                    Alerts.snack(
                        text: "الكود غير صحيح", state: SnackState.failed);
                  } else {
                    await widget.onSubmit(otpController.text);
                  }
                }
              },
            ),
            16.ph,
            ButtonWidget(
              title: remainigTime.isEmpty ? 'إعادة الإرسال' : remainigTime,
              withBorder: true,
              buttonColor: Colors.white,
              textColor: context.primaryColor,
              borderColor: context.primaryColor,
              width: double.infinity,
              // padding: const EdgeInsets.symmetric(horizontal: 15),
              onTap: () async {
                // Navigator.pushNamed(context, Routes.layout);
                if (remainigTime.isEmpty) {
                  widget.onReSend.call();
                  print('object');
                  remainigTime = '60';
                  setState(() {});
                  startTimer();
                }

                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
