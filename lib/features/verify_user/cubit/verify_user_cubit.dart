import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'verify_user_states.dart';

class VerifyUserCubit extends Cubit<VerifyUserStates> {
  VerifyUserCubit() : super(VerifyUserInitial());
  static VerifyUserCubit get(context) => BlocProvider.of(context);
  
 VerifyUserRepository verify_userRepository =  VerifyUserRepository(locator<DioService>());
}