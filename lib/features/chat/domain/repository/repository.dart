import 'package:plate_test/features/chat/domain/repository/endpoints.dart';
import 'package:pusher_client/pusher_client.dart';

import '../../../../core/data_source/dio_helper.dart';
import '../model/chat_details_model.dart';

//put it in locators locator.registerLazySingleton(() => ChatRepository(locator<DioService>()));
//  import '../../modules/chat/domain/repository/repository.dart';
class ChatRepository {
  final DioService dioService;

  ChatRepository(this.dioService);

  late PusherClient pusher;
  late Channel channel;

  getChatRooms() async {
    final response =
        await dioService.getData(url: ChatEndpoints.chatRooms, loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  Future<PaginationMessagesModel?> getMessages(
      {required int page, String? id}) async {
    final response = await dioService.getData(
      url: "${ChatEndpoints.chatDetails}/$id",
      query: {
        'page': page,
      },
    );
    if (response.isError == false) {
      return PaginationMessagesModel.fromJson(response.response?.data);
    } else {
      return null;
    }
  }

  sendMessageRequest(Message messageModel) async {
    final ApiResponse response = await dioService.postData(
      isFile: true,
      url: ChatEndpoints.sendMessage,
      body: await messageModel.sendMessageJson(),
      isForm: true,
    );

    if (response.isError == false) {
      return response.response?.data["data"];
    } else {
      return null;
    }
  }

// subscribeTochannel({
//   required String mychannel,
// }) {
//   channel = pusher.subscribe(
//     mychannel,
//   );
//   channel.bind("Chat", (event) {
//     log(event?.data.toString() ?? "", name: "pusher");
//   });
// }
//
// disconnect({
//   required String mychannel,
// }) {
//   pusher.unsubscribe(mychannel);
//   pusher.disconnect();
// }
}
