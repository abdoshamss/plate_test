import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
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
}
