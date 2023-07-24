class CustomerPayHeadListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  CustomerPayHeadListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  CustomerPayHeadListModel.fromJson(Map<String, dynamic> json) {
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
  String? payHead;
  dynamic actionCode;
  double? defaultAmount;

  Data({this.id, this.payHead, this.actionCode, this.defaultAmount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    payHead = json['payHead'];
    actionCode = json['actionCode'];
    defaultAmount = json['defaultAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['payHead'] = this.payHead;
    data['actionCode'] = this.actionCode;
    data['defaultAmount'] = this.defaultAmount;
    return data;
  }
}
