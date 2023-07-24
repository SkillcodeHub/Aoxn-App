class DoctorDetailsListModel {
  String? id;
  bool? status;
  String? messageCode;
  String? displayMessage;
  List<Data>? data;

  DoctorDetailsListModel(
      {this.id, this.status, this.messageCode, this.displayMessage, this.data});

  DoctorDetailsListModel.fromJson(Map<String, dynamic> json) {
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
  String? customerName;
  String? customerAddress;
  dynamic customerContact;
  String? email;
  String? website;
  String? customerLogo;
  String? logoFileName;
  String? logoPath;
  String? logoImageURL;
  dynamic advanceBookingFrom;
  dynamic advanceBookingTo;
  dynamic realtimeSlotOpenBeforeMinute;
  dynamic realtimeSlotCloseBeforeMinute;
  dynamic packageId;
  dynamic maxLicenseDoctor;
  String? applySlotOpenFlag;
  String? applySlotCloseFlag;
  String? subscriptionUpto;
  bool? isSubscriptionExpired;
  String? createdUser;
  bool? hideCustDetail;
  dynamic dynamicAppLink;
  bool? displayUpComingVaccine;
  bool? displayDueVaccine;
  bool? paymentGatewayEnabled;
  String? termsLink;
  dynamic paymentDailyTransactionCount;
  dynamic paymentAmountLimitPerTrans;
  bool? disableRxDownload;
  String? appCode;
  String? whatsapplink;
  String? timeZoneId;
  dynamic thirdpartyPaymentAPI;
  bool? isAdvanceBookingRequired;

  Data(
      {this.id,
      this.customerId,
      this.customerName,
      this.customerAddress,
      this.customerContact,
      this.email,
      this.website,
      this.customerLogo,
      this.logoFileName,
      this.logoPath,
      this.logoImageURL,
      this.advanceBookingFrom,
      this.advanceBookingTo,
      this.realtimeSlotOpenBeforeMinute,
      this.realtimeSlotCloseBeforeMinute,
      this.packageId,
      this.maxLicenseDoctor,
      this.applySlotOpenFlag,
      this.applySlotCloseFlag,
      this.subscriptionUpto,
      this.isSubscriptionExpired,
      this.createdUser,
      this.hideCustDetail,
      this.dynamicAppLink,
      this.displayUpComingVaccine,
      this.displayDueVaccine,
      this.paymentGatewayEnabled,
      this.termsLink,
      this.paymentDailyTransactionCount,
      this.paymentAmountLimitPerTrans,
      this.disableRxDownload,
      this.appCode,
      this.whatsapplink,
      this.timeZoneId,
      this.thirdpartyPaymentAPI,
      this.isAdvanceBookingRequired});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    customerAddress = json['customerAddress'];
    customerContact = json['customerContact'];
    email = json['email'];
    website = json['website'];
    customerLogo = json['customerLogo'];
    logoFileName = json['logoFileName'];
    logoPath = json['logoPath'];
    logoImageURL = json['logoImageURL'];
    advanceBookingFrom = json['advanceBookingFrom'];
    advanceBookingTo = json['advanceBookingTo'];
    realtimeSlotOpenBeforeMinute = json['realtimeSlotOpenBeforeMinute'];
    realtimeSlotCloseBeforeMinute = json['realtimeSlotCloseBeforeMinute'];
    packageId = json['packageId'];
    maxLicenseDoctor = json['maxLicenseDoctor'];
    applySlotOpenFlag = json['applySlotOpenFlag'];
    applySlotCloseFlag = json['applySlotCloseFlag'];
    subscriptionUpto = json['subscriptionUpto'];
    isSubscriptionExpired = json['isSubscriptionExpired'];
    createdUser = json['createdUser'];
    hideCustDetail = json['hideCustDetail'];
    dynamicAppLink = json['dynamicAppLink'];
    displayUpComingVaccine = json['displayUpComingVaccine'];
    displayDueVaccine = json['displayDueVaccine'];
    paymentGatewayEnabled = json['paymentGatewayEnabled'];
    termsLink = json['termsLink'];
    paymentDailyTransactionCount = json['paymentDailyTransactionCount'];
    paymentAmountLimitPerTrans = json['paymentAmountLimitPerTrans'];
    disableRxDownload = json['disableRxDownload'];
    appCode = json['appCode'];
    whatsapplink = json['whatsapplink'];
    timeZoneId = json['timeZoneId'];
    thirdpartyPaymentAPI = json['thirdpartyPaymentAPI'];
    isAdvanceBookingRequired = json['isAdvanceBookingRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerAddress'] = this.customerAddress;
    data['customerContact'] = this.customerContact;
    data['email'] = this.email;
    data['website'] = this.website;
    data['customerLogo'] = this.customerLogo;
    data['logoFileName'] = this.logoFileName;
    data['logoPath'] = this.logoPath;
    data['logoImageURL'] = this.logoImageURL;
    data['advanceBookingFrom'] = this.advanceBookingFrom;
    data['advanceBookingTo'] = this.advanceBookingTo;
    data['realtimeSlotOpenBeforeMinute'] = this.realtimeSlotOpenBeforeMinute;
    data['realtimeSlotCloseBeforeMinute'] = this.realtimeSlotCloseBeforeMinute;
    data['packageId'] = this.packageId;
    data['maxLicenseDoctor'] = this.maxLicenseDoctor;
    data['applySlotOpenFlag'] = this.applySlotOpenFlag;
    data['applySlotCloseFlag'] = this.applySlotCloseFlag;
    data['subscriptionUpto'] = this.subscriptionUpto;
    data['isSubscriptionExpired'] = this.isSubscriptionExpired;
    data['createdUser'] = this.createdUser;
    data['hideCustDetail'] = this.hideCustDetail;
    data['dynamicAppLink'] = this.dynamicAppLink;
    data['displayUpComingVaccine'] = this.displayUpComingVaccine;
    data['displayDueVaccine'] = this.displayDueVaccine;
    data['paymentGatewayEnabled'] = this.paymentGatewayEnabled;
    data['termsLink'] = this.termsLink;
    data['paymentDailyTransactionCount'] = this.paymentDailyTransactionCount;
    data['paymentAmountLimitPerTrans'] = this.paymentAmountLimitPerTrans;
    data['disableRxDownload'] = this.disableRxDownload;
    data['appCode'] = this.appCode;
    data['whatsapplink'] = this.whatsapplink;
    data['timeZoneId'] = this.timeZoneId;
    data['thirdpartyPaymentAPI'] = this.thirdpartyPaymentAPI;
    data['isAdvanceBookingRequired'] = this.isAdvanceBookingRequired;
    return data;
  }
}
