import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import '../domain/request/static_page_request.dart';
import 'states.dart';

class StaticPageCubit extends Cubit<StaticPageStates> {
  StaticPageCubit() : super(StaticPageInitial());

  static StaticPageCubit get(context) => BlocProvider.of(context);

  StaticPageRepository staticPageRepository =
      StaticPageRepository(locator<DioService>());

  //contact us
  contactUs({required ContactUsRequest contactUsRequest}) async {
    final response = await staticPageRepository.contactUs(
        contactUsRequest: contactUsRequest);
    if (response != null) {
      emit(ContactUsSendSuccess(
        message: response["message"],
      ));
    } else {}
  }

  // about us
  aboutUs() async {
    final response = await staticPageRepository.aboutUs();
    if (response != null) {
      return response;
    } else {}
  }

  @override
  void emit(StaticPageStates state) {
    if (isClosed) return;

    super.emit(state);
  }
}
