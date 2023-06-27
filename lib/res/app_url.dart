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

  //Get Doctor
  static var getdoctorUrl = baseUrl + "BookAppointment/GetCustomerDoctor";

  //Get Rx Visit History
  static var getrxvisithistoryUrl =
      baseUrl + "BookAppointment/GetRxVisitHistory";
  //Get Appointments Timeslot
  static var getAppointmentstimeslot =
      baseUrl + "BookAppointment/GetAppointmentsInIntervals";
  //Get Appointments Timeslot
  static var getpatientbyid = baseUrl + "BookAppointment/GetPatientByCaseno";
  //Get Appointments Timeslot
  static var getpatientbymobile =
      baseUrl + "BookAppointment/GetPatientByMobileNo";

  //Book Appointment
  static var bookAppointmentUrl = baseUrl + "BookAppointment/BookAppointment";

//Cancel Appointment
  static var cancelAppointmentUrl =
      baseUrl + "BookAppointment/CancelAppointment";

  //Appointment History
  static var getEventList = baseUrl + "BookAppointment/GetAppointmentHistory";

  //Get CustomerPayhead
  static var getcustomerpayhead = baseUrl + "payment/getcustomerpayhead";
}
