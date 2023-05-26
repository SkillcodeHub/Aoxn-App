class AppUrl {
  static var baseUrl = "https://www.axonweb.in/api/";

  static var loginUrl = baseUrl + "BookAppointment/GenerateOTP";

  static var otpverifyUrl = baseUrl + "BookAppointment/ValidateOTP";
  static var newsUrl = baseUrl + "NewsFeed/NoticeBoard";
  static var customertoken =
      baseUrl + "BookAppointment/GetCustomerTokenByAppCode";
}
