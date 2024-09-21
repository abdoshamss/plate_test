import 'package:plate_test/features/home/domain/repository/endpoints.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => HomeRepository(locator<DioService>()));
//  import '../../modules/home/domain/repository/repository.dart';
class HomeRepository {
  final DioService dioService;

  HomeRepository(this.dioService);

  homeRequest({String? keyWord, int? budgetId}) async {
    final response = await dioService
        .getData(url: HomeEndpoints.homeData, loading: true, query: {
      'keyword': keyWord,
      "budget_id": budgetId,
      "price_type": "",
    });
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }
}
