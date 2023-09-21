import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Res/Components/Appbar/screen_name_widget.dart';
import '../../Res/colors.dart';
import '../../View_Model/Book_View_Model/cancelAppointment_view_model.dart';
import '../../view_model/services/SharePreference/SharePreference.dart';

class AppointmentDetails extends StatefulWidget {
  final dynamic appointmentData;
  const AppointmentDetails({super.key, required this.appointmentData});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
    UserPreferences userPreference = UserPreferences();
  late String token;
  String? status;
  String cancelStatus = "Appointment cancelled";

@override
  void initState() {
    

    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    setState(() {
      
      status = widget.appointmentData['data']['statusText'] as String?;
    });
    super.initState();
  }

showAlertDialog(BuildContext context) {
    final cancelAppointmentViewModel =
        Provider.of<CancelAppointmentViewModel>(context, listen: false);
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          fontSize: 14.sp,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      }
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(
          fontSize: 14.sp,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        Map data = {
          "customerToken": token.toString(),
          "appointmentId": widget.appointmentData['data']['appointmentId'].toString(),
        };
        cancelAppointmentViewModel.cancelApointmentApi(data, context);

        // showAlert(context);
        // _cancelAppointmentDetails();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm",style: TextStyle(
          fontSize: 15.sp,
        ),),
      content: Text("Are you sure want to cancel Appointment?",style: TextStyle(
          fontSize: 13.sp,
        ),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // showAlert(BuildContext context) {
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text(
  //       "OK",
  //       style: TextStyle(
  //         fontSize: 14.sp,
  //         color: Color(0xFFFD5722),
  //       ),
  //     ),
  //     onPressed: () {
  //       status = 'Canceled';
  //       print('cancelStatus');
  //       print(status);
  //       print('cancelStatus');
  //       Navigator.of(context)
  //         ..pop()
  //         ..pop();

  //       // status = 'canceled';
  //     },
  //   );

    // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Alert"),
  //     content: Text(cancelStatus),
  //     actions: [
  //       okButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }






  @override
  Widget build(BuildContext context) {
  String date =
        widget.appointmentData['data']['apptDateLocal'];
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('E d-MMMM-yyyy');
    var outputFormat1 = DateFormat('E,yyyy');
    var outputFormat2 = DateFormat('d MMM');
    var outputFormat3 = DateFormat('hh:mm a');
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var outputDate1 = outputFormat1.format(inputDate);
    var outputDate2 = outputFormat2.format(inputDate);
    var outputDate3 = outputFormat3.format(inputDate);
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    print(outputDate);
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenNameWidget(
                  title: 'Book Appointment',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 8, right: 8),
              child: Column(
                children: [
                  Text(
                    'Booking Successful',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFD5722),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Card(
                    // margin: EdgeInsets.all(3),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100.w,
                            height: 1.h,
                          ),
                          Text(
                            'Your appointment is booked for:',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'Doctor',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.appointmentData['data']['doctorName'],
                            // appointmentData['doctorName'],
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'Patient',
                            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            // 'aaa',
                            widget.appointmentData['data']['name'],
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100.w,
                            height: 1.h,
                          ),
                          Text(
                            // 'aaa',
                            'Remember to visit' +
                                ' ' +
                                widget.appointmentData['data']['doctorName'],
                            // + historyData['doctorName'],
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(Icons.perm_contact_calendar),
                              Text(
                                outputDate,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Icon(Icons.access_time_rounded,),
                              Text(
                                outputDate3,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 2.w,
                              ),
                              // TextButton(
                              //     onPressed: () {},
                                  // child: Text(
                                  //   "SAVE TO CALENDER",
                                  //   style: TextStyle(
                                  //     color: Color(0xFFFD5722),
                                  //                                       fontSize: 12.sp,

                                  //   ),
                                  // )

                                  // )

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100.w,
                            // height: 10,
                          ),
                          Text(
                            'Your appointment status:',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width * 0.71,
                                child: Text(
                                  widget.appointmentData['data']['statusText'],
                                  //'aaaa',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    // color: Color(0xFFFD5722),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.60,
                              // ),
                              // TextButton(
                              //   onPressed: () {
                              //     showAlertDialog(context);
                              //   },
                              //   child: widget.appointmentData['data']
                              //               ['statusText'] ==
                              //           'Booked'
                              //       ? Text(
                              //           'CANCEL',
                              //           style: TextStyle(
                              //             fontSize: 12.sp,
                              //             color: Color(0xFFFD5722),
                              //           ),
                              //         )
                              //       : Container(),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 170,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFD5722),
                      ),
                      child: Text(
                        'RETURN TO HOME',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
