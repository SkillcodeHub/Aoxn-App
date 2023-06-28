import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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
  String cancelStatus = "Appointment cancelled";
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
    // super.initState();
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
          fontSize: 15,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        Map data = {
          "customerToken": token,
          "appointmentId": widget.appoitmentData['appointmentId'],
        };
        cancelAppointmentViewModel.cancelApointmentApi(data, context);

        // showAlert(context);
        // _cancelAppointmentDetails();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Are you sure want to cancel Appointment?"),
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

  showAlert(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        status = 'Canceled';
        print('cancelStatus');
        print(status);
        print('cancelStatus');
        Navigator.of(context)
          ..pop()
          ..pop();

        // status = 'canceled';
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(cancelStatus),
      actions: [
        okButton,
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

  Future refresh() async {
    setState(() {});
    // Timer(Duration(microseconds: 20), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              top: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Appointment",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
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
                    SizedBox(height: 6),
                    Card(
                      // margin: EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 400,
                              height: 5,
                            ),
                            Text(
                              'Your Appointment is booked for:',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Provider',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              doctorName.toString(),
                              // appointmentData['doctorName'],
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Patient',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              patientName.toString(),
                              // appointmentData['name'],
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 5,
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
                              width: 400,
                              height: 5,
                            ),
                            Text(
                              // 'aaa',
                              'Remember to visit' + ' ' + doctorName.toString(),
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.perm_contact_calendar),
                                Text(
                                  outputDate.toString(),
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded),
                                Text(
                                  outputDate3.toString(),
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "SAVE TO CALENDER",
                                      style: TextStyle(
                                        color: Color(0xFFFD5722),
                                      ),
                                    ))
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
                              width: 400,
                              // height: 10,
                            ),
                            Text(
                              'Your Appointment Status:',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // width: MediaQuery.of(context).size.width * 0.71,
                                  child: Text(
                                    status.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFFD5722),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width * 0.60,
                                // ),
                                TextButton(
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  child: status == 'Booked'
                                      ? Text(
                                          'CANCEL',
                                          style: TextStyle(
                                            fontSize: 15,
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
                      height: 20,
                    ),
                    // Container(
                    //   height: 40,
                    //   width: 170,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Color(0xFFFD5722),
                    //     ),
                    //     child: Text(
                    //       'RETURN TO HOME',
                    //     ),
                    //   ),
                    // )
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
