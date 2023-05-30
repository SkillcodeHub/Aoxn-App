class NewsListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  NewsListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  NewsListModel.fromJson(Map<String, dynamic> json) {
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
  String? category;
  int? newsId;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? displayDate;
  bool? isAlwaysDisplay;
  int? customerId;

  Data(
      {this.id,
      this.category,
      this.newsId,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.displayDate,
      this.isAlwaysDisplay,
      this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    category = json['category'];
    newsId = json['newsId'];
    title = json['title'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    displayDate = json['displayDate'];
    isAlwaysDisplay = json['isAlwaysDisplay'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['category'] = this.category;
    data['newsId'] = this.newsId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['displayDate'] = this.displayDate;
    data['isAlwaysDisplay'] = this.isAlwaysDisplay;
    data['customerId'] = this.customerId;
    return data;
  }
}
