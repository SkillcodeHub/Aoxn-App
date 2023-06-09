class EventListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  EventListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  EventListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic appointmentId;
  dynamic name;
  dynamic caseNo;
  dynamic gender;
  dynamic email;
  dynamic mobile;
  dynamic apptDate;
  dynamic apptDateLocal;
  dynamic dob;
  dynamic cardNo;
  dynamic doctorId;
  dynamic doctorName;
  dynamic customerId;
  dynamic timeSlot;
  dynamic isConfirmed;
  dynamic isSynched;
  dynamic customerDoctorId;
  dynamic amount;
  dynamic status;
  dynamic statusText;
  dynamic inTime;
  dynamic visitedTime;
  dynamic patType;
  dynamic patientId;
  dynamic isDelete;
  dynamic apptSource;
  dynamic tokenNo;
  dynamic tokenPrefix;
  dynamic subscriptionUpto;
  dynamic visitId;
  dynamic videoCallId;
  dynamic videoCallRoomId;
  dynamic videoCallStatus;
  dynamic videoCallLink;

  Data(
      {this.id,
      this.appointmentId,
      this.name,
      this.caseNo,
      this.gender,
      this.email,
      this.mobile,
      this.apptDate,
      this.apptDateLocal,
      this.dob,
      this.cardNo,
      this.doctorId,
      this.doctorName,
      this.customerId,
      this.timeSlot,
      this.isConfirmed,
      this.isSynched,
      this.customerDoctorId,
      this.amount,
      this.status,
      this.statusText,
      this.inTime,
      this.visitedTime,
      this.patType,
      this.patientId,
      this.isDelete,
      this.apptSource,
      this.tokenNo,
      this.tokenPrefix,
      this.subscriptionUpto,
      this.visitId,
      this.videoCallId,
      this.videoCallRoomId,
      this.videoCallStatus,
      this.videoCallLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    appointmentId = json['appointmentId'];
    name = json['name'];
    caseNo = json['caseNo'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    apptDate = json['apptDate'];
    apptDateLocal = json['apptDateLocal'];
    dob = json['dob'];
    cardNo = json['cardNo'];
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    customerId = json['customerId'];
    timeSlot = json['timeSlot'];
    isConfirmed = json['isConfirmed'];
    isSynched = json['isSynched'];
    customerDoctorId = json['customerDoctorId'];
    amount = json['amount'];
    status = json['status'];
    statusText = json['statusText'];
    inTime = json['inTime'];
    visitedTime = json['visitedTime'];
    patType = json['patType'];
    patientId = json['patientId'];
    isDelete = json['isDelete'];
    apptSource = json['apptSource'];
    tokenNo = json['tokenNo'];
    tokenPrefix = json['tokenPrefix'];
    subscriptionUpto = json['subscriptionUpto'];
    visitId = json['visitId'];
    videoCallId = json['videoCallId'];
    videoCallRoomId = json['videoCallRoomId'];
    videoCallStatus = json['videoCallStatus'];
    videoCallLink = json['videoCallLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['appointmentId'] = this.appointmentId;
    data['name'] = this.name;
    data['caseNo'] = this.caseNo;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['apptDate'] = this.apptDate;
    data['apptDateLocal'] = this.apptDateLocal;
    data['dob'] = this.dob;
    data['cardNo'] = this.cardNo;
    data['doctorId'] = this.doctorId;
    data['doctorName'] = this.doctorName;
    data['customerId'] = this.customerId;
    data['timeSlot'] = this.timeSlot;
    data['isConfirmed'] = this.isConfirmed;
    data['isSynched'] = this.isSynched;
    data['customerDoctorId'] = this.customerDoctorId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['statusText'] = this.statusText;
    data['inTime'] = this.inTime;
    data['visitedTime'] = this.visitedTime;
    data['patType'] = this.patType;
    data['patientId'] = this.patientId;
    data['isDelete'] = this.isDelete;
    data['apptSource'] = this.apptSource;
    data['tokenNo'] = this.tokenNo;
    data['tokenPrefix'] = this.tokenPrefix;
    data['subscriptionUpto'] = this.subscriptionUpto;
    data['visitId'] = this.visitId;
    data['videoCallId'] = this.videoCallId;
    data['videoCallRoomId'] = this.videoCallRoomId;
    data['videoCallStatus'] = this.videoCallStatus;
    data['videoCallLink'] = this.videoCallLink;
    return data;
  }
}
