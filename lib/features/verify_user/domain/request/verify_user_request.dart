import 'dart:io';

import 'package:dio/dio.dart';

class VerifyUserRequest {
  File? frontImage;
  File? backImage;
  String? nationalId;

  VerifyUserRequest({this.frontImage, this.backImage, this.nationalId});

  late MultipartFile frontImageMultiplePartFile;
  late MultipartFile backImageMultiplePartFile;

  Future<Map<String, dynamic>> verifyRequest() async {
    Map<String, dynamic> data = {};
    print("checcckkkk");
    print(frontImage);
    print(backImage);
    if (frontImage != null || backImage != null) {
      data["national_image_front"] =
          MultipartFile.fromFileSync(frontImage!.path);
      data["national_image_back"] =
          MultipartFile.fromFileSync(backImage!.path);
    }
    data["national_id"] = nationalId;
    print(data);
    return data;
  }
}
