import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/model/my_ads_model.dart';
import '../domain/repository/repository.dart';
import 'my_ads_states.dart';

class MyAdsCubit extends Cubit<MyAdsStates> {
  MyAdsCubit() : super(MyAdsInitial());

  static MyAdsCubit get(context) => BlocProvider.of(context);

  MyAdsRepository myAdsRepository = MyAdsRepository(locator<DioService>());

  getMyAdsData(String filter) async {
    emit(GetMyAdsDataLoading());
    final response = await myAdsRepository.getMyAdsDataRepo(filter);

    if (response != null) {
      emit(GetMyAdsDataSuccess(date: MyAdsModel.fromJson(response)));
      return true;
    } else {
      emit(GetMyAdsDataError());
      return null;
    }
  }
}
