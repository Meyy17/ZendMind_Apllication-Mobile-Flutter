class ListScheduleMentor {
  int? status;
  String? message;
  List<Data>? data;

  ListScheduleMentor({this.status, this.message, this.data});

  ListScheduleMentor.fromJson(Map<String, dynamic> json) {
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
  int? idMentor;
  String? date;
  String? createdAt;
  String? updatedAt;
  List<TimeSchedule>? timeSchedule;

  Data(
      {this.id,
      this.idMentor,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.timeSchedule});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMentor = json['id_mentor'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['TimeSchedule'] != null) {
      timeSchedule = <TimeSchedule>[];
      json['TimeSchedule'].forEach((v) {
        timeSchedule!.add(new TimeSchedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_mentor'] = this.idMentor;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.timeSchedule != null) {
      data['TimeSchedule'] = this.timeSchedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSchedule {
  int? id;
  int? idSchedule;
  String? time;
  String? createdAt;
  String? updatedAt;

  TimeSchedule(
      {this.id, this.idSchedule, this.time, this.createdAt, this.updatedAt});

  TimeSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSchedule = json['id_schedule'];
    time = json['time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_schedule'] = this.idSchedule;
    data['time'] = this.time;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
