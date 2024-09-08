import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plate_test/core/services/map.dart';
import 'package:plate_test/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:plate_test/features/layout/presentation/screens/layout_screen.dart';
import 'package:plate_test/shared/widgets/webview_payment.dart';

import '../../features/add_ad/presentation/screens/add_ad_screen.dart';
import '../../features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/auth/presentation/screens/otp/otp_screen.dart';
import '../../features/auth/presentation/screens/reset_password/reset_password_screen.dart';
import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/item_details/presentation/screens/item_details_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/splash/presentation/screens/splash/splash.dart';
import '../../features/verify_user/presentation/screens/verify_user_screen.dart';

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
  static const String FavoritesScreen = "FavoritesScreen";
  static const String AddAdScreen = "AddAdScreen";
  static const String mapScreen = "mapScreen";
  static const String WebViewPaymentScreen = "WebViewPaymentScreen";
  static const String ChatScreen = "ChatScreen";
  static const String ChatDetailsScreen = "ChatDetailsScreen";
  static const String NotificationsScreen = "NotificationsScreen";
  static const String ProfileScreen = "ProfileScreen";
  static const String VerifyUserScreen = "VerifyUserScreen";
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
              return ItemDetailsScreen(id: routeSettings.arguments as int);
            });
      case Routes.FavoritesScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const FavoritesScreen();
            });
      case Routes.AddAdScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const AddAdScreen();
            });

      case Routes.mapScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return MapItem();
            });
      case Routes.WebViewPaymentScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return WebViewPayment(url: routeSettings.arguments as String);
            });
      case Routes.ChatScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const ChatScreen();
            });
      case Routes.ChatDetailsScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return ChatDetailsScreen(
                id: routeSettings.arguments as int,
              );
            });

      case Routes.NotificationsScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const NotificationsScreen();
            });
      case Routes.ProfileScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const ProfileScreen();
            });
      case Routes.VerifyUserScreen:
        return CupertinoPageRoute(
            settings: routeSettings,
            builder: (_) {
              return const VerifyUserScreen();
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
