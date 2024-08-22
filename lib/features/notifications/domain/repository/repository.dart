
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => NotificationsRepository(locator<DioService>()));
//  import '../../modules/notifications/domain/repository/repository.dart';
class NotificationsRepository{
final  DioService dioService ;
  NotificationsRepository(this.dioService);
}
