class PaymentHistoryModel {
  String? id;
  bool? status;
  Null? messageCode;
  Null? displayMessage;
  List<Data>? data;

  PaymentHistoryModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
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
  int? patientId;
  int? caseNo;
  String? name;
  String? payProvider;
  String? payHead;
  double? amount;
  String? createdDateUtc;
  String? createdDate;
  int? payStatus;
  String? payStatusText;
  String? payTransID;
  Null? timeHelper;

  Data(
      {this.id,
      this.patientId,
      this.caseNo,
      this.name,
      this.payProvider,
      this.payHead,
      this.amount,
      this.createdDateUtc,
      this.createdDate,
      this.payStatus,
      this.payStatusText,
      this.payTransID,
      this.timeHelper});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    patientId = json['patientId'];
    caseNo = json['caseNo'];
    name = json['name'];
    payProvider = json['payProvider'];
    payHead = json['payHead'];
    amount = json['amount'];
    createdDateUtc = json['createdDateUtc'];
    createdDate = json['createdDate'];
    payStatus = json['payStatus'];
    payStatusText = json['payStatusText'];
    payTransID = json['payTransID'];
    timeHelper = json['timeHelper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['patientId'] = this.patientId;
    data['caseNo'] = this.caseNo;
    data['name'] = this.name;
    data['payProvider'] = this.payProvider;
    data['payHead'] = this.payHead;
    data['amount'] = this.amount;
    data['createdDateUtc'] = this.createdDateUtc;
    data['createdDate'] = this.createdDate;
    data['payStatus'] = this.payStatus;
    data['payStatusText'] = this.payStatusText;
    data['payTransID'] = this.payTransID;
    data['timeHelper'] = this.timeHelper;
    return data;
  }
}
