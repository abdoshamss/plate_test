import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class PaginationMessagesModel {
  List<Message>? messages;
  Map? map;
  String? date;
  int? page;
  Other? other;
  int? roomId;
  ItemChat? item;

  PaginationMessagesModel({
    this.messages,
    this.date,
    this.map,
    this.other,
    this.page,
    this.roomId,
    this.item,
  });

  PaginationMessagesModel.fromJson(Map<String, dynamic> json) {
    page = json['pagination']['lastPage'];
    item = json["data"]["item"] != null
        ? ItemChat.fromMap(
            json["data"]["item"],
          )
        : null;
    other = json["data"]["other"] != null
        ? Other.fromMap(json["data"]["other"])
        : null;
    if (json['data']["messages"] != null) {
      messages = <Message>[];
      map = json['data']["messages"]["dataPaginations"];
      map?.keys.toList().forEach((e) {
        date = e;
        for (var v
            in (json['data']["messages"]["dataPaginations"][e] as List)) {
          messages!.add(Message.fromMap(v));
        }
      });
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// class Messages {
//   Map<String, List<Message>>? map;
//   List<String>? keys;
//   List<Messages>? messages;
//   Messages({this.map, this.keys, this.messages});

//   Messages.fromMap(Map<String, dynamic> map) {
//     map = map["messages"]["dataPaginations"] != null
//         ? map["messages"]["dataPaginations"]
//         : null;
//     keys = map.keys.toList();
//   }

//   factory Messages.fromJson(String source) =>
//       Messages.fromMap(json.decode(source) as Map<String, dynamic>);
// }

class Message {
  int? id;
  bool? isSender;
  bool? isSeen;
  String? message;
  String? attachMent;
  String? createdAt;
  String? roomId;
  File? file;
  bool? isLoading;
  bool? faildToSent = false;

  Message({
    this.id,
    this.isSender,
    this.isSeen,
    this.message,
    this.attachMent,
    this.createdAt,
    this.roomId,
    this.file,
    this.faildToSent,
    this.isLoading = false,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as int : null,
      isSender: map['is_sender'] != null ? map['is_sender'] as bool : null,
      isSeen: map['is_seen'] != null ? map['is_seen'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      attachMent:
          map['attachment'] != null ? map['attachment'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  Future<Map<String, dynamic>> sendMessageJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["room_id"] = roomId;
    data['message'] = message;
    if (file != null) {
      data['file'] = await MultipartFile.fromFile(file!.path,
          filename: file!.path.split(Platform.pathSeparator).last);
    }
    return data;
  }

  Future<Map<String, dynamic>> msgSave() async {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['message'] = message;
    data['room_id'] = roomId;
    // data["from_id"] = Utils.userModel.id;
    // data['to'] = to;
    data['created_at'] = createdAt;
    if (file != null) data['imagePath'] = file?.path;

    return data;
  }

  Message.fromHive(Map json) {
    // from?.id = json['from_id'];
    id = json['id'] != null ? json['id'] as int : null;
    isSender = json['is_sender'] != null ? json['is_sender'] as bool : null;
    isSeen = json['is_seen'] != null ? json['is_seen'] as bool : null;
    message = json['message'] != null ? json['message'] as String : null;
    attachMent =
        json['attachment'] != null ? json['attachment'] as String : null;
    createdAt =
        json['created_at'] != null ? json['created_at'] as String : null;
    message = json['message'];

    // to = json['to'];
    roomId = json['room_id'];
    createdAt = json['created_at'];

    if (json['imagePath'] != null) file = File(json['imagePath']);
  }
}

class ItemChat {
  int? id;
  String? image;
  String? plate;
  String? price;
  String? currency;
  String? platenum;
  String? platecode;

  ItemChat({
    this.id,
    this.image,
    this.plate,
    this.price,
    this.currency,
    this.platecode,
    this.platenum,
  });

  ItemChat.fromMap(Map<String, dynamic> map) {
    platecode = map['plate']?.split(" ").last;
    platenum = map['plate']?.split(" ").first;
    id = map['id'] != null ? map['id'] as int : null;
    image = map['image'] != null ? map['image'] as String : null;
    plate = platecode != null && platenum != null
        ? "$platenum\u200E ${platecode?.split("").join(" ")}"
        : null;
    price = map['price'] != null ? map['price'] as String : null;
    currency = map['currency'] != null ? map['currency'] as String : null;
  }

  factory ItemChat.fromJson(String source) =>
      ItemChat.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Other {
  int? id;
  String? name;
  String? image;
  bool? online;

  Other({
    this.id,
    this.name,
    this.image,
    this.online,
  });

  factory Other.fromMap(Map<String, dynamic> map) {
    return Other(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      online: map['online'] != null ? map['online'] as bool : null,
    );
  }

  factory Other.fromJson(String source) =>
      Other.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChatModel {
  int? id;
  String? name;
  String? image;
  int? messagesCount;
  String? lastMessage;
  String? createdAt;
  String? messageType;

  ChatModel({
    this.id,
    this.name,
    this.image,
    this.messagesCount,
    this.lastMessage,
    this.createdAt,
    this.messageType,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      messagesCount:
          map['messages_count'] != null ? map['messages_count'] as int : null,
      lastMessage:
          map['last_message'] != null ? map['last_message'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      messageType: map['last_message_type'] != null
          ? map['last_message_type'] as String
          : null,
    );
  }

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChatsModel {
  List<ChatModel>? chats;

  ChatsModel({
    this.chats,
  });

  ChatsModel.fromMap(Map<String, dynamic> map) {
    if (map["chats"] != null) {
      chats = <ChatModel>[];
      for (var e in (map["chats"] as List)) {
        chats?.add(
          ChatModel.fromMap(e),
        );
      }
    }
  }

  factory ChatsModel.fromJson(String source) =>
      ChatsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// class ChatDetailsModel {
//
//   bool? status;
//   String? message;
//   Data ?data;
//   Pagination? pagination;
//
//   ChatDetailsModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     message = json['message'];
//     data = Data.fromJson(json['data']);
//     pagination = Pagination.fromJson(json['pagination']);
//   }
//
//
// }
//
// class Data {
//
//   late final int? roomId;
//   late final Other? other;
//   late final Item ?item;
//   late final Messages? messages;
//
//   Data.fromJson(Map<String, dynamic> json){
//     roomId = json['room_id'];
//     other = Other.fromJson(json['other']);
//     item = Item.fromJson(json['item']);
//     messages = Messages.fromJson(json['messages']);
//   }
//
//
// }
//
// class Other {
//
//     int? id;
//     String? name;
//     String? image;
//     bool? online;
//
//   Other.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     online = json['online'];
//   }
//
// }
//
// class Item {
//
//     int? id;
//     String? image;
//     String? plate;
//     String? price;
//     String? currency;
//
//   Item.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     image = json['image'];
//     plate = json['plate'];
//     price = json['price'];
//     currency = json['currency'];
//   }
//
//
// }
//
// class Messages {
//
//   late final DataPaginations? dataPaginations;
//
//   Messages.fromJson(Map<String, dynamic> json){
//     dataPaginations = DataPaginations.fromJson(json['dataPaginations']);
//   }
//
//
// }
//
// class DataPaginations {
//
// late final List<Day> days;
//
// DataPaginations.fromJson(Map<String, dynamic> json){
// اليوم = List.from(json['اليوم']).map((e)=>اليوم.fromJson(e)).toList();
// }
//
// Map<String, dynamic> toJson() {
// final _data = <String, dynamic>{};
// _data['اليوم'] = اليوم.map((e)=>e.toJson()).toList();
// return _data;
// }
// }
//
// class اليوم {
// اليوم({
// required this.id,
// required this.isSender,
// required this.isSeen,
// required this.message,
// required this.attachment,
// required this.createdAt,
// });
// late final int id;
// late final bool isSender;
// late final bool isSeen;
// late final String message;
// late final String attachment;
// late final String createdAt;
//
// اليوم.fromJson(Map<String, dynamic> json){
// id = json['id'];
// isSender = json['is_sender'];
// isSeen = json['is_seen'];
// message = json['message'];
// attachment = json['attachment'];
// createdAt = json['created_at'];
// }
//
// Map<String, dynamic> toJson() {
// final _data = <String, dynamic>{};
// _data['id'] = id;
// _data['is_sender'] = isSender;
// _data['is_seen'] = isSeen;
// _data['message'] = message;
// _data['attachment'] = attachment;
// _data['created_at'] = createdAt;
// return _data;
// }
// }
//
// class Pagination {
// Pagination({
// required this.total,
// required this.lastPage,
// required this.totalPages,
// required this.perPage,
// required this.currentPage,
// this.nextPageUrl,
// this.prevPageUrl,
// });
// late final int total;
// late final int lastPage;
// late final int totalPages;
// late final int perPage;
// late final int currentPage;
// late final Null nextPageUrl;
// late final Null prevPageUrl;
//
// Pagination.fromJson(Map<String, dynamic> json){
// total = json['total'];
// lastPage = json['lastPage'];
// totalPages = json['total_pages'];
// perPage = json['perPage'];
// currentPage = json['currentPage'];
// nextPageUrl = null;
// prevPageUrl = null;
// }
//
// Map<String, dynamic> toJson() {
// final _data = <String, dynamic>{};
// _data['total'] = total;
// _data['lastPage'] = lastPage;
// _data['total_pages'] = totalPages;
// _data['perPage'] = perPage;
// _data['currentPage'] = currentPage;
// _data['next_page_url'] = nextPageUrl;
// _data['prev_page_url'] = prevPageUrl;
// return _data;
// }
// }
