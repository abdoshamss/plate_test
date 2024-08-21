import 'package:animated_widgets_flutter/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/utils/utils.dart';

import '../../../../../core/Router/Router.dart';
import '../../../../../core/theme/light_theme.dart';
import '../../../../../core/utils/extentions.dart';
import '../../../cubit/splash_cubit.dart';
import '../../../cubit/splash_states.dart';

///// put it in routes
///  import '../../modules/splash/presentation/splash.dart';
/// static const String splashScreen = "/splashScreen";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SplashCubit(),
        child: Scaffold(
          backgroundColor: LightThemeColors.primary,
          body: BlocConsumer<SplashCubit, SplashStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: OpacityAnimatedWidget.tween(
                      opacityEnabled: 1,
                      opacityDisabled: 0,
                      duration: const Duration(milliseconds: 3000),
                      enabled: true,
                      animationFinished: (finished) async {
                        if (Utils.token == '') {
                          Navigator.pushNamed(context, Routes.LoginScreen);
                        } else {
                          Navigator.pushNamed(context, Routes.LayoutScreen);
                        }
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, await cubit.checkLogin(), (route) => false);
                      },
                      child: Image.asset(
                        "splash".png(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
