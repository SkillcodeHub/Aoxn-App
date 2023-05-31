class ReportsListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  ReportsListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  ReportsListModel.fromJson(Map<String, dynamic> json) {
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
  String? reportType;
  int? visitId;
  String? visitDate;
  String? visitTime;
  int? visitNumber;
  int? patientId;
  String? providerName;
  String? treatment;
  String? patientName;
  String? entryMode;
  bool? isPublished;

  Data(
      {this.id,
      this.reportType,
      this.visitId,
      this.visitDate,
      this.visitTime,
      this.visitNumber,
      this.patientId,
      this.providerName,
      this.treatment,
      this.patientName,
      this.entryMode,
      this.isPublished});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    reportType = json['reportType'];
    visitId = json['visitId'];
    visitDate = json['visitDate'];
    visitTime = json['visitTime'];
    visitNumber = json['visitNumber'];
    patientId = json['patientId'];
    providerName = json['providerName'];
    treatment = json['treatment'];
    patientName = json['patientName'];
    entryMode = json['entryMode'];
    isPublished = json['isPublished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['reportType'] = this.reportType;
    data['visitId'] = this.visitId;
    data['visitDate'] = this.visitDate;
    data['visitTime'] = this.visitTime;
    data['visitNumber'] = this.visitNumber;
    data['patientId'] = this.patientId;
    data['providerName'] = this.providerName;
    data['treatment'] = this.treatment;
    data['patientName'] = this.patientName;
    data['entryMode'] = this.entryMode;
    data['isPublished'] = this.isPublished;
    return data;
  }
}
