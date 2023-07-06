class ValidateAppUserModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  Null? data;

  ValidateAppUserModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  ValidateAppUserModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    status = json['status'];
    messageCode = json['messageCode'];
    displayMessage = json['displayMessage'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['status'] = this.status;
    data['messageCode'] = this.messageCode;
    data['displayMessage'] = this.displayMessage;
    data['data'] = this.data;
    return data;
  }
}
