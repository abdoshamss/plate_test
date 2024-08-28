import 'dart:io';

import 'package:dio/dio.dart';

class AddAdRequest {
  List<File>? images;

  double? lat, lng, amount;
  int? categoryID, plateNumber, itemStyleId;
  String? description, location, plateCode;

  AddAdRequest({
    this.plateCode,
    this.itemStyleId,
    this.plateNumber,
    this.categoryID,
    this.lat,
    this.lng,
    this.description,
    this.amount,
    this.location,
    this.images,
  }) {
    imageToMultiPartFiles(images ?? []);
  }

  List<MultipartFile> multipartFileList = [];

  Future<List<MultipartFile>> imageToMultiPartFiles(List<File> images) async {
    for (File image in images) {
      multipartFileList.add(await MultipartFile.fromFile(image.path));
    }
    return multipartFileList;
  }

  Map<String, dynamic> requestMap() {
    return {
      'images[]': multipartFileList,
      'location[lat]': lat,
      'location[lng]': lng,
      'location[text]': location,
      'category_id': categoryID,
      'item_style_id': itemStyleId,
      'plate_number': plateNumber,
      'plate_code': plateCode,
      'amount': amount,
      'description': description,
    };
  }
}
