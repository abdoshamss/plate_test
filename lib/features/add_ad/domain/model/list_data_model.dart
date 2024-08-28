class ListData {
  bool? status;
  String? message;
  CategoriesData? data;

  ListData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CategoriesData.fromJson(json['data']) : null;
  }
}

class CategoriesData {
  List<Categories>? categories;
  List<PlateStyles>? plateStyles;

  CategoriesData({this.categories, this.plateStyles});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['plate_styles'] != null) {
      plateStyles = <PlateStyles>[];
      json['plate_styles'].forEach((v) {
        plateStyles!.add(PlateStyles.fromJson(v));
      });
    }
  }
}

class Data {
  List<Categories>? categories;
  List<PlateStyles>? plateStyles;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['plate_styles'] != null) {
      plateStyles = <PlateStyles>[];
      json['plate_styles'].forEach((v) {
        plateStyles!.add(PlateStyles.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? name;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class PlateStyles {
  int? id;
  String? name;

  PlateStyles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
