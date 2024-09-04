import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/features/item_details/domain/model/item_details_model.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'item_details_states.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsStates> {
  ItemDetailsCubit() : super(ItemDetailsInitial());

  static ItemDetailsCubit get(context) => BlocProvider.of(context);

  ItemDetailsRepository itemDetailsRepository =
      ItemDetailsRepository(locator<DioService>());

  getItemDetailsData(int id) async {
    emit(GetItemDetailsDataLoading());
    final response = await itemDetailsRepository.itemDetailsRequest(id);
    if (response != null) {
      emit(
          GetItemDetailsDataSuccess(data: ItemDetailsModel.fromJson(response)));
      return true;
    } else {
      emit(GetItemDetailsDataError());
      return null;
    }
  }
}
