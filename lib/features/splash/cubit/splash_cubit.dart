import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:plate_test/core/data_source/hive_helper.dart';

import '../../../core/Router/Router.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../../../core/utils/Utils.dart';
import '../domain/repository/splash_repository.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(context) => BlocProvider.of(context);

  SplashRepository splashRepository = SplashRepository(locator<DioService>());

  final LocalAuthentication auth = LocalAuthentication();

  int sliderIndex = 0;
  late PageController controller;

  void updateSliderIndex(int index) {
    sliderIndex = index;
    emit(ChangeIntroState());
  }

  bool isAuthorized = false;

  checkLogin() async {
    final res = await auth.canCheckBiometrics;
    print("object\t${await auth.isDeviceSupported()}");
    print("cancheck\t$res");
    bool isbiometricAuth = await Utils.dataManager.getbiometric() ?? false;
    print("fffff\t$isbiometricAuth");
    var user = await DataManager.getUserData();
    String? token = user?['access_token'];

    /// show the user the biometric screen if the user has enabled biometric authentication
    // if (Utils.token != null) {
    if (token != null) {
      if (isbiometricAuth) {
        try {
          print(0);
          isAuthorized = await auth.authenticate(
            localizedReason: 'scan biometric',
            // 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(
              // stickyAuth: true,
              useErrorDialogs: true,
              biometricOnly: true,
              sensitiveTransaction: true,
            ),
          );

          if (isAuthorized == true) {
            print(1);
            return Routes.LayoutScreen;
          } else {
            print(2);
            return Routes.LoginScreen;
            // await Utils.deleteUserData();
          }
        } catch (e) {
          print("exc$e");
          print(5);
          return Routes.LoginScreen;
        }
      } else {
        final res = await DataManager.getUserData();
        if (res == null) {
          await Utils.deleteUserData();
          return Routes.LoginScreen;
        }
      }
    } else {
      print(4);
      return Routes.LoginScreen;
    }
  }

// if (Utils.token == '') {
// Navigator.pushNamedAndRemoveUntil(
// context, Routes.LoginScreen, (route) => false);
// } else {
// Navigator.pushNamedAndRemoveUntil(
// context, Routes.LayoutScreen, (route) => false);
}
