class ProfileModel {
  final ProfileUser? user;

  ProfileModel({
    required this.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: json['user'] != null ? ProfileUser.fromJson(json['user']) : null,
    );
  }
}

class ProfileUser {
  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? image;
  final bool? notify;
  final String? lang;
  final bool? banned;
  final bool? active;
  final bool? isVerified;
  final bool? mobileVerified;
  final bool? emailVerified;
  final int? areaId;
  final String? area;
  final bool? isSocial;
  final String? coaching;

  ProfileUser({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.image,
    required this.notify,
    required this.lang,
    required this.banned,
    required this.active,
    required this.isVerified,
    required this.mobileVerified,
    required this.emailVerified,
    required this.areaId,
    required this.area,
    required this.isSocial,
    required this.coaching,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      image: json['image'],
      notify: json['notify'],
      lang: json['lang'],
      banned: json['banned'],
      active: json['active'],
      isVerified: json['is_verified'],
      mobileVerified: json['mobile_verified'],
      emailVerified: json['email_verified'],
      areaId: json['area_id'],
      area: json['area'],
      isSocial: json['is_social'],
      coaching: json['coaching'],
    );
  }
}
