import 'endpoints.dart';

import '../model/verify_user_model.dart';
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => VerifyUserRepository(locator<DioService>()));
//  import '../../modules/verify_user/domain/repository/repository.dart';
class VerifyUserRepository{
final  DioService dioService ;
  VerifyUserRepository(this.dioService);
}
