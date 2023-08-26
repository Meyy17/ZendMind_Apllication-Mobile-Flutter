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
  int? earningAll;
  int? earningRec;
  List<EarningRecData>? earningRecData;
  int? earningNow;
  List<Rekening>? rekening;

  Data(
      {this.earningAll,
      this.earningRec,
      this.earningRecData,
      this.earningNow,
      this.rekening});

  Data.fromJson(Map<String, dynamic> json) {
    earningAll = json['earningAll'];
    earningRec = json['earningRec'];
    if (json['earningRecData'] != null) {
      earningRecData = <EarningRecData>[];
      json['earningRecData'].forEach((v) {
        earningRecData!.add(new EarningRecData.fromJson(v));
      });
    }
    earningNow = json['earningNow'];
    if (json['rekening'] != null) {
      rekening = <Rekening>[];
      json['rekening'].forEach((v) {
        rekening!.add(new Rekening.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['earningAll'] = this.earningAll;
    data['earningRec'] = this.earningRec;
    if (this.earningRecData != null) {
      data['earningRecData'] =
          this.earningRecData!.map((v) => v.toJson()).toList();
    }
    data['earningNow'] = this.earningNow;
    if (this.rekening != null) {
      data['rekening'] = this.rekening!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EarningRecData {
  int? id;
  int? idUser;
  String? norek;
  String? type;
  int? total;
  String? createdAt;
  String? updatedAt;

  EarningRecData(
      {this.id,
      this.idUser,
      this.norek,
      this.type,
      this.total,
      this.createdAt,
      this.updatedAt});

  EarningRecData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    norek = json['norek'];
    type = json['type'];
    total = json['total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['norek'] = this.norek;
    data['type'] = this.type;
    data['total'] = this.total;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Rekening {
  int? id;
  int? idUser;
  String? norek;
  String? type;
  String? createdAt;
  String? updatedAt;

  Rekening(
      {this.id,
      this.idUser,
      this.norek,
      this.type,
      this.createdAt,
      this.updatedAt});

  Rekening.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    norek = json['norek'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['norek'] = this.norek;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
