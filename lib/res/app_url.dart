class AppUrl {
  //Base Url
  static var baseUrl = "https://www.axonweb.in/api/";

  //Get OTP
  static var loginUrl = baseUrl + "BookAppointment/GenerateOTP";

  //OTP Verify
  static var otpverifyUrl = baseUrl + "BookAppointment/ValidateOTP";

  //Get News List
  static var newsUrl = baseUrl + "NewsFeed/NoticeBoard";

  //Get News Details List
  static var newsDetailsUrl = baseUrl + "NewsFeed/GetNewsDetails";

  //Get Patient Token
  static var customertoken =
      baseUrl + "BookAppointment/GetCustomerTokenByAppCode";

  //Get Doctor Details
  static var getdoctordetailsUrl = baseUrl + "BookAppointment/GetCustomer";
}
