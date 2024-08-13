import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/data_source/dio_helper.dart';
import 'package:plate_test/core/general/general_repo.dart';

import '../utils/Locator.dart';

part 'general_state.dart';
part 'areas_models.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralInitial());
  static GeneralCubit get(context) => BlocProvider.of(context);
   GeneralRepo generalRepo = GeneralRepo(locator<DioService>());
   

  //change app theme
  bool isLightMode = true;
  changeAppTheme() {
    isLightMode = !isLightMode;
    emit(GeneralChangeAppTheme());
  }


 
}
