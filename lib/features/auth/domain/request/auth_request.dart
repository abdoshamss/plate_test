import 'dart:io';

import 'package:dio/dio.dart';

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
  String? image;
  String? message;

  String? social_id;

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
    this.social_id,
    this.password_confirmation,
    this.areaID,
    this.image,
    this.message,
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
      // 'fcm_token': Utils.FCMToken,
      'mobile': phone,
      'uuid': Utils.uuid,
      'password': password,
      "device_token": Utils.FCMToken,
      "device_type": Platform.operatingSystem
    };
  }

  Map<String, dynamic> editProfile() {
    MultipartFile? file;
    if (image != null) {
      file = MultipartFile.fromFileSync(image!);
    }
    return <String, dynamic>{
      'name': name,
      'email': email,
      'mobile': phone,
      'image': file,
      if (areaID != null) 'area_id': areaID,
    };
  }

  Map<String, dynamic> editPassword() {
    return <String, dynamic>{
      'password': password,
      'password_confirmation': password_confirmation,
      'mobile': phone,
      'code': code,
    };
  }

  Map<String, dynamic> gooleRegister() {
    return <String, dynamic>{
      'device_type': Platform.isIOS ? "ios" : "android",
      'device_token': Utils.FCMToken,
      'uuid': Utils.uuid,
      'social_id': social_id,
      'image': image,
      'name': name,
      'email': email,
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
