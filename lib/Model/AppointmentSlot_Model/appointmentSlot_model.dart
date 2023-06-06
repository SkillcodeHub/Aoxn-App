class AppointmentSlotListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  AppointmentSlotListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  AppointmentSlotListModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    status = json['status'];
    messageCode = json['messageCode'];
    displayMessage = json['displayMessage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['status'] = this.status;
    data['messageCode'] = this.messageCode;
    data['displayMessage'] = this.displayMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? fromTimeSlotUTC;
  String? toTimeSlotUTC;
  String? fromTimeSlotLocal;
  String? toTimeSlotLocal;
  String? displayTime;
  int? count;
  int? capacity;
  bool? isBlocked;
  int? timingId;
  double? minuteInterval;
  String? message;

  Data(
      {this.id,
      this.fromTimeSlotUTC,
      this.toTimeSlotUTC,
      this.fromTimeSlotLocal,
      this.toTimeSlotLocal,
      this.displayTime,
      this.count,
      this.capacity,
      this.isBlocked,
      this.timingId,
      this.minuteInterval,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    fromTimeSlotUTC = json['fromTimeSlotUTC'];
    toTimeSlotUTC = json['toTimeSlotUTC'];
    fromTimeSlotLocal = json['fromTimeSlotLocal'];
    toTimeSlotLocal = json['toTimeSlotLocal'];
    displayTime = json['displayTime'];
    count = json['count'];
    capacity = json['capacity'];
    isBlocked = json['isBlocked'];
    timingId = json['timingId'];
    minuteInterval = json['minuteInterval'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['fromTimeSlotUTC'] = this.fromTimeSlotUTC;
    data['toTimeSlotUTC'] = this.toTimeSlotUTC;
    data['fromTimeSlotLocal'] = this.fromTimeSlotLocal;
    data['toTimeSlotLocal'] = this.toTimeSlotLocal;
    data['displayTime'] = this.displayTime;
    data['count'] = this.count;
    data['capacity'] = this.capacity;
    data['isBlocked'] = this.isBlocked;
    data['timingId'] = this.timingId;
    data['minuteInterval'] = this.minuteInterval;
    data['message'] = this.message;
    return data;
  }
}
