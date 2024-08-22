import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'add_ad_states.dart';

class AddAdCubit extends Cubit<AddAdStates> {
  AddAdCubit() : super(AddAdInitial());
  static AddAdCubit get(context) => BlocProvider.of(context);
  
 AddAdRepository add_adRepository =  AddAdRepository(locator<DioService>());
}