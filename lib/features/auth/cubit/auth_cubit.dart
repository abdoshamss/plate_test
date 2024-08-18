import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../auth/domain/request/auth_request.dart';
import '../../../core/utils/Locator.dart';
import '../../../core/utils/utils.dart';
import '../domain/repository/auth_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  AuthRepository authRepository = AuthRepository(locator<DioService>());

  login({required AuthRequest loginRequestModel}) async {
    emit(LoginLoadingState());
    final response = await authRepository.loginRequest(loginRequestModel);

    if (response != null) {
      if (response['id'] == null) {
        emit(LoginErrorState());
        return false;
      } else {
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
