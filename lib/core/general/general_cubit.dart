import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/data_source/dio_helper.dart';
import 'package:plate_test/core/general/general_repo.dart';

import '../utils/Locator.dart';
import '../utils/Utils.dart';

part 'areas_models.dart';
part 'general_state.dart';

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

  changLang(Locale locale, BuildContext context) {
    context.setLocale(locale);
    Utils.lang = locale.languageCode;
    emit(LangChangedSuccessfully());
  }
}
