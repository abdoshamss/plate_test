
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => ProfileRepository(locator<DioService>()));
//  import '../../modules/profile/domain/repository/repository.dart';
class ProfileRepository{
final  DioService dioService ;
  ProfileRepository(this.dioService);
}
