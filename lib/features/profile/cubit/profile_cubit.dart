import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../../auth/domain/model/auth_model.dart';
import '../../auth/domain/request/auth_request.dart';
import '../domain/model/profile_model.dart';
import '../domain/repository/repository.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileRepository profileRepository =
      ProfileRepository(locator<DioService>());

  logOut(String uuid) async {
    emit(LogOutLoading());
    final response = await profileRepository.logOutRepo(uuid);
    if (response == true) {
      emit(LogOutSuccess());
      return true;
    } else {
      emit(LogOutError());
      return null;
    }
  }

  deleteAccount() async {
    emit(DeleteAccountLoading());
    final response = await profileRepository.deleteAccountRepo();
    if (response == true) {
      emit(DeleteAccountSuccess());
      return true;
    } else {
      emit(DeleteAccountError());
      return null;
    }
  }

  getProfileData() async {
    emit(GetProfileDataLoading());
    final response = await profileRepository.getProfileRequest();
    if (response != null) {
      emit(GetProfileDataSuccess(user: ProfileUser.fromJson(response['user'])));
      return true;
    } else {
      emit(GetProfileDataError());
      return null;
    }
  }

  editProfileCubit({required AuthRequest authRequest}) async {
    emit(EditProfileLoadingState());
    final res = await profileRepository.editProfileRepo(authRequest);

    if (res != null) {
      if (res["user"]["mobile_verified"] == false) {
        emit(MobileChanged());
      } else {
        emit(EditProfileSuccessState());
      }

      // return true;
    } else {
      emit(EditProfileErrorState());
      // return false;
    }
  }

  editPasswordCubit({required AuthRequest authRequest}) async {
    emit(EditPasswordLoadingState());
    final response = await profileRepository.editPasswordRepo(authRequest);
    if (response != null) {
      emit(EditPasswordSuccessState());
    } else {
      emit(EditPasswordErrorState());
      return null;
    }
  }

  activate({required AuthRequest authRequest}) async {
    emit(ActivateMobileLoading());
    final response = await profileRepository.activateRequest(authRequest);
    if (response != null) {
      emit(ActivateMobileLoaded(UserModel.fromJson(response)));
      return true;
    } else {
      emit(ActivateMobileError());
      return null;
    }
  }

  resendCode(String phone) async {
    emit(ResendCodeLoading());
    final response = await profileRepository.resendCodeRequest(phone);

    if (response != null) {
      emit(ResendCodeSuccess());

      return true;
    } else {
      emit(ResendCodeError());
      return null;
    }
  }

// contactUs(ContactRq req) async {
//   // emit(FaqsLoading());
//   final resposn = await profileRepo.sendMessage(
//     req,
//   );
//   if (resposn != null) {
//     return true;
//     // emit(
//     //   FaqLaodedState(
//     //     StaticPageModel.fromMap(resposn),
//     //   ),
//     // );
//   } else {
//     // emit(FaqsFailed());
//   }
// }
//
// deleteAccount() async {
//   final response = await profileRepo.deleteAccount();
//   if (response != null) {
//     Utils.deleteUserData();
//     await FBMessging.revokeToken();
//     emit(DeleteUserSuccess());
//     return true;
//   } else {
//     return null;
//   }
// }
}
