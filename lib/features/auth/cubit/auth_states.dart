import '../../../core/utils/Utils.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class GetAreasLoadingState extends AuthStates {}

class GetAreasSuccessState extends AuthStates {}

class GetAreasErrorState extends AuthStates {}

class NeedActivate extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

class ResendCodeLoadingState extends AuthStates {}

class ResendCodeSuccessState extends AuthStates {}

class ResendCodeErrorState extends AuthStates {}

class ForgetPassLoadingState extends AuthStates {}

class ForgetPassSuccessState extends AuthStates {}

class ForgetPassErrorState extends AuthStates {}

class ActivateCodeLoadingState extends AuthStates {}

class ActivateCodeSuccessState extends AuthStates {
  final Map<String, dynamic> response;

  ActivateCodeSuccessState(this.response) {
    saveData();
  }

  Future<void> saveData() async {
    await Utils.saveUserInHive(response);
  }
}

class ActivateCodeErrorState extends AuthStates {}

class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {}

class ResetPasswordErrorState extends AuthStates {}

class FaceIdSuccessState extends AuthStates {}

class FaceIdFailedState extends AuthStates {}

class FinishSelectArea extends AuthStates {}

class RegisterSocialDone extends AuthStates {}

class RegisterSocialError extends AuthStates {}

class NeedAddArea extends AuthStates {}
