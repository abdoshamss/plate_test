
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => AddAdRepository(locator<DioService>()));
//  import '../../modules/add_ad/domain/repository/repository.dart';
class AddAdRepository{
final  DioService dioService ;
  AddAdRepository(this.dioService);
}
