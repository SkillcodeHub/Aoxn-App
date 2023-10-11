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

  // Initiate Payment Url
  static var initiatepaymenturl = baseUrl + "payment/razorpay/initiate-payment";

  //  register app user Url
  static var registerappuserurl = baseUrl + "Registration/RegisterAppUser";

  //  validate app user Url
  static var validateappuserurl = baseUrl + "Registration/ValidateAppUser";

  //  validate app user Url
  static var validatePaymentUrl = baseUrl + "payment/razorpay/validate-payment";

  //  advance book Appointment Url
  static var advancebookAppointmentUrl =
      baseUrl + "BookAppointment/OrderAppointment";

  //  advance book Appointment Url
  static var confirmPaidAppointmentUrl =
      baseUrl + "BookAppointment/ConfirmPaidAppointment";

  //  advance book Appointment Url
  static var paymentHistoryUrl =
      baseUrl + "/payment/getcustomerpatientpayhistory";
}
