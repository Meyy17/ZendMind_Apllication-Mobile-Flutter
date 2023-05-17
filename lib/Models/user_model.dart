class UserModel {
  int? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? imgProfileURL;
  int? id;
  String? email;
  String? name;
  String? verifyToken;
  String? role;
  String? isVerify;
  String? gender;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.imgProfileURL,
      this.id,
      this.email,
      this.name,
      this.verifyToken,
      this.role,
      this.isVerify,
      this.gender,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    imgProfileURL = json['imgProfileURL'];
    id = json['id'];
    email = json['email'];
    name = json['name'];
    verifyToken = json['verifyToken'];
    role = json['role'];
    isVerify = json['isVerify'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgProfileURL'] = imgProfileURL;
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['verifyToken'] = verifyToken;
    data['role'] = role;
    data['isVerify'] = isVerify;
    data['gender'] = gender;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
