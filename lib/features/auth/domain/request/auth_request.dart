import 'dart:io';

import '../../../../core/utils/utils.dart';

class AuthRequest {
  String? name;
  String? email;
  String? phone;
  String? code;
  String? type;
  String? createdAt;
  String? token;
  String? password;
  String? agree;
  String? fcm_token;
  String? password_confirmation;
  int? areaID;
  AuthRequest({
    this.name,
    this.email,
    this.phone,
    this.type,
    this.createdAt,
    this.fcm_token,
    this.token,
    this.password,
    this.agree,
    this.password_confirmation,
    this.areaID,
  });

  Map<String, dynamic> register() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'mobile': "$phone",
      'type': type,
      'password': password,
      'agree': agree,
      'password_confirmation': password_confirmation,
      'fcm_token': fcm_token,
      "area_id": areaID,
      "lang": "en"
    };
  }

  Map<String, dynamic> login() {
    return <String, dynamic>{
      'fcm_token': Utils.FCMToken,
      'mobile': phone,
      'uuid': Utils.uuid,
      'password': password,
      "device_token": "",
      "device_type": Platform.operatingSystem
    };
  }

  Map<String, dynamic> activate() {
    return <String, dynamic>{
      'code': code,
      'uuid': Utils.uuid,
      'mobile': "$phone",
      // 'mobile': "${code}${phone}",
      'device_type': Platform.isIOS ? "ios" : "android",
      'device_token': Utils.FCMToken,
    };
  }
}
