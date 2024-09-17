import 'package:easy_localization/easy_localization.dart';
import 'package:plate_test/core/utils/Utils.dart';

import '../../../../core/data_source/dio_helper.dart';
import '../../../../core/services/alerts.dart';
import '../../../../shared/widgets/myLoading.dart';
import '../request/auth_request.dart';
import 'end_points.dart';

class AuthRepository {
  final DioService dioService;

  AuthRepository(this.dioService);

  loginRequest(AuthRequest user) async {
    final response = await dioService.postData(
        isForm: true,
        url: AuthEndPoints.login,
        body: user.login(),
        loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  registerRequest(AuthRequest user) async {
    final response = await dioService.postData(
        url: AuthEndPoints.register,
        body: user.register(),
        loading: true,
        isForm: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  activateRequest(AuthRequest registerRequestModel) async {
    // if (Utils.FCMToken.isEmpty) {
    //   MyLoading.show();
    // Utils.FCMToken = await Utils.getFCMToken() ?? "";
    // }
    final response = await dioService.postData(
      isForm: true,
      loading: true,
      url: AuthEndPoints.activate,
      body: registerRequestModel.activate(),
    );
    if (response.isError == false) {
      Alerts.snack(
          text: response.response?.data['message'] ?? "sign_in_success",
          state: SnackState.success);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  resendCodeRequest(String phone) async {
    final response = await dioService.postData(
        url: AuthEndPoints.resendCode, body: {'mobile': phone}, isForm: true);
    if (response.isError == false) {
      // Alerts.snack(text: response.response?.data['message'], state: 1);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  googleRegisterRequest(AuthRequest user) async {
    if (Utils.FCMToken.isEmpty) {
      MyLoading.show();
      await Utils.getFCMToken();
    }
    final response = await dioService.postData(
        isForm: true,
        url: "signup/google",
        body: user.gooleRegister(),
        loading: true);
    if (response.isError == false) {
      Alerts.snack(text: "sign_in_success".tr(), state: SnackState.success);
      // Alerts.snack(
      //     text: response.response?.data['message'], state: SnackState.success);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  googleSignInRequest(AuthRequest user) async {
    if (Utils.FCMToken.isEmpty) {
      MyLoading.show();
      await Utils.getFCMToken();
    }
    final response = await dioService.postData(
        isForm: true,
        url: "signin/google",
        body: user.gooleRegister(),
        loading: true);
    if (response.isError == false) {
      Alerts.snack(text: "sign_in_success".tr(), state: SnackState.success);
      // Alerts.snack(
      //     text: response.response?.data['message'], state: SnackState.success);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  appleRegisterRequest(AuthRequest user) async {
    if (Utils.FCMToken.isEmpty) {
      MyLoading.show();
      await Utils.getFCMToken();
    }
    final response = await dioService.postData(
        isForm: true,
        url: "signup/apple",
        body: user.gooleRegister(),
        loading: true);
    if (response.isError == false) {
      Alerts.snack(text: "sign_in_success".tr(), state: SnackState.success);

      // Alerts.snack(
      //     text: response.response?.data['message'], state: SnackState.success);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  appleSignInRequest(AuthRequest user) async {
    if (Utils.FCMToken.isEmpty) {
      MyLoading.show();
      await Utils.getFCMToken();
    }
    final response = await dioService.postData(
        isForm: true,
        url: "signin/apple",
        body: user.gooleRegister(),
        loading: true);
    if (response.isError == false) {
      Alerts.snack(text: "sign_in_success".tr(), state: SnackState.success);

      // Alerts.snack(
      //     text: response.response?.data['message'], state: SnackState.success);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  selectArea(id) async {
    final response = await dioService.postData(
        url: "save_area", body: {"area_id": id}, isForm: true, loading: true);
    if (response.isError == false) {
      return true;
    } else {
      return null;
    }
  }

  // sendCodeRequest({required String email, required String code}) async {
  //   final response = await dioService.postData(
  //       url: AuthEndPoints.sendCode,
  //       body: {'email': email, 'code': code},
  //       loading: true,
  //       isForm: true);
  //   if (response.isError == false) {
  //     // Alerts.snack(text: response.response?.data['message'], state: 1);
  //     return response.response?.data['data'];
  //   } else {
  //     return null;
  //   }
  // }

  forgetPassRequest(String p) async {
    final response = await dioService.postData(
      url: AuthEndPoints.forgetPassword,
      body: {"mobile": p},
      isForm: true,
      loading: true,
    );
    if (response.isError == false) {
      Alerts.snack(
          text: response.response?.data['message'], state: SnackState.success);
      return response.response?.data['data'];
    } else {
      Alerts.snack(
          text: response.response?.data['message'], state: SnackState.failed);
      return null;
    }
  }

  resetPassword({
    required String code,
    required String pass,
    required String phone,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.resetPassword,
      body: {
        'code': code,
        'password': pass,
        'mobile': phone,
        'password_confirmation': pass,
      },
      isForm: true,
      loading: true,
    );
    if (response.isError == false) {
      Alerts.snack(
          text: response.response?.data['message'], state: SnackState.success);
      return true;
    } else {
      Alerts.snack(
          text: response.response?.data['message'], state: SnackState.failed);
      return null;
    }
  }
}
