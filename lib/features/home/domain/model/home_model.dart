class HomeModel {
  final List<Slider>? sliders;
  final List<FeaturedItem>? featuredItems;
  final List<Budget>? budgets;
  final List<Type>? types;
  final List<NewItem>? newItems;

  HomeModel({
    required this.sliders,
    required this.featuredItems,
    required this.budgets,
    required this.types,
    required this.newItems,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      sliders: json['sliders'] != null
          ? List<Slider>.from(
              json['sliders'].map((slider) => Slider.fromJson(slider)))
          : null,
      featuredItems: json['featured_items'] != null
          ? List<FeaturedItem>.from(
              json['featured_items'].map((item) => FeaturedItem.fromJson(item)))
          : null,
      budgets: json['budgets'] != null
          ? List<Budget>.from(
              json['budgets'].map((budget) => Budget.fromJson(budget)))
          : null,
      types: json['types'] != null
          ? List<Type>.from(json['types'].map((type) => Type.fromJson(type)))
          : null,
      newItems: json['new_items'] != null
          ? List<NewItem>.from(
              json['new_items'].map((item) => NewItem.fromJson(item)))
          : null,
    );
  }
}

class Slider {
  final int? id;
  final String? image;
  final String? linkType;
  final String? link;

  Slider({
    required this.id,
    required this.image,
    required this.linkType,
    required this.link,
  });

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      id: json['id'],
      image: json['image'],
      linkType: json['link_type'],
      link: json['link'],
    );
  }
}

class FeaturedItem {
  final int? id;
  final String? name;
  final String? image;
  final String? price;
  final String? discount;
  final String? rating;

  FeaturedItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.rating,
  });

  factory FeaturedItem.fromJson(Map<String, dynamic> json) {
    return FeaturedItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      discount: json['discount'],
      rating: json['rating'],
    );
  }
}

class Budget {
  final int? id;
  final String? name;

  Budget({
    required this.id,
    required this.name,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Type {
  final String? image;
  final String? name;
  final String? type;

  Type({
    required this.image,
    required this.name,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      image: json['image'],
      name: json['name'],
      type: json['type'],
    );
  }
}

class NewItem {
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

  NewItem({
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

  factory NewItem.fromJson(Map<String, dynamic> json) {
    return NewItem(
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
  final String? name;
  final String? city;
  final String? latitude;
  final String? longitude;

  Location({
    required this.name,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['text'],
      city: json['city'],
      latitude: json['lat'],
      longitude: json['lng'],
    );
  }
}
