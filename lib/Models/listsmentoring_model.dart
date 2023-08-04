class ListScheduleMentoring {
  int? status;
  String? message;
  List<Data>? data;

  ListScheduleMentoring({this.status, this.message, this.data});

  ListScheduleMentoring.fromJson(Map<String, dynamic> json) {
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
  int? idMentor;
  int? fee;
  String? dateMentoring;
  String? timeMentoring;
  String? notes;
  String? urlTrx;
  String? idTRx;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Mentor? mentor;

  Data(
      {this.id,
      this.idUser,
      this.idMentor,
      this.fee,
      this.dateMentoring,
      this.timeMentoring,
      this.notes,
      this.urlTrx,
      this.idTRx,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.mentor});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idMentor = json['id_mentor'];
    fee = json['fee'];
    dateMentoring = json['date_mentoring'];
    timeMentoring = json['time_mentoring'];
    notes = json['notes'];
    urlTrx = json['urlTrx'];
    idTRx = json['idTRx'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    mentor =
        json['Mentor'] != null ? new Mentor.fromJson(json['Mentor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_mentor'] = this.idMentor;
    data['fee'] = this.fee;
    data['date_mentoring'] = this.dateMentoring;
    data['time_mentoring'] = this.timeMentoring;
    data['notes'] = this.notes;
    data['urlTrx'] = this.urlTrx;
    data['idTRx'] = this.idTRx;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    if (this.mentor != null) {
      data['Mentor'] = this.mentor!.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

class Mentor {
  int? id;
  int? idUser;
  String? role;
  String? username;
  int? fee;
  int? incomeNow;
  String? specialist;
  String? about;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  Mentor(
      {this.id,
      this.idUser,
      this.role,
      this.username,
      this.fee,
      this.incomeNow,
      this.specialist,
      this.about,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  Mentor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    role = json['role'];
    username = json['username'];
    fee = json['fee'];
    incomeNow = json['incomeNow'];
    specialist = json['specialist'];
    about = json['about'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUser'] = this.idUser;
    data['role'] = this.role;
    data['username'] = this.username;
    data['fee'] = this.fee;
    data['incomeNow'] = this.incomeNow;
    data['specialist'] = this.specialist;
    data['about'] = this.about;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}
