class CustomerTokenModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  Data? data;

  CustomerTokenModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  CustomerTokenModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    status = json['status'];
    messageCode = json['messageCode'];
    displayMessage = json['displayMessage'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['status'] = this.status;
    data['messageCode'] = this.messageCode;
    data['displayMessage'] = this.displayMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? systemDownMessage;
  String? token;

  Data({this.id, this.systemDownMessage, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    systemDownMessage = json['systemDownMessage'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['systemDownMessage'] = this.systemDownMessage;
    data['token'] = this.token;
    return data;
  }
}
