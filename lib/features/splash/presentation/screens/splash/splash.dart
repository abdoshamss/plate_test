import 'package:animated_widgets_flutter/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              final cubit = SplashCubit.get(context);
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
                        // if (Utils.token == '') {
                        //   Navigator.pushNamedAndRemoveUntil(
                        //       context, Routes.LoginScreen, (route) => false);
                        // } else {
                        //   Navigator.pushNamedAndRemoveUntil(
                        //       context, Routes.LayoutScreen, (route) => false);
                        // }
                        Navigator.pushNamedAndRemoveUntil(context,
                            await cubit.checkLogin(), (route) => false);
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
//{user: {id: 37, name: ادمن 11, mobile: 0512341234, email: admin13@admin.com, image: https://plate.almasader.net/placeholders/user.png, notify: true, lang: ar,
// banned: false, active: true, is_verified: false, mobile_verified: true, email_verified: false, area_id: 1,
// area: السعوديه, is_social: false, coaching: pending}, access_token: 445|VAPNK6D9SsuehGol9oXqKAOdQnI1LSX5aAhNfMlP3432ca7b}
