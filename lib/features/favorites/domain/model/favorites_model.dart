class FavoritesModel {
  final bool? status;
  final String? message;
  final FavoritesItems? data;
  final Pagination? pagination;

  FavoritesModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? FavoritesItems.fromJson(json['data']) : null,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class FavoritesItems {
  final List<FavoritesItem>? item;

  FavoritesItems({
    required this.item,
  });

  factory FavoritesItems.fromJson(Map<String, dynamic> json) {
    return FavoritesItems(
      item: json['item'] != null
          ? List<FavoritesItem>.from(
              json['item'].map((item) => FavoritesItem.fromJson(item)))
          : null,
    );
  }
}

class FavoritesItem {
  final int? id;
  final String? image;
  final int? userId;
  final List<ItemImage>? images;
  final String? plate;
  final String? amount;
  final String? currency;
  final int? imagesCount;
  final bool? featured;
  final bool? userVerified;
  bool? isLiked;
  final bool? isSolid;
  final String? shareLink;
  final String? whatsapp;
  final String? mobile;
  final int? chatRoomId;
  final Location? location;

  get amountString => amount?.replaceAll(".00", "");

  FavoritesItem({
    required this.id,
    required this.image,
    required this.userId,
    required this.images,
    required this.plate,
    required this.amount,
    required this.currency,
    required this.imagesCount,
    required this.featured,
    required this.userVerified,
    required this.isLiked,
    required this.isSolid,
    required this.shareLink,
    required this.whatsapp,
    required this.mobile,
    required this.chatRoomId,
    required this.location,
  });

  factory FavoritesItem.fromJson(Map<String, dynamic> json) {
    return FavoritesItem(
      id: json['id'],
      image: json['image'],
      userId: json['user_id'],
      images: json['images'] != null
          ? List<ItemImage>.from(
              json['images'].map((image) => ItemImage.fromJson(image)))
          : null,
      plate: json['plate'],
      amount: json['amount'],
      currency: json['currency'],
      imagesCount: json['images_count'],
      featured: json['featured'],
      userVerified: json['user_verified'],
      isLiked: json['is_liked'],
      isSolid: json['is_solid'],
      shareLink: json['share_link'],
      whatsapp: json['whatsapp'],
      mobile: json['mobile'],
      chatRoomId: json['chat_room_id'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }
}

class ItemImage {
  final int? id;
  final String? image;
  final int? itemId;

  ItemImage({
    required this.id,
    required this.image,
    required this.itemId,
  });

  factory ItemImage.fromJson(Map<String, dynamic> json) {
    return ItemImage(
      id: json['id'],
      image: json['image'],
      itemId: json['item_id'],
    );
  }
}

class Location {
  final String? lat;
  final String? lng;
  final String? text;
  final String? city;

  Location({
    required this.lat,
    required this.lng,
    required this.text,
    required this.city,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
      text: json['text'],
      city: json['city'],
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
