// // import 'dart:async';
// // import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sizer/sizer.dart';
// // import '../../Res/Components/Appbar/payment_widget.dart';
// // import '../../Res/Components/loader.dart';
// // import '../../Res/colors.dart';
// // import '../../View_Model/Services/SharePreference/SharePreference.dart';
// // import '../../data/response/status.dart';
// // import '../../res/components/appbar/axonimage_appbar-widget.dart';
// // import '../../res/components/appbar/screen_name_widget.dart';
// // import '../../res/components/appbar/settings_widget.dart';
// // import '../../res/components/appbar/whatsapp_widget.dart';

// // class BookApointmentScreen extends StatefulWidget {
// //   const BookApointmentScreen({super.key});

// //   @override
// //   State<BookApointmentScreen> createState() => _BookApointmentScreenState();
// // }

// // class _BookApointmentScreenState extends State<BookApointmentScreen> {
// //   UserPreferences userPreference = UserPreferences();
// //   DoctorListViewmodel doctorListViewmodel = DoctorListViewmodel();

// //   late String number;

// //   late String selectedDocotrId;

// //   bool isLoading = false;
// //   var mobile;
// //   late String token;
// //   late String deviceId;
// //   String displaySelectAppointmentDate = 'Select Appointment Date';
// //   String displayDate = '';
// //   String appointmentDate = '';
// //   String? DelayMinute;
// //   String displayTimeSlot = '';
// //   String? displaytimingId;
// //   String displayPatientName = 'Select Patient';
// //   String? displayBirthDate;
// //   String? displayGender;
// //   String CaseNo = "";
// //   String PatType = "";

// //   // List doctorData = [];
// //   // List customerData = [];

// //   @override
// //   void initState() {
// //     userPreference.getMobile().then((value1) {
// //       setState(() {
// //         mobile = value1;
// //       });
// //     });

// //     userPreference.getToken().then((value) {
// //       setState(() {
// //         token = value!;
// //       });
// //     });
// //     userPreference.getDeviceId().then((value) {
// //       setState(() {
// //         deviceId = value!;
// //       });
// //     });
// //     // setState(() {});
// //     // super.initState();
// //     super.initState();
// //     doctorListViewmodel =
// //         Provider.of<DoctorListViewmodel>(context, listen: false);

// //     Timer(Duration(microseconds: 20), () {
// //       doctorListViewmodel.fetchDoctorListApi(token);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     print('ParthParthParth');
// //     return Scaffold(
// //       backgroundColor: BackgroundColor,
// //       appBar: PreferredSize(
// //         preferredSize: Size.fromHeight(60.0),
// //         child: AppBar(
// //           automaticallyImplyLeading: false,
// //           centerTitle: false,
// //           backgroundColor: Color(0xffffffff),
// //           elevation: 0,
// //           title: Padding(
// //             padding: const EdgeInsets.only(top: 5.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 AxonIconForAppBarrWidget(),
// //                 ScreenNameWidget(
// //                   title: 'Book Appointment',
// //                 ),
// //                 WhatsappWidget(),
// //                 PaymentWidget(),
// //                 SettingsWidget(),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: ChangeNotifierProvider<DoctorListViewmodel>.value(
// //           value: doctorListViewmodel,
// //           child: Consumer<DoctorListViewmodel>(
// //             builder: (context, value, child) {
// //               switch (value.doctorList.status!) {
// //                 case Status.LOADING:
// //                   return Center(child: CircularProgressIndicator());
// //                 case Status.ERROR:
// //                   return Center(
// //                       child: Text(value.doctorList.message.toString()));
// //                 case Status.COMPLETED:
// //                   return Stack(
// //                     children: [
// //                       SingleChildScrollView(
// //                         // physics: BouncingScrollPhysics(),
// //                         child: Padding(
// //                           padding: EdgeInsets.all(0),
// //                           child: isLoading
// //                               ? isLoading
// //                                   ? Container()
// //                                   : Container()
// //                               : Column(
// //                                   children: [
// //                                     Card(
// //                                       shape: RoundedRectangleBorder(
// //                                         borderRadius: BorderRadius.circular(8),
// //                                       ),
// //                                       margin:
// //                                           EdgeInsets.only(left: 8, right: 8),
// //                                       child: Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: <Widget>[
// //                                           Container(
// //                                             height: 12.h,
// //                                             width: 78.w,
// //                                             padding: EdgeInsets.all(8),
// //                                             child: Column(
// //                                               mainAxisAlignment:
// //                                                   MainAxisAlignment
// //                                                       .spaceBetween,
// //                                               crossAxisAlignment:
// //                                                   CrossAxisAlignment.start,
// //                                               children: [
// //                                                 Text(
// //                                                   'Provider',
// //                                                   style: TextStyle(
// //                                                       fontSize: 15,
// //                                                       fontWeight:
// //                                                           FontWeight.w400,
// //                                                       color:
// //                                                           Colors.grey.shade700),
// //                                                 ),
// //                                                 SizedBox(height: 1.h),
// //                                                 Container(
// //                                                   alignment:
// //                                                       Alignment.centerLeft,
// //                                                   child:
// //                                                       DropdownButtonHideUnderline(
// //                                                     child: ButtonTheme(
// //                                                       alignedDropdown: true,
// //                                                       child: DropdownButton<
// //                                                           String>(
// //                                                         isDense: true,
// //                                                         hint: Text(
// //                                                           // "Select Doctor",
// //                                                           value
// //                                                               .doctorList
// //                                                               .data!
// //                                                               .data![0]
// //                                                               .doctorName
// //                                                               .toString(),
// //                                                           style: TextStyle(
// //                                                               fontSize: 20,
// //                                                               fontWeight:
// //                                                                   FontWeight
// //                                                                       .w500,
// //                                                               color:
// //                                                                   Colors.black),
// //                                                         ),
// //                                                         value:
// //                                                             selectedDocotrId =
// //                                                                 value
// //                                                                     .doctorList
// //                                                                     .data!
// //                                                                     .data![0]
// //                                                                     .doctorId
// //                                                                     .toString(),
// //                                                         onChanged:
// //                                                             (String? newValue) {
// //                                                           setState(() {
// //                                                             selectedDocotrId =
// //                                                                 newValue!;
// //                                                           });

// //                                                           print(
// //                                                               selectedDocotrId);
// //                                                         },
// //                                                         items: value.doctorList
// //                                                             .data!.data!
// //                                                             .map((map) {
// //                                                           return new DropdownMenuItem<
// //                                                               String>(
// //                                                             value: map.doctorId
// //                                                                 .toString(),
// //                                                             // value: _mySelection,
// //                                                             child: Row(
// //                                                               mainAxisAlignment:
// //                                                                   MainAxisAlignment
// //                                                                       .start,
// //                                                               children: <
// //                                                                   Widget>[
// //                                                                 Container(
// //                                                                     child: Text(
// //                                                                   map.doctorName
// //                                                                       .toString(),
// //                                                                   style: TextStyle(
// //                                                                       fontSize:
// //                                                                           14.sp,
// //                                                                       fontWeight:
// //                                                                           FontWeight
// //                                                                               .w500),
// //                                                                   textAlign:
// //                                                                       TextAlign
// //                                                                           .start,
// //                                                                 )),
// //                                                               ],
// //                                                             ),
// //                                                           );
// //                                                         }).toList(),
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 SizedBox(height: 20),
// //                                               ],
// //                                             ),
// //                                           ),
// //                                           Container(
// //                                             decoration: BoxDecoration(
// //                                                 color: Color(0xFFFD5722),
// //                                                 borderRadius: BorderRadius.only(
// //                                                     topRight:
// //                                                         Radius.circular(8),
// //                                                     bottomRight:
// //                                                         Radius.circular(8))),
// //                                             height: 12.h,
// //                                             width: 16.w,
// //                                             child: Icon(
// //                                               Icons.refresh_outlined,
// //                                               color: Colors.white,
// //                                               size: 30,
// //                                             ),
// //                                           ),
// //                                           // isLoading ? Loader() : Container(),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                         ),
// //                       ),
// //                       isLoading ? Loader() : Container(),
// //                     ],
// //                   );
// //               }
// //             },
// //           )),
// //     );
// //   }
// // }

// import 'dart:async';
// import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import '../../Res/Components/Appbar/payment_widget.dart';
// import '../../Res/Components/loader.dart';
// import '../../Res/colors.dart';
// import '../../View_Model/Book_View_Model/bookAppointment_view_model.dart';
// import '../../View_Model/Services/SharePreference/SharePreference.dart';
// import '../../View_Model/Settings_View_Model/settings_view_model.dart';
// import '../../data/response/status.dart';
// import '../../res/components/appbar/axonimage_appbar-widget.dart';
// import '../../res/components/appbar/screen_name_widget.dart';
// import '../../res/components/appbar/settings_widget.dart';
// import '../../res/components/appbar/whatsapp_widget.dart';

// class BookApointmentScreen extends StatefulWidget {
//   const BookApointmentScreen({super.key});

//   @override
//   State<BookApointmentScreen> createState() => _BookApointmentScreenState();
// }

// class _BookApointmentScreenState extends State<BookApointmentScreen> {
//   UserPreferences userPreference = UserPreferences();
//   DoctorListViewmodel doctorListViewmodel = DoctorListViewmodel();
//   SettingsViewModel settingsViewModel = SettingsViewModel();
//   BookAppointmentViewModel bookAppointmentViewModel =
//       BookAppointmentViewModel();
//   late String number;

//   late String selectedDocotrId;

//   bool isLoading = false;
//   var mobile;
//   late String token;
//   late String deviceId;
//   String displaySelectAppointmentDate = 'Select Appointment Date';
//   String displayDate = '';
//   String appointmentDate = '';
//   String? DelayMinute;
//   String displayTimeSlot = '';
//   String? displaytimingId;
//   String displayPatientName = 'Select Patient';
//   String? displayBirthDate;
//   String? displayGender;
//   String CaseNo = "";
//   String PatType = "";

//   // List doctorData = [];
//   // List customerData = [];

//   @override
//   void initState() {
//     userPreference.getMobile().then((value1) {
//       setState(() {
//         mobile = value1;
//       });
//     });

//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//       });
//     });
//     userPreference.getDeviceId().then((value) {
//       setState(() {
//         deviceId = value!;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('ParthParthParth');
//     doctorListViewmodel =
//         Provider.of<DoctorListViewmodel>(context, listen: false);
//     settingsViewModel = Provider.of<SettingsViewModel>(context, listen: false);
//     bookAppointmentViewModel =
//         Provider.of<BookAppointmentViewModel>(context, listen: false);
//     Timer(Duration(microseconds: 20), () {
//       doctorListViewmodel.fetchDoctorListApi(token);
//       settingsViewModel.fetchDoctorDetailsListApi(token);
//     });
//     return Scaffold(
//       backgroundColor: BackgroundColor,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: false,
//           backgroundColor: Color(0xffffffff),
//           elevation: 0,
//           title: Padding(
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AxonIconForAppBarrWidget(),
//                 ScreenNameWidget(
//                   title: 'Book Appointment',
//                 ),
//                 WhatsappWidget(),
//                 PaymentWidget(),
//                 SettingsWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: ChangeNotifierProvider<DoctorListViewmodel>.value(
//           value: doctorListViewmodel,
//           child: Consumer<DoctorListViewmodel>(
//             builder: (context, value, child) {
//               switch (value.doctorList.status!) {
//                 case Status.LOADING:
//                   return Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return Center(
//                       child: Text(value.doctorList.message.toString()));
//                 case Status.COMPLETED:
//                   return Stack(
//                     children: [
//                       SingleChildScrollView(
//                         // physics: BouncingScrollPhysics(),
//                         child: Padding(
//                           padding: EdgeInsets.all(0),
//                           child: isLoading
//                               ? isLoading
//                                   ? Container()
//                                   : Container()
//                               : Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       margin:
//                                           EdgeInsets.only(left: 8, right: 8),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Container(
//                                             height: 12.h,
//                                             width: 78.w,
//                                             padding: EdgeInsets.all(8),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   'Provider',
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color:
//                                                           Colors.grey.shade700),
//                                                 ),
//                                                 SizedBox(height: 1.h),
//                                                 Container(
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   child:
//                                                       DropdownButtonHideUnderline(
//                                                     child: ButtonTheme(
//                                                       alignedDropdown: true,
//                                                       child: DropdownButton<
//                                                           String>(
//                                                         isDense: true,
//                                                         hint: Text(
//                                                           // "Select Doctor",
//                                                           value
//                                                               .doctorList
//                                                               .data!
//                                                               .data![0]
//                                                               .doctorName
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                               fontSize: 20,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               color:
//                                                                   Colors.black),
//                                                         ),
//                                                         value:
//                                                             selectedDocotrId =
//                                                                 value
//                                                                     .doctorList
//                                                                     .data!
//                                                                     .data![0]
//                                                                     .doctorId
//                                                                     .toString(),
//                                                         onChanged:
//                                                             (String? newValue) {
//                                                           // setState(() {
//                                                           selectedDocotrId =
//                                                               newValue!;
//                                                           // });

//                                                           print(
//                                                               selectedDocotrId);
//                                                         },
//                                                         items: value.doctorList
//                                                             .data!.data!
//                                                             .map((map) {
//                                                           return new DropdownMenuItem<
//                                                               String>(
//                                                             value: map.doctorId
//                                                                 .toString(),
//                                                             // value: _mySelection,
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .start,
//                                                               children: <
//                                                                   Widget>[
//                                                                 Container(
//                                                                     child: Text(
//                                                                   map.doctorName
//                                                                       .toString(),
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           14.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .start,
//                                                                 )),
//                                                               ],
//                                                             ),
//                                                           );
//                                                         }).toList(),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 20),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Color(0xFFFD5722),
//                                                 borderRadius: BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(8),
//                                                     bottomRight:
//                                                         Radius.circular(8))),
//                                             height: 12.h,
//                                             width: 16.w,
//                                             child: Icon(
//                                               Icons.refresh_outlined,
//                                               color: Colors.white,
//                                               size: 30,
//                                             ),
//                                           ),
//                                           // isLoading ? Loader() : Container(),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                         ),
//                       ),
//                       isLoading ? Loader() : Container(),
//                     ],
//                   );
//               }
//             },
//           )),
//     );
//   }
// }

// class ImageSkelton extends StatelessWidget {
//   const ImageSkelton({Key? key, this.height, this.width}) : super(key: key);

//   final double? height, width;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.04),
//         borderRadius: BorderRadius.all(
//           Radius.circular(16),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Res/Components/Appbar/payment_widget.dart';
import '../../Res/Components/loader.dart';
import '../../Res/colors.dart';
import '../../View_Model/Book_View_Model/bookAppointment_view_model.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';
// Import other packages and files

class BookApointmentScreen extends StatefulWidget {
  const BookApointmentScreen({Key? key}) : super(key: key);

  @override
  State<BookApointmentScreen> createState() => _BookApointmentScreenState();
}

class _BookApointmentScreenState extends State<BookApointmentScreen> {
  bool isFirstLoad = true; // Flag to track the first API call
  late Future<void> fetchDataFuture;
  late String selectedDocotrId;
  bool isLoading = false;
  late String token;

  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    super.initState();
    fetchDataFuture = fetchData(); // Call the API only once
  }

  Future<void> fetchData() async {
    final doctorListViewmodel =
        Provider.of<DoctorListViewmodel>(context, listen: false);
    if (!doctorListViewmodel.loading) {
      doctorListViewmodel.setLoading(true);
      doctorListViewmodel
          .fetchDoctorListApi('68cb311f-585a-4e86-8e89-06edf1814080');
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorListViewmodel = Provider.of<DoctorListViewmodel>(context);
    final settingsViewModel = Provider.of<SettingsViewModel>(context);
    final bookAppointmentViewModel =
        Provider.of<BookAppointmentViewModel>(context);

    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AxonIconForAppBarrWidget(),
                ScreenNameWidget(
                  title: 'Book Appointment',
                ),
                WhatsappWidget(),
                PaymentWidget(),
                SettingsWidget(),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          } else {
            // Render the UI with the fetched data
            return ChangeNotifierProvider<DoctorListViewmodel>.value(
              value: doctorListViewmodel,
              child: Consumer<DoctorListViewmodel>(
                builder: (context, value, child) {
                  switch (value.doctorList.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.doctorList.message.toString()));
                    case Status.COMPLETED:
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: isLoading
                                  ? isLoading
                                      ? Container()
                                      : Container()
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          margin: EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                height: 12.h,
                                                width: 78.w,
                                                padding: EdgeInsets.all(8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Provider',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors
                                                              .grey.shade700),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: ButtonTheme(
                                                          alignedDropdown: true,
                                                          child: DropdownButton<
                                                              String>(
                                                            isDense: true,
                                                            hint: Text(
                                                              // "Select Doctor",
                                                              value
                                                                  .doctorList
                                                                  .data!
                                                                  .data![0]
                                                                  .doctorName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            value: selectedDocotrId =
                                                                value
                                                                    .doctorList
                                                                    .data!
                                                                    .data![0]
                                                                    .doctorId
                                                                    .toString(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              selectedDocotrId =
                                                                  newValue!;
                                                              print(
                                                                  selectedDocotrId);
                                                            },
                                                            items: value
                                                                .doctorList
                                                                .data!
                                                                .data!
                                                                .map((map) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: map
                                                                    .doctorId
                                                                    .toString(),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        child:
                                                                            Text(
                                                                      map.doctorName
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    )),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFFD5722),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8))),
                                                height: 12.h,
                                                width: 16.w,
                                                child: Icon(
                                                  Icons.refresh_outlined,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          isLoading ? Loader() : Container(),
                        ],
                      );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

// Other classes and widgets
