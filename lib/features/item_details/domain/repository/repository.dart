
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => ItemDetailsRepository(locator<DioService>()));
//  import '../../modules/item_details/domain/repository/repository.dart';
class ItemDetailsRepository{
final  DioService dioService ;
  ItemDetailsRepository(this.dioService);
}
