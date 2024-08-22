
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => MyAdsRepository(locator<DioService>()));
//  import '../../modules/my_ads/domain/repository/repository.dart';
class MyAdsRepository{
final  DioService dioService ;
  MyAdsRepository(this.dioService);
}
