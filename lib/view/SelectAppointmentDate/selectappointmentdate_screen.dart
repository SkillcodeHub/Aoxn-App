// import 'dart:async';

// import 'package:axonweb/Provider/current_time_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import '../../Res/colors.dart';
// import '../../View_Model/SelectAppointDate_View_Model.dart/selectAppointmentDate_view_model.dart';
// import '../../View_Model/Services/SharePreference/SharePreference.dart';
// import '../../data/response/status.dart';

// class SelectAppointmentDateScreen extends StatefulWidget {
//   final dynamic selectedDocotrId;

//   const SelectAppointmentDateScreen(
//       {super.key, required this.selectedDocotrId});

//   @override
//   State<SelectAppointmentDateScreen> createState() =>
//       _SelectAppointmentDateScreenState();
// }

// class _SelectAppointmentDateScreenState
//     extends State<SelectAppointmentDateScreen> {
//   // DateTime selectedDate = DateTime.now(); // TO tracking date
//   DateTime selectedDate =
//       DateTime.now().add(Duration(days: 5)); // TO tracking date
//   String? datetime1;
//   bool isLoading = false;
//   bool TimeSlotes = false;
//   String? selectedTimeSlote;
//   String? DelayMinute;
//   int? timingId;
//   bool isButtonActive = false;
//   UserPreferences userPreference = UserPreferences();
//   late String token;

//   int currentDateSelectedIndex = 5; //For Horizontal Date
//   int? currentDateSelectedIndex1; //For Horizontal Date
//   ScrollController scrollController =
//       ScrollController(); //Scroll Controller for ListView
//   ScrollController scrollController1 =
//       ScrollController(); //Scroll Controller for ListView

//   AppointmentSlotListViewmodel appointmentSlotListViewmodel =
//       AppointmentSlotListViewmodel();

//   void initState() {
//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//         print(token);
//       });
//     });
//     super.initState();
//     final currrentTimeProvider =
//         Provider.of<TimeProvider>(context, listen: false);
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       currrentTimeProvider.updateTime();
//     });

//     print(
//         'selectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDate');
//     print(selectedDate);
//     print(
//         'selectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDates');
//     get();
//   }

//   List<String> listOfMonths = [
//     "Jan",
//     "Feb",
//     "Mar",
//     "Apr",
//     "May",
//     "Jun",
//     "Jul",
//     "Aug",
//     "Sep",
//     "Oct",
//     "Nov",
//     "Dec"
//   ]; //List Of Months

//   List<String> listOfDays = [
//     "Mon",
//     "Tue",
//     "Wed",
//     "Thu",
//     "Fri",
//     "Sat",
//     "Sun"
//   ]; //List of Days

//   createNewsListContainer(BuildContext context, int itemIndex) {
//     String minuteInterval1 = appointmentSlotListViewmodel
//         .AppointmentSlotList.data!.data![itemIndex].minuteInterval!
//         .toString();
//     print(
//         'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
//     print(minuteInterval1);
//     print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
//     // String a = '20.0';
//     // var parts = a.split('.');
//     // var prefix = parts[0].trim();
//     // DelayMinute = prefix.toString();

//     String date = appointmentSlotListViewmodel
//         .AppointmentSlotList.data!.data![itemIndex].fromTimeSlotLocal
//         .toString();
//     DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
//     var inputDate = DateTime.parse(parseDate.toString());
//     var outputFormat3 = DateFormat('hh:mm a');
//     var outputDate3 = outputFormat3.format(inputDate);
//     print(outputDate3);
//     print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');

//     String date1 = appointmentSlotListViewmodel
//         .AppointmentSlotList.data!.data![itemIndex].toTimeSlotLocal
//         .toString();
//     DateTime parseDate1 = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date1);
//     var inputDate1 = DateTime.parse(parseDate1.toString());
//     var outputFormat13 = DateFormat('hh:mm a');
//     var outputDate13 = outputFormat13.format(inputDate1);
//     print(outputDate13);
//     print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
// //============================================================================
//     // int capacity = appointmentData[itemIndex]["capacity"];
//     int capacity = appointmentSlotListViewmodel
//         .AppointmentSlotList.data!.data![itemIndex].capacity!
//         .toInt();
//     // int count = appointmentData[itemIndex]["count"];
//     int count = appointmentSlotListViewmodel
//         .AppointmentSlotList.data!.data![itemIndex].count!
//         .toInt();

//     var total = capacity - count;
//     // int varr = total;
//     print('========================================');
//     print(total);
//     print('==========================================');
//     return Column(
//       children: [
//         TimeSlotes ==
//                     appointmentSlotListViewmodel
//                         .AppointmentSlotList.data!.data![itemIndex].isBlocked &&
//                 total.toInt() > 0
//             ? InkWell(
//                 onTap: () {
//                   setState(() {
//                     String minuteInterval1 = appointmentSlotListViewmodel
//                         .AppointmentSlotList
//                         .data!
//                         .data![itemIndex]
//                         .minuteInterval!
//                         .toString();

//                     print(minuteInterval1);

//                     // String a = '20.0';
//                     var parts = minuteInterval1.split('.');
//                     var prefix = parts[0].trim();
//                     DelayMinute = prefix.toString();
//                     print('minuteInterval1');
//                     print(DelayMinute);
//                     print('minuteInterval1');
//                     currentDateSelectedIndex1 = itemIndex;
//                     // selectedTimeSlote = appointmentSlotListViewmodel
//                     //     .AppointmentSlotList.data!.data![itemIndex].displayTime
//                     //     .toString();
//                     selectedTimeSlote = outputDate3 + ' - ' + outputDate13;
//                     print('selectedTimeSlote');
//                     print(selectedTimeSlote);
//                     print('selectedTimeSlote');
//                     timingId = appointmentSlotListViewmodel
//                         .AppointmentSlotList.data!.data![itemIndex].timingId!
//                         .toInt();
//                     isButtonActive = true;
//                   });
//                 },
//                 child: Container(
//                   height: 12.h,
//                   width: 95.w,
//                   margin: EdgeInsets.only(left: 10, right: 10),
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.grey.shade400,
//                             offset: Offset(3, 3),
//                             blurRadius: 5)
//                       ],
//                       color: currentDateSelectedIndex1 == itemIndex
//                           ? Colors.orange.shade100
//                           : Colors.white),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 2.h),
//                       Text(
//                         // datetime1 == defultDate1 ? str : prefix,
//                         outputDate3 + ' - ' + outputDate13,
//                         // appointmentData[itemIndex]["displayTime"],
//                         // listOftimeslot[itemIndex],
//                         style: SizerUtil.deviceType == DeviceType.mobile
//                             ? TextStyle(
//                                 fontWeight: FontWeight.w500, fontSize: 12.sp)
//                             : TextStyle(
//                                 fontWeight: FontWeight.w500, fontSize: 10.sp),
//                       ),
//                       SizedBox(height: 2.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   total.toString() + " - Available",
//                                   style:
//                                       SizerUtil.deviceType == DeviceType.mobile
//                                           ? TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 12.sp)
//                                           : TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 8.sp),
//                                 ),
//                                 SizedBox(height: 1.h),
//                                 //  SizerUtil.deviceType == DeviceType.mobile ?

//                                 Container(
//                                   height: 3,
//                                   width: 80.w,
//                                   color: Colors.green,
//                                 ),
//                                 //  :  Container(
//                                 //   height: 3,
//                                 //   width: 87.w,
//                                 //   color: Colors.green,
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             child: Icon(
//                               Icons.turned_in_rounded,
//                               color: currentDateSelectedIndex1 == itemIndex
//                                   ? Color(0xFFFD5722)
//                                   : Colors.grey.shade300,
//                               size: 3.h,
//                             ),
//                           )
//                         ],
//                       ),
//                       // SizedBox(height: 5),
//                     ],
//                   ),
//                 ),
//               )
//             : Container(
//                 height: 12.h,
//                 width: 95.w,
//                 margin: EdgeInsets.only(left: 10, right: 10),
//                 padding: EdgeInsets.only(left: 10, right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(2),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       // offset: Offset(3, 3),
//                       // blurRadius: 5,
//                     )
//                   ],
//                   color: Colors.grey.shade300,
//                   // color: currentDateSelectedIndex1 == itemIndex
//                   //     ? Colors.orange.shade100
//                   //     : Colors.white,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 2.h),
//                     Text(
//                       outputDate3 + ' - ' + outputDate13,
//                       style: SizerUtil.deviceType == DeviceType.mobile
//                           ? TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12.sp,
//                               color: Colors.grey.shade700)
//                           : TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 9.sp,
//                               color: Colors.grey.shade700),
//                     ),
//                     SizedBox(height: 2.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "0 - Not available",
//                                 style: SizerUtil.deviceType == DeviceType.mobile
//                                     ? TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 12.sp)
//                                     : TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 8.sp),
//                               ),
//                               SizedBox(height: 1.h),
//                               //  SizerUtil.deviceType == DeviceType.mobile ?

//                               Container(
//                                 height: 3,
//                                 width: 80.w,
//                                 color: Colors.grey.shade500,
//                               ),
//                               //  :  Container(
//                               //   height: 3,
//                               //   width: 87.w,
//                               //   color: Colors.green,
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     // SizedBox(height: 5.h),
//                     // SizedBox(height: 5),
//                   ],
//                 ),
//               ),
//         SizedBox(
//           height: 15,
//         ),
//         isLoading ? Container() : Container(),
//       ],
//     );
//   }

//   get() {
//     datetime1 = DateFormat("yyyy-MM-dd").format(selectedDate);
//     print('datetime1datetime1datetime1datetime1datetime1datetime1');
//     print(datetime1);
//     print(widget.selectedDocotrId);
//     Timer(Duration(microseconds: 20), () {
//       appointmentSlotListViewmodel.fetchAppointmentSlotListApi(
//           widget.selectedDocotrId.toString(),
//           datetime1.toString(),
//           token.toString());
//     });
//     isButtonActive = false;
//     currentDateSelectedIndex1 = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: BackgroundColor,
//       appBar: AppBar(
//         centerTitle: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         leading: Padding(
//           padding: SizerUtil.deviceType == DeviceType.mobile
//               ? EdgeInsets.only(top: 12)
//               : EdgeInsets.all(0),
//           child: IconButton(
//             iconSize: SizerUtil.deviceType == DeviceType.mobile ? 2.5.h : 3.h,
//             color: Colors.black,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_rounded),
//           ),
//         ),
//         title: SizerUtil.deviceType == DeviceType.mobile
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizerUtil.deviceType == DeviceType.mobile
//                       ? SizedBox(height: 15)
//                       : SizedBox(height: 3.74.h),
//                   SizerUtil.deviceType == DeviceType.mobile
//                       ? Text(
//                           'Choose Time',
//                           style:
//                               TextStyle(fontSize: 14.sp, color: Colors.black),
//                         )
//                       : Text(
//                           'Choose Time',
//                           style:
//                               TextStyle(fontSize: 3.5.sp, color: Colors.black),
//                         ),
//                   SizerUtil.deviceType == DeviceType.mobile
//                       ? Consumer<TimeProvider>(
//                           builder: (context, value, child) {
//                           return Text(
//                             '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
//                                 ', ' +
//                                 "${value.currentTime.toString()} IST ",
//                             style:
//                                 TextStyle(fontSize: 12.sp, color: Colors.black),
//                           );
//                         })
//                       : Consumer<TimeProvider>(
//                           builder: (context, value, child) {
//                           return Text(
//                             '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
//                                 ', ' +
//                                 "${value.currentTime.toString()} IST ",
//                             style:
//                                 TextStyle(fontSize: 3.sp, color: Colors.black),
//                           );
//                         }),
//                   SizerUtil.deviceType == DeviceType.mobile
//                       ? SizedBox(height: 10)
//                       : SizedBox(height: 2.5.h),
//                 ],
//               )
//             : Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizerUtil.deviceType == DeviceType.mobile
//                       ? SizedBox(height: 15)
//                       : SizedBox(height: 3.74.h),
//                   Text(
//                     'Choose Time',
//                     style: TextStyle(fontSize: 8.sp, color: Colors.black),
//                   ),
//                   SizedBox(
//                     width: 2.w,
//                   ),
//                   Consumer<TimeProvider>(builder: (context, value, child) {
//                     return Text(
//                       '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
//                           ', ' +
//                           "${value.currentTime.toString()} IST ",
//                       style: TextStyle(fontSize: 8.sp, color: Colors.black),
//                     );
//                   }),
//                 ],
//               ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//                 height: 10.h,
//                 child: Container(
//                     child: ListView.separated(
//                   separatorBuilder: (BuildContext context, int index) {
//                     return SizedBox(width: 0);
//                   },
//                   itemCount: 25,
//                   controller: scrollController,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (BuildContext context, int index) {
//                     print(
//                         'currentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndexcurrentDateSelectedIndex');
//                     print(currentDateSelectedIndex);
//                     print(index);
//                     print(
//                         'indexindexindexindexindexindexindexindexindexindexindexindexindexindexindexindex');
//                     return InkWell(
//                       onTap: () {
//                         setState(() {
//                           currentDateSelectedIndex = index + 5;
//                           selectedDate =
//                               DateTime.now().add(Duration(days: index + 5));
//                           datetime1 =
//                               DateFormat("yyyy-MM-dd").format(selectedDate);
//                           print('pppppppppppppppppppppppp');
//                           print(selectedDate);
//                           print('pppppppppppppppppppppppppppp');
//                           get();
//                           // _getCategory1();
//                         });
//                         print(selectedDate);
//                         //   currentDateSelectedIndex = index;
//                         //   selectedDate = DateTime.now()
//                         //       .subtract(Duration(days: 5))
//                         //       .add(Duration(days: index));
//                         //   datetime1 =
//                         //       DateFormat("yyyy-MM-dd").format(selectedDate);
//                         //   print('pppppppppppppppppppppppp');
//                         //   print(datetime1);
//                         //   print('pppppppppppppppppppppppppppp');
//                         //   get();
//                         //   // _getCategory1();
//                         // });
//                         // print(selectedDate);
//                       },
//                       child: Container(
//                         height: 10.h,
//                         width: 20.3.w,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: currentDateSelectedIndex == index + 5
//                                 ? Color(0xFFFD5722)
//                                 : Colors.white),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               listOfDays[DateTime.now()
//                                               .add(Duration(days: index + 5))
//                                               .weekday -
//                                           1]
//                                       .toString() +
//                                   " - " +
//                                   listOfMonths[DateTime.now()
//                                               .add(Duration(days: index + 5))
//                                               .month -
//                                           1]
//                                       .toString(),
//                               style: SizerUtil.deviceType == DeviceType.mobile
//                                   ? TextStyle(
//                                       fontSize: 12.sp,
//                                       color:
//                                           currentDateSelectedIndex == index + 5
//                                               ? Colors.white
//                                               : Colors.grey)
//                                   : TextStyle(
//                                       fontSize: 8.sp,
//                                       color:
//                                           currentDateSelectedIndex == index + 5
//                                               ? Colors.white
//                                               : Colors.grey),
//                             ),
//                             SizedBox(
//                               height: 2.h,
//                             ),
//                             Text(
//                               DateTime.now()
//                                   .add(Duration(days: index + 5))
//                                   .day
//                                   .toString(),
//                               style: SizerUtil.deviceType == DeviceType.mobile
//                                   ? TextStyle(
//                                       fontSize: 17.sp,
//                                       fontWeight: FontWeight.w700,
//                                       color:
//                                           currentDateSelectedIndex == index + 5
//                                               ? Colors.white
//                                               : Colors.grey)
//                                   : TextStyle(
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w700,
//                                       color:
//                                           currentDateSelectedIndex == index + 5
//                                               ? Colors.white
//                                               : Colors.grey),
//                             ),
//                             SizedBox(
//                               height: 1.h,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ))),
//             SizedBox(height: 10),
//             ChangeNotifierProvider<AppointmentSlotListViewmodel>(
//                 create: (BuildContext context) => appointmentSlotListViewmodel,
//                 child: Consumer<AppointmentSlotListViewmodel>(
//                   builder: (context, value, _) {
//                     switch (value.AppointmentSlotList.status!) {
//                       case Status.LOADING:
//                         return Center(
//                             child: Center(child: CircularProgressIndicator()));
//                       case Status.ERROR:
//                         return Center(
//                             child: Text(
//                                 value.AppointmentSlotList.message.toString()));
//                       case Status.COMPLETED:
//                         return SizedBox(
//                           height: 80.h,
//                           child: ListView.builder(
//                               padding: EdgeInsets.only(bottom: 10),
//                               physics: BouncingScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: appointmentSlotListViewmodel
//                                   .AppointmentSlotList.data!.data!.length,
//                               itemBuilder:
//                                   (BuildContext context, int itemIndex) {
//                                 return createNewsListContainer(
//                                     context, itemIndex);
//                               }),
//                         );
//                     }
//                   },
//                 )),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: isButtonActive ? Colors.green : Colors.grey,
//         onPressed: isButtonActive
//             ? () => Navigator.pop(context, [
//                   datetime1,
//                   selectedTimeSlote,
//                   timingId.toString(),
//                   DelayMinute!.toString(),
//                 ])
//             : null,
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:axonweb/Provider/current_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Res/colors.dart';
import '../../View_Model/SelectAppointDate_View_Model.dart/selectAppointmentDate_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../data/response/status.dart';

class SelectAppointmentDateScreen extends StatefulWidget {
  final dynamic selectedDocotrId;

  const SelectAppointmentDateScreen(
      {super.key, required this.selectedDocotrId});

  @override
  State<SelectAppointmentDateScreen> createState() =>
      _SelectAppointmentDateScreenState();
}

class _SelectAppointmentDateScreenState
    extends State<SelectAppointmentDateScreen> {
  // DateTime selectedDate = DateTime.now(); // TO tracking date
  late DateTime selectedDate; // TO tracking date
  String? datetime1;
  bool isLoading = false;
  bool TimeSlotes = false;
  String? selectedTimeSlote;
  String? DelayMinute;
  int? timingId;
  bool isButtonActive = false;
  UserPreferences userPreference = UserPreferences();
  late String token;

  dynamic advanceBookingFrom;
  dynamic advanceBookingTo;
  dynamic UserData;

  int? currentDateSelectedIndex; //For Horizontal Date
  int? currentDateSelectedIndex1; //For Horizontal Date
  ScrollController scrollController =
      ScrollController(); //Scroll Controller for ListView
  ScrollController scrollController1 =
      ScrollController(); //Scroll Controller for ListView

  AppointmentSlotListViewmodel appointmentSlotListViewmodel =
      AppointmentSlotListViewmodel();

  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
        print(token);
      });
    });
    userPreference.getUserDetails().then((value) {
      setState(() {
        UserData = value!;
        advanceBookingFrom = UserData['data']['advanceBookingFrom'].toString();
        advanceBookingTo = UserData['data']['advanceBookingTo'].toString();
        print('222222222222222222222222222222222222222222');
        print(advanceBookingFrom);
        print(advanceBookingTo);
        selectedDate =
            DateTime.now().add(Duration(days: int.parse(advanceBookingFrom)));
        currentDateSelectedIndex =
            int.parse(advanceBookingFrom); //For Horizontal Date
        // TO tracking date
      });
      get();
    });
    super.initState();

    final currrentTimeProvider =
        Provider.of<TimeProvider>(context, listen: false);
    Timer.periodic(Duration(seconds: 1), (timer) {
      currrentTimeProvider.updateTime();
    });

    // print(
    //     'selectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDate');
    // print(selectedDate);
    // print(
    //     'selectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDates');
  }

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ]; //List Of Months

  List<String> listOfDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ]; //List of Days

  createNewsListContainer(BuildContext context, int itemIndex) {
    String minuteInterval1 = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].minuteInterval!
        .toString();
    // print(
    //     'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    // print(minuteInterval1);
    // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    // String a = '20.0';
    // var parts = a.split('.');
    // var prefix = parts[0].trim();
    // DelayMinute = prefix.toString();

    String date = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].fromTimeSlotLocal
        .toString();
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat3 = DateFormat('hh:mm a');
    var outputDate3 = outputFormat3.format(inputDate);
    // print(outputDate3);
    // print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');

    String date1 = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].toTimeSlotLocal
        .toString();
    DateTime parseDate1 = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date1);
    var inputDate1 = DateTime.parse(parseDate1.toString());
    var outputFormat13 = DateFormat('hh:mm a');
    var outputDate13 = outputFormat13.format(inputDate1);
    // print(outputDate13);
    // print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
//============================================================================
    // int capacity = appointmentData[itemIndex]["capacity"];
    int capacity = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].capacity!
        .toInt();
    // int count = appointmentData[itemIndex]["count"];
    int count = appointmentSlotListViewmodel
        .AppointmentSlotList.data!.data![itemIndex].count!
        .toInt();

    var total = capacity - count;
    // int varr = total;
    // print('========================================');
    // print(total);
    // print('==========================================');
    return Column(
      children: [
        TimeSlotes ==
                    appointmentSlotListViewmodel
                        .AppointmentSlotList.data!.data![itemIndex].isBlocked &&
                total.toInt() > 0
            ? InkWell(
                onTap: () {
                  setState(() {
                    String minuteInterval1 = appointmentSlotListViewmodel
                        .AppointmentSlotList
                        .data!
                        .data![itemIndex]
                        .minuteInterval!
                        .toString();

                    // print(minuteInterval1);

                    // String a = '20.0';
                    var parts = minuteInterval1.split('.');
                    var prefix = parts[0].trim();
                    DelayMinute = prefix.toString();
                    // print('minuteInterval1');
                    // print(DelayMinute);
                    // print('minuteInterval1');
                    currentDateSelectedIndex1 = itemIndex;
                    // selectedTimeSlote = appointmentSlotListViewmodel
                    //     .AppointmentSlotList.data!.data![itemIndex].displayTime
                    //     .toString();
                    selectedTimeSlote = outputDate3 + ' - ' + outputDate13;
                    // print('selectedTimeSlote');
                    // print(selectedTimeSlote);
                    // print('selectedTimeSlote');
                    timingId = appointmentSlotListViewmodel
                        .AppointmentSlotList.data!.data![itemIndex].timingId!
                        .toInt();
                    isButtonActive = true;
                  });
                },
                child: Container(
                  height: 12.h,
                  width: 95.w,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(3, 3),
                            blurRadius: 5)
                      ],
                      color: currentDateSelectedIndex1 == itemIndex
                          ? Colors.orange.shade100
                          : Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Text(
                        // datetime1 == defultDate1 ? str : prefix,
                        outputDate3 + ' - ' + outputDate13,
                        // appointmentData[itemIndex]["displayTime"],
                        // listOftimeslot[itemIndex],
                        style: SizerUtil.deviceType == DeviceType.mobile
                            ? TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.sp)
                            : TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 10.sp),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  total.toString() + " - Available",
                                  style:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp)
                                          : TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.sp),
                                ),
                                SizedBox(height: 1.h),
                                //  SizerUtil.deviceType == DeviceType.mobile ?

                                Container(
                                  height: 3,
                                  width: 80.w,
                                  color: Colors.green,
                                ),
                                //  :  Container(
                                //   height: 3,
                                //   width: 87.w,
                                //   color: Colors.green,
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.turned_in_rounded,
                              color: currentDateSelectedIndex1 == itemIndex
                                  ? Color(0xFFFD5722)
                                  : Colors.grey.shade300,
                              size: 3.h,
                            ),
                          )
                        ],
                      ),
                      // SizedBox(height: 5),
                    ],
                  ),
                ),
              )
            : Container(
                height: 12.h,
                width: 95.w,
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      // offset: Offset(3, 3),
                      // blurRadius: 5,
                    )
                  ],
                  color: Colors.grey.shade300,
                  // color: currentDateSelectedIndex1 == itemIndex
                  //     ? Colors.orange.shade100
                  //     : Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      outputDate3 + ' - ' + outputDate13,
                      style: SizerUtil.deviceType == DeviceType.mobile
                          ? TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.grey.shade700)
                          : TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp,
                              color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "0 - Not available",
                                style: SizerUtil.deviceType == DeviceType.mobile
                                    ? TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)
                                    : TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8.sp),
                              ),
                              SizedBox(height: 1.h),
                              //  SizerUtil.deviceType == DeviceType.mobile ?

                              Container(
                                height: 3,
                                width: 80.w,
                                color: Colors.grey.shade500,
                              ),
                              //  :  Container(
                              //   height: 3,
                              //   width: 87.w,
                              //   color: Colors.green,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(height: 5.h),
                    // SizedBox(height: 5),
                  ],
                ),
              ),
        SizedBox(
          height: 15,
        ),
        isLoading ? Container() : Container(),
      ],
    );
  }

  get() {
    print(
        'selectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDate');
    print(selectedDate);
    print(
        'selectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDateselectedDate');
    datetime1 = DateFormat("yyyy-MM-dd").format(selectedDate);
    // print(datetime1);
    // print(widget.selectedDocotrId);
    Timer(Duration(microseconds: 20), () {
      appointmentSlotListViewmodel.fetchAppointmentSlotListApi(
          widget.selectedDocotrId.toString(),
          datetime1.toString(),
          token.toString());
    });
    isButtonActive = false;
    currentDateSelectedIndex1 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: SizerUtil.deviceType == DeviceType.mobile
              ? EdgeInsets.only(top: 12)
              : EdgeInsets.all(0),
          child: IconButton(
            iconSize: SizerUtil.deviceType == DeviceType.mobile ? 2.5.h : 3.h,
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
        ),
        title: SizerUtil.deviceType == DeviceType.mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizerUtil.deviceType == DeviceType.mobile
                      ? SizedBox(height: 15)
                      : SizedBox(height: 3.74.h),
                  SizerUtil.deviceType == DeviceType.mobile
                      ? Text(
                          'Choose Time',
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black),
                        )
                      : Text(
                          'Choose Time',
                          style:
                              TextStyle(fontSize: 3.5.sp, color: Colors.black),
                        ),
                  SizerUtil.deviceType == DeviceType.mobile
                      ? Consumer<TimeProvider>(
                          builder: (context, value, child) {
                          return Text(
                            '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
                                ', ' +
                                "${value.currentTime.toString()} IST ",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          );
                        })
                      : Consumer<TimeProvider>(
                          builder: (context, value, child) {
                          return Text(
                            '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
                                ', ' +
                                "${value.currentTime.toString()} IST ",
                            style:
                                TextStyle(fontSize: 3.sp, color: Colors.black),
                          );
                        }),
                  SizerUtil.deviceType == DeviceType.mobile
                      ? SizedBox(height: 10)
                      : SizedBox(height: 2.5.h),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizerUtil.deviceType == DeviceType.mobile
                      ? SizedBox(height: 15)
                      : SizedBox(height: 3.74.h),
                  Text(
                    'Choose Time',
                    style: TextStyle(fontSize: 8.sp, color: Colors.black),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Consumer<TimeProvider>(builder: (context, value, child) {
                    return Text(
                      '${DateFormat("dd-MMM-yyyy").format(DateTime.now())}' +
                          ', ' +
                          "${value.currentTime.toString()} IST ",
                      style: TextStyle(fontSize: 8.sp, color: Colors.black),
                    );
                  }),
                ],
              ),
      ),
      body: advanceBookingTo != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                advanceBookingFrom == '0' && advanceBookingTo == '0'
                    ? Container(
                        // color: Colors.amber,
                        height: 10.h,
                        child: Container(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              print(
                                  'indexindexindexindexindexindexindexindexindexindexindexindexindexindexindexindex');
                              print(currentDateSelectedIndex);
                              print(advanceBookingFrom);
                              return SizedBox(width: 0);
                            },
                            itemCount:
                                5, // Fixed itemCount to show 5 containers
                            controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              print(
                                  'indexindexindexindexindexindexindexindexindexindexindexindexindexindexindexindex');
                              print(currentDateSelectedIndex);
                              print(advanceBookingFrom);

                              // Calculate the actual index considering the offset
                              int actualIndex = index + DateTime.now().day - 2;

                              // Determine if the current container represents today's date
                              bool isToday = index == 2;

                              // Determine if the current container represents the previous or upcoming dates
                              bool isDisabled = index < 2 || index > 2;

                              // Set the selected date to today's date
                              if (isToday) {
                                currentDateSelectedIndex = actualIndex;
                                selectedDate = DateTime.now();
                                datetime1 = DateFormat("yyyy-MM-dd")
                                    .format(selectedDate);
                              }

                              return InkWell(
                                onTap: isDisabled
                                    ? null // Disable onTap for previous and upcoming dates
                                    : () {
                                        setState(() {
                                          // Set the selected index only if it's today's date
                                          if (isToday) {
                                            currentDateSelectedIndex =
                                                actualIndex;
                                            selectedDate = DateTime.now();
                                            datetime1 = DateFormat("yyyy-MM-dd")
                                                .format(selectedDate);
                                            get();
                                          }
                                        });
                                      },
                                child: Container(
                                  height: 10.h,
                                  width: 20.3.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDisabled
                                        ? Colors
                                            .white // Change color for previous and upcoming dates
                                        : isToday
                                            ? Color(
                                                0xFFFD5722) // Change color for today's date
                                            : Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isToday
                                            ? "Today"
                                            : listOfDays[DateTime.now()
                                                            .add(Duration(
                                                                days:
                                                                    index - 2))
                                                            .weekday -
                                                        1]
                                                    .toString() +
                                                " - " +
                                                listOfMonths[DateTime.now()
                                                            .add(Duration(
                                                                days:
                                                                    index - 2))
                                                            .month -
                                                        1]
                                                    .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 12.sp
                                              : 8.sp,
                                          color: isDisabled
                                              ? Colors.grey
                                              : isToday
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        isToday
                                            ? DateTime.now().day.toString()
                                            : DateTime.now()
                                                .add(Duration(days: index - 2))
                                                .day
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 17.sp
                                              : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDisabled
                                              ? Colors.grey
                                              : isToday
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        height: 10.h,
                        child: Container(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 0);
                            },
                            itemCount: int.parse(advanceBookingTo) +
                                1 -
                                int.parse(advanceBookingFrom) +
                                4,
                            controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              // Calculate the actual index considering the offset
                              int actualIndex =
                                  index + int.parse(advanceBookingFrom) - 2;

                              // Determine if it's within the range of the first two and last two elements
                              bool isDisabled = index < 2 ||
                                  index >=
                                      int.parse(advanceBookingTo) +
                                          1 -
                                          int.parse(advanceBookingFrom) +
                                          2;

                              // Determine the text color based on container state
                              Color textColor;
                              if (isDisabled) {
                                textColor = Colors.grey;
                              } else if (currentDateSelectedIndex ==
                                  actualIndex) {
                                textColor = Colors.white;
                              } else {
                                textColor = Colors.black;
                              }

                              return InkWell(
                                onTap: isDisabled
                                    ? null // Disable onTap for first two and last two containers
                                    : () {
                                        setState(() {
                                          // Set the selected index only if it's not disabled
                                          currentDateSelectedIndex =
                                              actualIndex;
                                          selectedDate = DateTime.now()
                                              .add(Duration(days: actualIndex));
                                          datetime1 = DateFormat("yyyy-MM-dd")
                                              .format(selectedDate);
                                          get();
                                        });
                                      },
                                child: Container(
                                  height: 10.h,
                                  width: 20.3.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDisabled
                                        ? Colors
                                            .white // Change color for disabled containers
                                        : currentDateSelectedIndex ==
                                                actualIndex
                                            ? Color(0xFFFD5722)
                                            : Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        listOfDays[DateTime.now()
                                                        .add(Duration(
                                                            days: actualIndex))
                                                        .weekday -
                                                    1]
                                                .toString() +
                                            " - " +
                                            listOfMonths[DateTime.now()
                                                        .add(Duration(
                                                            days: actualIndex))
                                                        .month -
                                                    1]
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 12.sp
                                              : 8.sp,
                                          color: textColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        DateTime.now()
                                            .add(Duration(days: actualIndex))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: SizerUtil.deviceType ==
                                                  DeviceType.mobile
                                              ? 17.sp
                                              : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                // Container(
                //     color: Colors.amber,
                //     height: 10.h,
                //     child: Container(
                //       child: ListView.separated(
                //         separatorBuilder:
                //             (BuildContext context, int index) {
                //           print(
                //               'indexindexindexindexindexindexindexindexindexindexindexindexindexindexindexindex');
                //           print(currentDateSelectedIndex);
                //           print(advanceBookingFrom);
                //           return SizedBox(width: 0);
                //         },
                //         itemCount: int.parse(advanceBookingTo),
                //         controller: scrollController,
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (BuildContext context, int index) {
                //           print(
                //               'indexindexindexindexindexindexindexindexindexindexindexindexindexindexindexindex');
                //           print(currentDateSelectedIndex);
                //           print(advanceBookingFrom);

                //           // Calculate the actual index considering the offset
                //           int actualIndex =
                //               index + int.parse(advanceBookingFrom) - 2;

                //           // Check if it's within the range of the first two and last two elements
                //           bool isDisabled = index < 2 ||
                //               index >= int.parse(advanceBookingTo) - 2;

                //           // Determine the text color based on container state
                //           Color textColor;
                //           if (isDisabled) {
                //             textColor = Colors.grey;
                //           } else if (currentDateSelectedIndex ==
                //               actualIndex) {
                //             textColor = Colors.white;
                //           } else {
                //             textColor = Colors.black;
                //           }

                //           return InkWell(
                //             onTap: isDisabled
                //                 ? null // Disable onTap for first two and last two containers
                //                 : () {
                //                     setState(() {
                //                       // Set the selected index only if it's not disabled
                //                       currentDateSelectedIndex =
                //                           actualIndex;
                //                       selectedDate = DateTime.now()
                //                           .add(Duration(days: actualIndex));
                //                       datetime1 = DateFormat("yyyy-MM-dd")
                //                           .format(selectedDate);
                //                       get();
                //                     });
                //                   },
                //             child: Container(
                //               height: 10.h,
                //               width: 20.3.w,
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                 color: isDisabled
                //                     ? Colors
                //                         .white // Change color for disabled containers
                //                     : currentDateSelectedIndex ==
                //                             actualIndex
                //                         ? Color(0xFFFD5722)
                //                         : Colors.white,
                //               ),
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Text(
                //                     listOfDays[DateTime.now()
                //                                     .add(Duration(
                //                                         days: actualIndex))
                //                                     .weekday -
                //                                 1]
                //                             .toString() +
                //                         " - " +
                //                         listOfMonths[DateTime.now()
                //                                     .add(Duration(
                //                                         days: actualIndex))
                //                                     .month -
                //                                 1]
                //                             .toString(),
                //                     style: TextStyle(
                //                       fontSize: SizerUtil.deviceType ==
                //                               DeviceType.mobile
                //                           ? 12.sp
                //                           : 8.sp,
                //                       color: textColor,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     height: 2.h,
                //                   ),
                //                   Text(
                //                     DateTime.now()
                //                         .add(Duration(days: actualIndex))
                //                         .day
                //                         .toString(),
                //                     style: TextStyle(
                //                       fontSize: SizerUtil.deviceType ==
                //                               DeviceType.mobile
                //                           ? 17.sp
                //                           : 12.sp,
                //                       fontWeight: FontWeight.w700,
                //                       color: textColor,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     height: 1.h,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),

                SizedBox(height: 10),
                SingleChildScrollView(
                  child: ChangeNotifierProvider<AppointmentSlotListViewmodel>(
                      create: (BuildContext context) =>
                          appointmentSlotListViewmodel,
                      child: Consumer<AppointmentSlotListViewmodel>(
                        builder: (context, value, _) {
                          switch (value.AppointmentSlotList.status!) {
                            case Status.LOADING:
                              return Center(
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.AppointmentSlotList.message
                                      .toString()));
                            case Status.COMPLETED:
                              return SizedBox(
                                height: 73.h,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 10),
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: appointmentSlotListViewmodel
                                        .AppointmentSlotList.data!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int itemIndex) {
                                      return createNewsListContainer(
                                          context, itemIndex);
                                    }),
                              );
                          }
                        },
                      )),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isButtonActive ? Colors.green : Colors.grey,
        onPressed: isButtonActive
            ? () => Navigator.pop(context, [
                  datetime1,
                  selectedTimeSlote,
                  timingId.toString(),
                  DelayMinute!.toString(),
                ])
            : null,
        child: Icon(Icons.check),
      ),
    );
  }
}









// ChangeNotifierProvider<AppointmentSlotListViewmodel>(
//           create: (BuildContext context) => appointmentSlotListViewmodel,
//           child: Consumer<AppointmentSlotListViewmodel>(
//             builder: (context, value, _) {
//               switch (value.AppointmentSlotList.status!) {
//                 case Status.LOADING:
//                   return Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return Center(
//                       child: Text(value.AppointmentSlotList.message.toString()));
//                 case Status.COMPLETED:
//                   return RefreshIndicator(
//                     onRefresh: refresh,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 6),
//                       child: ListView.builder(
//                           padding: EdgeInsets.only(bottom: 0),
//                           physics: BouncingScrollPhysics(),
//                           // shrinkWrap: true,
//                           itemCount:
//                               reportViewmodel.reportsList.data!.data!.length,
//                           itemBuilder: (BuildContext context, int itemIndex) {
//                             return createNewsListContainer(context, itemIndex);
//                           }),
//                     ),
//                   );
//               }
//             },
//           )),