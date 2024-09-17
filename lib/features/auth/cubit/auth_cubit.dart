import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../../../core/utils/utils.dart';
import '../../../shared/widgets/myLoading.dart';
import '../../auth/domain/request/auth_request.dart';
import '../domain/repository/auth_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  AuthRepository authRepository = AuthRepository(locator<DioService>());
  bool? canCheckBiometrics;
  LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? availableBiometrics;

  Future<bool?> cancheckbio() async {
    canCheckBiometrics = await auth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  Future<void> checkBiometric(bool value) async {
    // bool? canCheckBiometrics;
    bool isLoading = true;

    try {
      if (isLoading == true) MyLoading.show();
      canCheckBiometrics = await auth.canCheckBiometrics;
      if (canCheckBiometrics == true) {
        availableBiometrics = await auth.getAvailableBiometrics();
        if (availableBiometrics!.contains(BiometricType.face)) {
          await Utils.dataManager.saveBiometric(value: value);

          emit(FaceIdSuccessState());
          // MyLoading.dismis();
          isLoading = false;
        } else {
          await Utils.dataManager.saveBiometric(value: value);
          isLoading = false;
          emit(FaceIdSuccessState());
          // Future.delayed(
          //   Duration(seconds: 1),
          //   () {
          //     MyLoading.dismis();
          //   },
          // );
          // MyLoading.dismis();
        }
        // else if (availableBiometrics!.contains(BiometricType.fingerprint)) {
        //             Utils.dataManager.saveBiometric(value: value);
        // MyLoading.dismis();
        //   print("Strong");
        // }
      }
      if (isLoading == false) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            MyLoading.dismis();
          },
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  googleRegister() async {
    emit(LoginLoadingState());
    final res = await googleSignIn();
    if (res == null) {
      emit(LoginErrorState());
      return;
    }
    AuthRequest authRequest = AuthRequest(
      email: res.email,
      name: res.displayName,
      social_id: res.id,
      image: res.photoUrl,
    );
    final response = await authRepository.googleRegisterRequest(authRequest);
    if (response != null) {
      await Utils.saveUserInHive(response);
      emit(RegisterSocialDone());
    } else {
      await Utils.googleSignIn.disconnect();
      emit(RegisterSocialError());
    }
  }

  googleLogin() async {
    emit(LoginLoadingState());
    final res = await googleSignIn();
    if (res == null) {
      emit(LoginErrorState());
      return;
    }
    AuthRequest authRequest = AuthRequest(
      email: res.email,
      name: res.displayName,
      social_id: res.id,
      image: res.photoUrl,
    );
    final response = await authRepository.googleSignInRequest(authRequest);
    if (response != null) {
      await Utils.saveUserInHive(response);
      if (response['user']['area']?.toString().isEmpty == true) {
        emit(NeedAddArea());
        return;
      } else {
        emit(LoginSuccessState());
        return;
      }
    } else {
      await Utils.googleSignIn.disconnect();
      emit(LoginErrorState());
      return null;
    }
  }

  appleRegister() async {
    emit(LoginLoadingState());
    final res = await appleSignIn();
    if (res == null) {
      emit(LoginErrorState());
      return;
    }
    AuthRequest authRequest = AuthRequest(
      email: res.email,
      name: res.givenName,
      social_id: res.userIdentifier,
    );
    final response = await authRepository.appleRegisterRequest(authRequest);
    if (response != null) {
      await Utils.saveUserInHive(response);
      emit(RegisterSocialDone());
    } else {
      await Utils.googleSignIn.disconnect();
      emit(RegisterSocialError());
    }
  }

  appleLoginIn() async {
    emit(LoginLoadingState());
    final res = await appleSignIn();
    if (res == null) {
      emit(LoginErrorState());
      return;
    }
    AuthRequest authRequest = AuthRequest(
      email: res.email,
      name: res.givenName,
      social_id: res.userIdentifier,
    );
    final response = await authRepository.appleSignInRequest(authRequest);
    if (response != null) {
      await Utils.saveUserInHive(response);
      if (response['user']['area']?.toString().isEmpty == true) {
        emit(NeedAddArea());
        return;
      } else {
        emit(LoginSuccessState());
        return;
      }
    } else {
      await Utils.googleSignIn.disconnect();
      emit(LoginErrorState());
      return null;
    }
  }

  Future<GoogleSignInAccount?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser!.authentication;
      return googleUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AuthorizationCredentialAppleID?> appleSignIn() async {
    try {
      AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      return credential;
    } catch (e) {
      print(e);
      return null;
    }
  }

  login({required AuthRequest loginRequestModel}) async {
    emit(LoginLoadingState());
    final response = await authRepository.loginRequest(loginRequestModel);
    if (response != null) {
      if (response["active"] == false) {
        emit(LoginErrorState());
        return false;
      } else {
        print("response" * 88);
        print(response);
        await Utils.saveUserInHive(response);
        emit(LoginSuccessState());
        return true;
      }
    } else {
      emit(LoginErrorState());
      return null;
    }
  }

  signUp({required AuthRequest registerRequestModel}) async {
    emit(RegisterLoadingState());
    final response = await authRepository.registerRequest(registerRequestModel);
    if (response != null) {
      emit(RegisterSuccessState());
      return true;
    } else {
      emit(RegisterErrorState());
      return false;
    }
  }

  resendCode(String phone) async {
    emit(ResendCodeLoadingState());
    final response = await authRepository.resendCodeRequest(phone);

    if (response != null) {
      emit(ResendCodeSuccessState());

      return true;
    } else {
      emit(ResendCodeErrorState());
      return null;
    }
  }

  activate({required AuthRequest registerRequestModel}) async {
    emit(ActivateCodeLoadingState());

    final response = await authRepository.activateRequest(registerRequestModel);
    if (response != null) {
      emit(ActivateCodeSuccessState());
      // emit(ActivateCodeSuccessState(UserModel.fromJson(response)));
      return true;
    } else {
      emit(ActivateCodeErrorState());
      return null;
    }
  }

  String codeId = "";

  forgetPass(String p) async {
    emit(ForgetPassLoadingState());
    var res = await authRepository.forgetPassRequest(p);
    if (res != null) {
      emit(ForgetPassSuccessState());
      codeId = res["code"].toString();

      return true;
    } else {
      emit(ForgetPassErrorState());
      return null;
    }
  }

  // sendCode({required String email, required String code}) async {
  //   emit(ActivateCodeLoadingState());
  //   final response =
  //       await authRepository.sendCodeRequest(email: email, code: code);
  //   if (response != null) {
  //     codeId = response['code_id'].toString();
  //     emit(ActivateCodeSuccessState());
  //     return true;
  //   } else {
  //     emit(ActivateCodeErrorState());
  //     return null;
  //   }
  // }

  resetPassword({
    required String code,
    required String pass,
    required String phone,
  }) async {
    emit(ResetPasswordLoadingState());
    var res = await authRepository.resetPassword(
      code: code,
      pass: pass,
      phone: phone,
    );
    if (res != null) {
      emit(ResetPasswordSuccessState());
      return res;
    } else {
      emit(ResetPasswordErrorState());
      return null;
    }
  }
}
