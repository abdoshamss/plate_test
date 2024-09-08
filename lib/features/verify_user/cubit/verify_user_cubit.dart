import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import '../domain/request/verify_user_request.dart';
import 'verify_user_states.dart';

class VerifyUserCubit extends Cubit<VerifyUserStates> {
  VerifyUserCubit() : super(VerifyUserInitial());

  static VerifyUserCubit get(context) => BlocProvider.of(context);

  VerifyUserRepository verifyUserRepository =
      VerifyUserRepository(locator<DioService>());

  verify({required VerifyUserRequest verifyUserRequest}) async {
    emit(VerifyUserLoading());
    final response = await verifyUserRepository.verifyRepo(
        verifyUserRequest: verifyUserRequest);
    if (response != null) {
      emit(VerifyUserSuccess(message: response["message"]));
      return true;
    } else {
      emit(VerifyUserError());
      return null;
    }
  }
}
