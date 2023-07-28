class MoodTrackerModel {
  int? status;
  String? message;
  Data? data;

  MoodTrackerModel({this.status, this.message, this.data});

  MoodTrackerModel.fromJson(Map<String, dynamic> json) {
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
  int? happyCount;
  int? normalCount;
  int? sadCount;
  int? angryCount;
  List<MoodData>? moodData;

  Data(
      {this.happyCount,
      this.normalCount,
      this.sadCount,
      this.angryCount,
      this.moodData});

  Data.fromJson(Map<String, dynamic> json) {
    happyCount = json['happyCount'];
    normalCount = json['normalCount'];
    sadCount = json['sadCount'];
    angryCount = json['angryCount'];
    if (json['moodData'] != null) {
      moodData = <MoodData>[];
      json['moodData'].forEach((v) {
        moodData!.add(new MoodData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['happyCount'] = this.happyCount;
    data['normalCount'] = this.normalCount;
    data['sadCount'] = this.sadCount;
    data['angryCount'] = this.angryCount;
    if (this.moodData != null) {
      data['moodData'] = this.moodData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MoodData {
  int? id;
  String? mood;
  int? idUser;
  String? monthYear;
  String? createdAt;
  String? updatedAt;

  MoodData(
      {this.id,
      this.mood,
      this.idUser,
      this.monthYear,
      this.createdAt,
      this.updatedAt});

  MoodData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mood = json['mood'];
    idUser = json['idUser'];
    monthYear = json['monthYear'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mood'] = this.mood;
    data['idUser'] = this.idUser;
    data['monthYear'] = this.monthYear;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
