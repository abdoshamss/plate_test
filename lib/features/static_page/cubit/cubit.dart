import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'states.dart';

class StaticPageCubit extends Cubit<StaticPageStates> {
  StaticPageCubit() : super(StaticPageInitial());

  static StaticPageCubit get(context) => BlocProvider.of(context);

  StaticPageRepository staticPageRepository =
      StaticPageRepository(locator<DioService>());

  getaboutPage() async {
    emit(StaticpagesAboutLoading());
    final resposn = await staticPageRepository.getAbout();
    if (resposn != null) {
      emit(
        StaticpagesAboutLoaded(
          content: resposn["content"],
          // StaticPageModel.fromMap(resposn),
        ),
      );
    } else {
      emit(StaticpagesAboutFailed());
    }
  }

  getPolicyPage() async {
    emit(StaticpagesPolicyLoading());
    final resposn = await staticPageRepository.getPolicy();
    if (resposn != null) {
      emit(
        StaticpagesPolicyLoaded(
            // StaticPageModel.fromMap(resposn),
            ),
      );
    } else {
      emit(StaticpagesPolicyFailed());
    }
  }

  getFaqs() async {
    emit(FaqsLoading());
    final resposn = await staticPageRepository.getFaqs();
    if (resposn != null) {
      emit(
        FaqLaodedState(
            // Questions.fromMap(resposn),
            ),
      );
    } else {
      emit(FaqsFailed());
    }
  }
}
