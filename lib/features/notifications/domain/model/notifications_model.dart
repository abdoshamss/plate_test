import 'dart:convert';

class NotificationModel {
  String? id;
  NotificationItemModel? data;
  String? createdAt;
  String? day;
  bool? isRead;

  NotificationModel(this.id, this.createdAt, this.data, this.isRead, this.day);

  NotificationModel.fromMap(Map<String, dynamic> map) {
    id = map['id'] != null ? map['id'] as String : null;
    data =
        map['data'] != null ? NotificationItemModel.fromMap(map['data']) : null;
    createdAt = map['created_at'] != null ? map['created_at'] as String : null;
    isRead = map['is_read'] != null ? map['is_read'] as bool : null;
    if (createdAt != null) {
      day = createdAt?.split(" ").first;
    }
  }

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NotificationItemModel {
  String? title;
  String? message;
  String? type;
  String? roomId;
  String? likeId;

  NotificationItemModel({
    this.title,
    this.message,
    this.type,
    this.likeId,
    this.roomId,
  });

  factory NotificationItemModel.fromMap(Map<String, dynamic> map) {
    return NotificationItemModel(
      title: map['title'] != null ? map['title'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      roomId:
          map['room_id'] != null ? (map['room_id'] as int).toString() : null,
      likeId:
          map['like_id'] != null ? (map['like_id'] as int).toString() : null,
    );
  }

  factory NotificationItemModel.fromJson(String source) =>
      NotificationItemModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class NotificationPagination {
  List<NotificationModel>? notification;
  int? page;

  NotificationPagination({this.notification, this.page});

  NotificationPagination.fromMap(Map<String, dynamic> map) {
    page = map['pagination']["lastPage"] != null
        ? map['pagination']["lastPage"] as int
        : null;
    if (map["data"]['notifications'] != null) {
      notification = <NotificationModel>[];
      for (var e in (map['data']['notifications'] as List)) {
        notification?.add(
          NotificationModel.fromMap(e),
        );
      }
    }
  }
}
// class NotificationsModel {
//   final String? message;
//   final Data? data;
//   final Pagination? pagination;
//
//   NotificationsModel({
//     required this.message,
//     required this.data,
//     required this.pagination,
//   });
//
//   factory NotificationsModel.fromJson(Map<String, dynamic> json) {
//     return NotificationsModel(
//       message: json['message'] ?? "",
//       data: Data.fromJson(json['data'] ?? {}),
//       pagination: Pagination.fromJson(json['pagination'] ?? {}),
//     );
//   }
// }
//
// class Data {
//   List<Notificationns>? notifications;
//
//   Data({
//     required this.notifications,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       notifications: List<Notificationns>.from(
//         json['notifications']
//             .map((notification) => Notificationns.fromJson(notification ?? [])),
//       ),
//     );
//   }
// }
//
// class Notificationns {
//   String? id;
//   NotificationData? data;
//   bool? isRead;
//   String? createdAt;
//
//   Notificationns({
//     required this.id,
//     required this.data,
//     required this.isRead,
//     required this.createdAt,
//   });
//
//   factory Notificationns.fromJson(Map<String, dynamic> json) {
//     return Notificationns(
//       id: json['id'],
//       data: NotificationData.fromJson(json['data']),
//       isRead: json['is_read'],
//       createdAt: json['created_at'],
//     );
//   }
// }
//
// class NotificationData {
//   final String title;
//   final String message;
//   final String type;
//   final int roomId;
//   final int likeId;
//
//   NotificationData({
//     required this.title,
//     required this.message,
//     required this.type,
//     required this.roomId,
//     required this.likeId,
//   });
//
//   factory NotificationData.fromJson(Map<String, dynamic> json) {
//     return NotificationData(
//       title: json['title'],
//       message: json['message'],
//       type: json['type'],
//       roomId: json['room_id'],
//       likeId: json['like_id'],
//     );
//   }
// }
//
// class Pagination {
//   final int total;
//   final int count;
//   final int perPage;
//   final int currentPage;
//   final int totalPages;
//
//   Pagination({
//     required this.total,
//     required this.count,
//     required this.perPage,
//     required this.currentPage,
//     required this.totalPages,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) {
//     return Pagination(
//       total: json['total'],
//       count: json['count'],
//       perPage: json['per_page'],
//       currentPage: json['current_page'],
//       totalPages: json['total_pages'],
//     );
//   }
// }
