import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/model/home_model.dart';
import '../domain/repository/repository.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeRepository homeRepository = HomeRepository(locator<DioService>());

  getHomeData() async {
    emit(GetHomeDataLoading());
    final response = await homeRepository.homeRequest();
    if (response != null) {
      emit(GetHomeDataSuccess(HomeModel.fromJson(response)));
      return true;
    } else {
      emit(GetHomeDataError());
      return null;
    }
  }
}
