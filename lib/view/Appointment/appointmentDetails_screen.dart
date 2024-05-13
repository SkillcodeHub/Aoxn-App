import 'package:axonweb/Utils/utils.dart';
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
    Widget cancelButton = TextButton(
        child: Text(
          "Cancel",
          style: TextStyle(
            fontSize: titleFontSize,
            color: Color(0xFFFD5722),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        });
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(
          fontSize: titleFontSize,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        Map data = {
          "customerToken": token.toString(),
          "appointmentId":
              widget.appointmentData['data']['appointmentId'].toString(),
        };
        cancelAppointmentViewModel.cancelApointmentApi(data, context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirm",
        style: TextStyle(
          fontSize: titleFontSize,
        ),
      ),
      content: Text(
        "Are you sure want to cancel Appointment?",
        style: TextStyle(
          fontSize: titleFontSize,
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    String date = widget.appointmentData['data']['apptDateLocal'];
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('E d-MMMM-yyyy');
    var outputFormat3 = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var outputDate3 = outputFormat3.format(inputDate);
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(top: 2),
            child: IconButton(
              iconSize: SizerUtil.deviceType == DeviceType.mobile ? 2.5.h : 3.h,
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 2),
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
            physics: AlwaysScrollableScrollPhysics(),
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
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
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
                                fontSize: subTitleFontSize,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text(
                            'Doctor',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: subTitleFontSize,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.appointmentData['data']['doctorName'],
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Patient',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: subTitleFontSize,
                                color: Colors.grey.shade500),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.appointmentData['data']['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: subTitleFontSize,
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
                            'Remember to visit' +
                                ' ' +
                                widget.appointmentData['data']['doctorName'],
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.5.h),
                          Row(
                            children: [
                              Icon(Icons.perm_contact_calendar),
                              SizedBox(width: 1.w),
                              Text(
                                outputDate,
                                style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                outputDate3,
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
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
                            ],
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 1.h,
                          ),
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
                              fontSize: subTitleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  widget.appointmentData['data']['statusText'],
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                    height: 5.h,
                    // width: 45.w,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFD5722),
                      ),
                      child: Text(
                        'RETURN TO HOME',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: subTitleFontSize,
                          color: Colors.white,
                        ),
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
