class MyAdsModel {
  final bool? status;
  final String? message;
  final MyAdsItems? data;
  final Pagination? pagination;

  MyAdsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory MyAdsModel.fromJson(Map<String, dynamic> json) {
    return MyAdsModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? MyAdsItems.fromJson(json['data']) : null,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class MyAdsItems {
  final List<MyAdsItem>? items;

  MyAdsItems({
    required this.items,
  });

  factory MyAdsItems.fromJson(Map<String, dynamic> json) {
    return MyAdsItems(
      items: json['items'] != null
          ? List<MyAdsItem>.from(
              json['items'].map((item) => MyAdsItem.fromJson(item)))
          : null,
    );
  }
}

class MyAdsItem {
  final int? id;
  final String? image;
  final int? userId;
  final List<ItemImage>? images;
  final String? plate;
  final String? plateCode;
  final String? plateNumber;
  final String? description;
  final int? plateStyleId;
  final String? plateStyle;
  final int? categoryId;
  final String? category;
  final String? amount;
  final String? currency;
  final String? action;
  final int? imagesCount;
  final bool? featured;
  final bool? isSolid;
  final bool? appear;
  final bool? status;
  final Location? location;

  get stringAmount => amount!.replaceAll(".00", "");

  MyAdsItem({
    required this.id,
    required this.image,
    required this.userId,
    required this.images,
    required this.plate,
    required this.plateCode,
    required this.plateNumber,
    required this.description,
    required this.plateStyleId,
    required this.plateStyle,
    required this.categoryId,
    required this.category,
    required this.amount,
    required this.currency,
    required this.action,
    required this.imagesCount,
    required this.featured,
    required this.isSolid,
    required this.appear,
    required this.status,
    required this.location,
  });

  factory MyAdsItem.fromJson(Map<String, dynamic> json) {
    return MyAdsItem(
      id: json['id'],
      image: json['image'],
      userId: json['user_id'],
      images: json['images'] != null
          ? List<ItemImage>.from(
              json['images'].map((image) => ItemImage.fromJson(image)))
          : null,
      plate: json['plate'],
      plateCode: json['plate_code'],
      plateNumber: json['plate_number'],
      description: json['description'],
      plateStyleId: json['plate_style_id'],
      plateStyle: json['plate_style'],
      categoryId: json['category_id'],
      category: json['category'],
      amount: json['amount'],
      currency: json['currency'],
      action: json['action'],
      imagesCount: json['images_count'],
      featured: json['featured'],
      isSolid: json['is_solid'],
      appear: json['appear'],
      status: json['status'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }
}

class ItemImage {
  final int? id;
  final int? sort;
  final int? itemId;
  final String? image;
  final String? fileType;
  final String? video;

  ItemImage({
    required this.id,
    required this.sort,
    required this.itemId,
    required this.image,
    required this.fileType,
    this.video,
  });

  factory ItemImage.fromJson(Map<String, dynamic> json) {
    return ItemImage(
      id: json['id'],
      sort: json['sort'],
      itemId: json['item_id'],
      image: json['image'],
      fileType: json['file_type'],
      video: json['video'],
    );
  }
}

class Location {
  final double? lat;
  final double? lng;
  final String? text;

  Location({
    required this.lat,
    required this.lng,
    required this.text,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      text: json['text'],
    );
  }
}

class Pagination {
  final int? total;
  final int? lastPage;
  final int? totalPages;
  final int? perPage;
  final int? currentPage;
  final String? nextPageUrl;
  final String? prevPageUrl;

  Pagination({
    required this.total,
    required this.lastPage,
    required this.totalPages,
    required this.perPage,
    required this.currentPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      lastPage: json['lastPage'],
      totalPages: json['total_pages'],
      perPage: json['perPage'],
      currentPage: json['currentPage'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}
