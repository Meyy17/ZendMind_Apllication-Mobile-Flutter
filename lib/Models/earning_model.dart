class GetEarningModel {
  int? status;
  String? message;
  Data? data;

  GetEarningModel({this.status, this.message, this.data});

  GetEarningModel.fromJson(Map<String, dynamic> json) {
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
  List<EarningData>? earningData;
  int? earningCount;

  Data({this.earningData, this.earningCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['earningData'] != null) {
      earningData = <EarningData>[];
      json['earningData'].forEach((v) {
        earningData!.add(new EarningData.fromJson(v));
      });
    }
    earningCount = json['earningCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.earningData != null) {
      data['earningData'] = this.earningData!.map((v) => v.toJson()).toList();
    }
    data['earningCount'] = this.earningCount;
    return data;
  }
}

class EarningData {
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

  EarningData(
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
      this.updatedAt});

  EarningData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
