import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plate_test/features/layout/presentation/screens/layout_screen.dart';

import '../../features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/auth/presentation/screens/otp/otp_screen.dart';
import '../../features/auth/presentation/screens/reset_password/reset_password_screen.dart';
import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/item_details/presentation/screens/item_details_screen.dart';
import '../../features/splash/presentation/screens/splash/splash.dart';

class Routes {
  static const String splashScreen = "/splashScreen";
  static const String LoginScreen = "LoginScreen";
  static const String RegisterScreen = "RegisterScreen";
  static const String forget_passScreen = "/forgetPassScreen";
  static const String OtpScreen = "/OtpScreen";
  static const String LayoutScreen = "/LayoutScreen";
  static const String ResetPasswordScreen = "/ResetPasswordScreen";
  static const String HomeScreen = "HomeScreen";
  static const String ItemDetailsScreen = "ItemDetailsScreen";
}

class RouteGenerator {
  static String currentRoute = "";
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const SplashScreen();
            });

      case Routes.LoginScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const LoginScreen();
            });
      case Routes.ResetPasswordScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return ResetPasswordScreen(
                code: (routeSettings.arguments as NewPasswordArgs).code,
                phone: (routeSettings.arguments as NewPasswordArgs).phone,
              );
            });
      case Routes.OtpScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return OtpScreen(
                onReSend: (routeSettings.arguments as OtpArguments).onReSend,
                onSubmit: (routeSettings.arguments as OtpArguments).onSubmit,
                sendTo: (routeSettings.arguments as OtpArguments).sendTo,
                init: (routeSettings.arguments as OtpArguments).init,
              );
            });
      case Routes.forget_passScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const ForgetPasswordScreen();
            });
      case Routes.RegisterScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const SignUpScreen();
            });
      case Routes.LayoutScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const LayoutScreen();
            });

      case Routes.HomeScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const HomeScreen();
            });

      case Routes.ItemDetailsScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const ItemDetailsScreen();
            });
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> getNestedRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("مسار غير موجود"),
              ),
              body: const Center(child: Text("مسار غير موجود")),
            ));
  }
}

class OtpArguments {
  final String sendTo;
  final bool? init;
  final dynamic Function(String) onSubmit;
  final void Function() onReSend;

  OtpArguments({
    required this.sendTo,
    required this.onSubmit,
    required this.onReSend,
    this.init,
  });
}

class NewPasswordArgs {
  final String code;
  final String phone;
  const NewPasswordArgs({required this.code, required this.phone});
}
