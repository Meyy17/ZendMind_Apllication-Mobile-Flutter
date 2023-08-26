class MentorProfileModel {
  int? status;
  String? message;
  Data? data;

  MentorProfileModel({this.status, this.message, this.data});

  MentorProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? imgProfileURL;
  String? name;
  String? verifyToken;
  String? role;
  String? isVerify;
  Null? gender;
  String? createdAt;
  String? updatedAt;
  MentorProfile? mentorProfile;

  Data(
      {this.id,
      this.email,
      this.imgProfileURL,
      this.name,
      this.verifyToken,
      this.role,
      this.isVerify,
      this.gender,
      this.createdAt,
      this.updatedAt,
      this.mentorProfile});

  Data.fromJson(Map<String, dynamic> json) {
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
    mentorProfile = json['MentorProfile'] != null
        ? new MentorProfile.fromJson(json['MentorProfile'])
        : null;
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
    if (this.mentorProfile != null) {
      data['MentorProfile'] = this.mentorProfile!.toJson();
    }
    return data;
  }
}

class MentorProfile {
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
  List<ScheduleMentor>? scheduleMentor;

  MentorProfile(
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
      this.scheduleMentor});

  MentorProfile.fromJson(Map<String, dynamic> json) {
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
    if (json['ScheduleMentor'] != null) {
      scheduleMentor = <ScheduleMentor>[];
      json['ScheduleMentor'].forEach((v) {
        scheduleMentor!.add(new ScheduleMentor.fromJson(v));
      });
    }
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
    if (this.scheduleMentor != null) {
      data['ScheduleMentor'] =
          this.scheduleMentor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduleMentor {
  int? id;
  int? idMentor;
  String? date;
  String? createdAt;
  String? updatedAt;

  ScheduleMentor(
      {this.id, this.idMentor, this.date, this.createdAt, this.updatedAt});

  ScheduleMentor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMentor = json['id_mentor'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_mentor'] = this.idMentor;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
