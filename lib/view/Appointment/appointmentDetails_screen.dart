import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Res/Components/Appbar/screen_name_widget.dart';
import '../../Res/colors.dart';

class AppointmentDetails extends StatefulWidget {
  final dynamic appointmentData;
  const AppointmentDetails({super.key, required this.appointmentData});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
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
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFD5722),
                    ),
                  ),
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
                            widget.appointmentData['data']['doctorName'],
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
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            // 'aaa',
                            widget.appointmentData['data']['name'],
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
                            'Remember to visit' +
                                ' ' +
                                widget.appointmentData['data']['doctorName'],
                            // + historyData['doctorName'],
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.perm_contact_calendar),
                              Text(
                                outputDate,
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.punch_clock),
                              Text(
                                outputDate3,
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
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
                                  widget.appointmentData['data']['statusText'],
                                  //'aaaa',
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
                                  // showAlertDialog(context);
                                },
                                child: widget.appointmentData['data']
                                            ['statusText'] ==
                                        'Booked'
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
