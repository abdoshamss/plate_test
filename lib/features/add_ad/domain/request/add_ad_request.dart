import 'dart:io';

import 'package:dio/dio.dart';

class AddAdRequest {
  List<File>? images;

  double? lat, lng, amount;
  int? categoryID, plateNumber, itemStyleId;
  String? description, location, plateCode;
  bool? isFeatured, isBid;

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
    this.isFeatured,
    this.isBid,
  });

  Map<String, dynamic> requestMap() {
    Map<String, dynamic> data = {};
    if (images != null) {
      List<MultipartFile> files = <MultipartFile>[];
      for (File image in images!) {
        files.add(MultipartFile.fromFileSync(image.path));
      }
      data['images[]'] = files;
    }

    data['location[lat]'] = lat;
    data['location[lng]'] = lng;
    data['location[text]'] = location;
    data['category_id'] = categoryID;
    data['item_style_id'] = itemStyleId;
    data['plate_number'] = plateNumber;
    data['plate_code'] = plateCode;
    data['amount'] = amount;
    data['description'] = description;
    data['is_bid'] = isBid == true ? 1 : 0;
    data['featured'] = isFeatured == true ? 1 : 0;
    return data;
  }
}
