class SelectPatientByIdModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  SelectPatientByIdModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  SelectPatientByIdModel.fromJson(Map<String, dynamic> json) {
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
  int? caseNo;
  String? patientName;
  String? patientMobile;
  String? patientEmail;
  String? patientGender;
  String? patientDob;
  int? patientId;
  String? ageText;

  Data(
      {this.id,
      this.caseNo,
      this.patientName,
      this.patientMobile,
      this.patientEmail,
      this.patientGender,
      this.patientDob,
      this.patientId,
      this.ageText});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    caseNo = json['case_no'];
    patientName = json['patient_name'];
    patientMobile = json['patient_mobile'];
    patientEmail = json['patient_email'];
    patientGender = json['patient_gender'];
    patientDob = json['patient_dob'];
    patientId = json['patientId'];
    ageText = json['age_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['case_no'] = this.caseNo;
    data['patient_name'] = this.patientName;
    data['patient_mobile'] = this.patientMobile;
    data['patient_email'] = this.patientEmail;
    data['patient_gender'] = this.patientGender;
    data['patient_dob'] = this.patientDob;
    data['patientId'] = this.patientId;
    data['age_text'] = this.ageText;
    return data;
  }
}
