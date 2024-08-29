class ChatModel {
  bool? status;
  String? message;
  Data? data;

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'] ?? '';
    data = Data.fromJson(json['data'] ?? {});
  }
}

class Data {
  List<Chats>? chats;

  Data.fromJson(Map<String, dynamic> json) {
    chats =
        List.from(json['chats'] ?? []).map((e) => Chats.fromJson(e)).toList();
  }
}

class Chats {
  int? id;
  String? name;
  String? image;
  int? messagesCount;
  String? lastMessage;
  String? lastMessageType;
  String? createdAt;

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    messagesCount = json['messages_count'];
    lastMessage = json['last_message'];
    lastMessageType = json['last_message_type'];
    createdAt = json['created_at'];
  }
}
