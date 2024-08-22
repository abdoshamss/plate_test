
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => ChatRepository(locator<DioService>()));
//  import '../../modules/chat/domain/repository/repository.dart';
class ChatRepository{
final  DioService dioService ;
  ChatRepository(this.dioService);
}
