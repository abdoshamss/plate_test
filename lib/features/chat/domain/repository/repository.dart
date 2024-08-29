import 'package:plate_test/features/chat/domain/repository/endpoints.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => ChatRepository(locator<DioService>()));
//  import '../../modules/chat/domain/repository/repository.dart';
class ChatRepository {
  final DioService dioService;

  ChatRepository(this.dioService);

  getChatRooms() async {
    final response =
        await dioService.getData(url: ChatEndpoints.chatRooms, loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }
}
