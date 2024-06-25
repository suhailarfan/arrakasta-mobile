class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? providerId;
  int? provinceId;
  int? cityId;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? role;
  String? phone;
  String? address;
  String? avatar;
  String? credential;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.providerId,
      this.provinceId,
      this.cityId,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.role,
      this.phone,
      this.address,
      this.avatar,
      this.credential,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    phone = json['phone'];
    address = json['address'];
    avatar = json['avatar'];
    credential = json['credential'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['credential'] = this.credential;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
