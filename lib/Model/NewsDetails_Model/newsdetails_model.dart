class NewsDetailsListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  Data? data;

  NewsDetailsListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  NewsDetailsListModel.fromJson(Map<String, dynamic> json) {
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
  int? newsId;
  String? title;
  String? description;
  String? createdDate;
  String? startDate;
  String? endDate;
  String? displayDate;
  bool? isAlwaysDisplay;
  int? createdBy;
  int? updatedBy;
  int? customerId;

  Data(
      {this.id,
      this.newsId,
      this.title,
      this.description,
      this.createdDate,
      this.startDate,
      this.endDate,
      this.displayDate,
      this.isAlwaysDisplay,
      this.createdBy,
      this.updatedBy,
      this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    newsId = json['newsId'];
    title = json['title'];
    description = json['description'];
    createdDate = json['createdDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    displayDate = json['displayDate'];
    isAlwaysDisplay = json['isAlwaysDisplay'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['newsId'] = this.newsId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['displayDate'] = this.displayDate;
    data['isAlwaysDisplay'] = this.isAlwaysDisplay;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['customerId'] = this.customerId;
    return data;
  }
}
