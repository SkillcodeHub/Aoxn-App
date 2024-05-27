import 'dart:async';

import 'package:axonweb/Utils/utils.dart';
import 'package:axonweb/res/components/appbar/screen_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../View_Model/Book_View_Model/cancelAppointment_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';

class EventDetailsScreen extends StatefulWidget {
  final dynamic appoitmentData;
  const EventDetailsScreen({Key? key, required this.appoitmentData})
      : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  UserPreferences userPreference = UserPreferences();
  late String token;
  String? outputDate;
  String? doctorName;
  String? outputDate3;
  String? patientName;
  String? status;
  String? cancelStatus;
  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    setState(() {
      print(widget.appoitmentData.toString());
      outputDate = widget.appoitmentData['date'] as String?;
      doctorName = widget.appoitmentData['doctorName'] as String?;
      outputDate3 = widget.appoitmentData['outputDate3'] as String?;
      patientName = widget.appoitmentData['patientName'] as String?;
      status = widget.appoitmentData['status'] as String?;
    });
    super.initState();
  }

  void showAlertDialog(BuildContext context) {
    final cancelAppointmentViewModel =
        Provider.of<CancelAppointmentViewModel>(context, listen: false);
    // set up the buttons
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
          "customerToken": token,
          "appointmentId": widget.appoitmentData['appointmentId'],
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
          fontSize: subTitleFontSize,
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
        return Container(
          height: 300,
          width: 100,
          child: alert,
        );
      },
    );
  }

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
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
            padding: EdgeInsets.only(
              top: 2.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenNameWidget(
                  title: 'Appointment',
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 8, right: 8),
                child: Column(
                  children: [
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
                              doctorName.toString(),
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
                              patientName.toString(),
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
                              'Remember to visit' + ' ' + doctorName.toString(),
                              style: TextStyle(
                                fontSize: subTitleFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.perm_contact_calendar,
                                  size: 3.h,
                                ),
                                Text(
                                  " " + outputDate.toString(),
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
                                  size: 3.h,
                                ),
                                Text(
                                  " " + outputDate3.toString(),
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
                              width: 400,
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
                                    status.toString(),
                                    style: TextStyle(
                                      fontSize: subTitleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  child: status == 'Booked'
                                      ? Text(
                                          'CANCEL',
                                          style: TextStyle(
                                            fontSize: titleFontSize,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFD5722),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
