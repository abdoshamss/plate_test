import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/services/alerts.dart';
import 'package:plate_test/features/auth/domain/request/auth_request.dart';

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
          content: resposn["content"],
        ),
      );
    } else {
      emit(StaticpagesPolicyFailed());
    }
  }

  postFaqs({AuthRequest? authRequest}) async {
    emit(FaqsLoading());
    final resposn =
        await staticPageRepository.postContactus(authRequest: authRequest);
    if (resposn != null) {
      Alerts.snack(text: resposn["message"], state: SnackState.success);
      emit(
        FaqLaodedState(),
      );
    } else {
      Alerts.snack(
          text: resposn["message"] ?? "failed", state: SnackState.failed);

      emit(FaqsFailed());
    }
  }
}
