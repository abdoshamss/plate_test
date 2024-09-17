import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../../core/Router/Router.dart';
import '../../../../../core/theme/light_theme.dart';
import '../../../../../shared/widgets/button_widget.dart';
import '../../../../../shared/widgets/customtext.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({super.key});

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is FaceIdSuccessState) {
            Navigator.pushNamed(
              context,
              Routes.LayoutScreen,
            );
          }
        },
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    150.ph,
                    Image.asset(
                      width: 136,
                      height: 136,
                      "finger_print".png(),
                    ),
                    40.ph,
                    SizedBox(
                      width: 311,
                      height: 31,
                      child: CustomText(
                        "تسجيل الدخول ببصمة الوجه",
                        align: TextAlign.center,
                        style: const TextStyle(
                          color: LightThemeColors.textPrimary,
                        ).s24.bold,
                      ),
                    ),
                    8.ph,
                    SizedBox(
                      width: 311,
                      height: 78,
                      child: CustomText(
                        align: TextAlign.center,
                        "وصف",
                        style: const TextStyle(
                          color: LightThemeColors.textSecondary,
                        ).s16.medium,
                      ),
                    ),
                    165.ph,
                    ButtonWidget(
                      onTap: () async => await cubit.checkBiometric(true),
                      title: "أنشء بصمة",
                      gradient: const LinearGradient(
                        colors: LightThemeColors.gradientPrimary,
                      ),
                      buttonColor: Colors.white,
                      fontSize: 16,
                      fontweight: FontWeight.w700,
                      textColor: Colors.white,
                    ),
                    12.ph,
                    ButtonWidget(
                      onTap: () async => await cubit.checkBiometric(false),
                      title: "تخطي",
                      buttonColor: Colors.white,
                      withBorder: true,
                      borderColor: LightThemeColors.textPrimary,
                      // gradient: LinearGradient(
                      //   colors: LightThemeColors.gradientPrimary,
                      // ),
                      fontSize: 16,
                      fontweight: FontWeight.w700,
                      textColor: LightThemeColors.textPrimary,
                    ),
                    50.ph,
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
