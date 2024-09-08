import '../../../../core/data_source/dio_helper.dart';
import 'endpoints.dart';

//put it in locators locator.registerLazySingleton(() => MyAdsRepository(locator<DioService>()));
//  import '../../modules/my_ads/domain/repository/repository.dart';
class MyAdsRepository {
  final DioService dioService;

  MyAdsRepository(this.dioService);

  Future getMyAdsDataRepo(String filter) async {
    final response = await dioService.getData(
      url: MyAdsEndpoints.myAdsData,
      loading: true,
      query: {
        'filter': filter,
      },
    );
    if (response.isError == false) {
      return response.response?.data;
    } else {
      return null;
    }
  }
}
