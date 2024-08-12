
class UserModel {
  String? name;
  String? email;
  String? type;
  String? createdAt;
  String? token;
  String? password;
    String? phone;
  String? fcm_token;

  UserModel(
      {this.name,
      this.email,
      this.type,
      this.createdAt,
      this.token,
      this.phone,
      this.fcm_token,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    createdAt = json['created_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['token'] = token;
    return data;
  }
}