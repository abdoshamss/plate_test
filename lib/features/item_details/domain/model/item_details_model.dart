class ItemDetailsModel {
  final Item? item;
  final List<RelatedItem>? related;

  ItemDetailsModel({
    required this.item,
    required this.related,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailsModel(
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      related: json['related'] != null
          ? List<RelatedItem>.from(
              json['related'].map((item) => RelatedItem.fromJson(item)))
          : null,
    );
  }
}

class Item {
  final int? id;
  final bool? isOwner;
  final int? userId;
  final bool? isActive;
  final bool? appear;
  final List<ItemImage>? images;
  final bool? featured;
  final String? plate;
  final String? amount;
  final String? currency;
  final Details? details;
  final String? description;
  final User? user;
  final bool? isSolid;
  bool? isLiked;
  final String? shareLink;
  final String? whatsapp;
  final String? mobile;
  final int? chatRoomId;
  final Location? location;

  get amountString => amount?.replaceAll(".00", "");

  Item({
    required this.id,
    required this.isOwner,
    required this.userId,
    required this.isActive,
    required this.appear,
    required this.images,
    required this.featured,
    required this.plate,
    required this.amount,
    required this.currency,
    required this.details,
    required this.description,
    required this.user,
    required this.isSolid,
    required this.isLiked,
    required this.shareLink,
    required this.whatsapp,
    required this.mobile,
    required this.chatRoomId,
    required this.location,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      isOwner: json['is_owner'],
      userId: json['user_id'],
      isActive: json['is_active'],
      appear: json['appear'],
      images: json['images'] != null
          ? List<ItemImage>.from(
              json['images'].map((image) => ItemImage.fromJson(image)))
          : null,
      featured: json['featured'],
      plate: json['plate'],
      amount: json['amount'],
      currency: json['currency'],
      details:
          json['details'] != null ? Details.fromJson(json['details']) : null,
      description: json['description'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      isSolid: json['is_solid'],
      isLiked: json['is_liked'],
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
  final String? createdAt;
  final String? updatedAt;

  ItemImage({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemImage.fromJson(Map<String, dynamic> json) {
    return ItemImage(
      id: json['id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Details {
  final String? plateNumber;
  final String? plateCode;
  final int? plateStyleId;
  final String? plateStyle;
  final int? categoryId;
  final String? category;
  final String? postedOn;

  Details({
    required this.plateNumber,
    required this.plateCode,
    required this.plateStyleId,
    required this.plateStyle,
    required this.categoryId,
    required this.category,
    required this.postedOn,
  }) {
    detailsItem = [plateNumber, plateCode, plateStyle, postedOn];
  }

  List<String?> detailsItem = [];

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      plateNumber: json['plate_number'],
      plateCode: json['plate_code'],
      plateStyleId: json['plate_style_id'],
      plateStyle: json['plate_style'],
      categoryId: json['category_id'],
      category: json['category'],
      postedOn: json['posted_on'],
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

class User {
  final int? id;
  final String? image;
  final String? name;
  final bool? userVerified;

  User({
    required this.id,
    required this.image,
    required this.name,
    required this.userVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      userVerified: json['user_verified'],
    );
  }
}

class RelatedItem {
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
  final bool? isLiked;
  final bool? isSolid;
  final String? shareLink;
  final String? whatsapp;
  final String? mobile;
  final int? chatRoomId;
  final Location? location;

  get amountString => amount?.replaceAll(".00", "");

  RelatedItem({
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

  factory RelatedItem.fromJson(Map<String, dynamic> json) {
    return RelatedItem(
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
