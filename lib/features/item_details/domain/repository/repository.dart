import 'package:plate_test/features/item_details/domain/repository/endpoints.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => ItemDetailsRepository(locator<DioService>()));
//  import '../../modules/item_details/domain/repository/repository.dart';
class ItemDetailsRepository {
  final DioService dioService;

  ItemDetailsRepository(this.dioService);

  itemDetailsRequest(int id) async {
    final response = await dioService.getData(
        url: ItemDetailsEndpoints.itemDetails + id.toString(), loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }
}
