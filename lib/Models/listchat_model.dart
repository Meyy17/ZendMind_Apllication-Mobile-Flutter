class ListChatModel {
  int? status;
  String? message;
  List<Data>? data;

  ListChatModel({this.status, this.message, this.data});

  ListChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? idUser;
  int? idSecondUser;
  int? idLastChat;
  String? createdAt;
  String? updatedAt;
  SecondUser? secondUser;
  Message? message;

  Data(
      {this.id,
      this.idUser,
      this.idSecondUser,
      this.idLastChat,
      this.createdAt,
      this.updatedAt,
      this.secondUser,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idSecondUser = json['id_SecondUser'];
    idLastChat = json['id_lastChat'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    secondUser = json['SecondUser'] != null
        ? new SecondUser.fromJson(json['SecondUser'])
        : null;
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_SecondUser'] = this.idSecondUser;
    data['id_lastChat'] = this.idLastChat;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.secondUser != null) {
      data['SecondUser'] = this.secondUser!.toJson();
    }
    if (this.message != null) {
      data['Message'] = this.message!.toJson();
    }
    return data;
  }
}

class SecondUser {
  int? id;
  String? email;
  String? imgProfileURL;
  String? name;
  String? verifyToken;
  String? role;
  String? isVerify;
  String? gender;
  String? createdAt;
  String? updatedAt;

  SecondUser(
      {this.id,
      this.email,
      this.imgProfileURL,
      this.name,
      this.verifyToken,
      this.role,
      this.isVerify,
      this.gender,
      this.createdAt,
      this.updatedAt});

  SecondUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    imgProfileURL = json['imgProfileURL'];
    name = json['name'];
    verifyToken = json['verifyToken'];
    role = json['role'];
    isVerify = json['isVerify'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['imgProfileURL'] = this.imgProfileURL;
    data['name'] = this.name;
    data['verifyToken'] = this.verifyToken;
    data['role'] = this.role;
    data['isVerify'] = this.isVerify;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Message {
  int? id;
  int? userId;
  String? roomID;
  String? message;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.userId,
      this.roomID,
      this.message,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    roomID = json['roomID'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['roomID'] = this.roomID;
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
