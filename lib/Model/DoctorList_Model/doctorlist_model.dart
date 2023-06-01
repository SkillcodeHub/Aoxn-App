class DoctorListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  DoctorListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  DoctorListModel.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  int? doctorId;
  String? doctorName;
  String? specialty;
  String? degree;
  String? regNo;
  int? customerDoctorId;
  String? email;
  String? bookAppointmentLink;
  bool? isActive;
  String? department;
  bool? notifyApptBooking;
  bool? includeBlocktimeMsg;

  Data(
      {this.id,
      this.customerId,
      this.doctorId,
      this.doctorName,
      this.specialty,
      this.degree,
      this.regNo,
      this.customerDoctorId,
      this.email,
      this.bookAppointmentLink,
      this.isActive,
      this.department,
      this.notifyApptBooking,
      this.includeBlocktimeMsg});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    customerId = json['customerId'];
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    specialty = json['specialty'];
    degree = json['degree'];
    regNo = json['regNo'];
    customerDoctorId = json['customerDoctorId'];
    email = json['email'];
    bookAppointmentLink = json['bookAppointmentLink'];
    isActive = json['isActive'];
    department = json['department'];
    notifyApptBooking = json['notifyApptBooking'];
    includeBlocktimeMsg = json['includeBlocktimeMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['customerId'] = this.customerId;
    data['doctorId'] = this.doctorId;
    data['doctorName'] = this.doctorName;
    data['specialty'] = this.specialty;
    data['degree'] = this.degree;
    data['regNo'] = this.regNo;
    data['customerDoctorId'] = this.customerDoctorId;
    data['email'] = this.email;
    data['bookAppointmentLink'] = this.bookAppointmentLink;
    data['isActive'] = this.isActive;
    data['department'] = this.department;
    data['notifyApptBooking'] = this.notifyApptBooking;
    data['includeBlocktimeMsg'] = this.includeBlocktimeMsg;
    return data;
  }
}
