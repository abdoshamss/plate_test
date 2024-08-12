
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => HomeRepository(locator<DioService>()));
//  import '../../modules/home/domain/repository/repository.dart';
class HomeRepository{
final  DioService dioService ;
  HomeRepository(this.dioService);
}
