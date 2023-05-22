class LoginModel {
  int? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? isVerify;
  String? role;
  int? id;
  String? token;

  User({this.email, this.isVerify, this.role, this.id, this.token});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    isVerify = json['isVerify'];
    role = json['role'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['isVerify'] = isVerify;
    data['role'] = role;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}

class RegisterModel {
  int? status;
  String? message;
  DataRegister? data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataRegister.fromJson(json['data']) : null;
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

class DataRegister {
  String? email;
  String? isVerify;
  String? role;
  int? id;

  DataRegister({this.email, this.isVerify, this.role, this.id});

  DataRegister.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    isVerify = json['isVerify'];
    role = json['role'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['isVerify'] = isVerify;
    data['role'] = role;
    data['id'] = id;
    return data;
  }
}
