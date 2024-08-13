
class AuthRequest {
  String? name;
  String? email;
  String? phone;
  String? code;
  String? type;
  String? createdAt;
  String? token;
  String? password;
  String? agree;
  String? fcm_token;
  String? password_confirmation;
  int? areaID;
  AuthRequest({
    this.name,
    this.email,
    this.phone,
    this.type,
    this.createdAt,
    this.fcm_token,
    this.token,
    this.password,
    this.agree,
    this.password_confirmation,
    this.areaID,
  });

  Map<String, dynamic> register() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': "$code$phone",
      'type': type,
      'password': password,
      'agree': agree,
      'password_confirmation': password_confirmation,
      'fcm_token': fcm_token,
      "area_id":areaID
    };
  }

  Map<String, dynamic> login() {
    return <String, dynamic>{
      'fcm_token': fcm_token,
      'email': email,
      'password': password,
    };
  }
  }