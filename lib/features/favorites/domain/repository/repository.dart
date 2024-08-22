
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => FavoritesRepository(locator<DioService>()));
//  import '../../modules/favorites/domain/repository/repository.dart';
class FavoritesRepository{
final  DioService dioService ;
  FavoritesRepository(this.dioService);
}
