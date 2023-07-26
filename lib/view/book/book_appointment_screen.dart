import 'dart:async';
import 'dart:convert';
import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Res/Components/Appbar/payment_widget.dart';
import '../../Res/Components/loader.dart';
import '../../Res/colors.dart';
import '../../Utils/utils.dart';
import '../../View_Model/Book_View_Model/bookAppointment_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';
import '../PaymentHistory/payment_history_screen.dart';
import '../SelectAppointmentDate/selectappointmentdate_screen.dart';
import '../SelectPateint/selectpateint_screen.dart';

class BookApointmentScreen extends StatefulWidget {
  const BookApointmentScreen({super.key});

  @override
  State<BookApointmentScreen> createState() => _BookApointmentScreenState();
}

class _BookApointmentScreenState extends State<BookApointmentScreen> {
  UserPreferences userPreference = UserPreferences();
  DoctorListViewmodel doctorListViewmodel = DoctorListViewmodel();
  SettingsViewModel settingsViewModel = SettingsViewModel();
  BookAppointmentViewModel bookAppointmentViewModel =
      BookAppointmentViewModel();
  late String number;
  late String selectedDocotrId = '0';
  late String selectedDoctor = ' ';
  bool isLoading = false;
  var mobile;
  late String token;
  late String deviceId;
  String displaySelectAppointmentDate = 'Select Appointment Date';
  String displayDate = '';
  String appointmentDate = '';
  String? DelayMinute;
  String displayTimeSlot = '';
  String? displaytimingId;
  String displayPatientName = 'Select Patient';
  String? displayBirthDate;
  String? displayGender;
  String CaseNo = "";
  String PatType = "";

  bool isFirstLoad = true; // Flag to track the first API call
  late Future<void> fetchDataFuture;

  @override
  void initState() {
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1;
      });
    });

    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    userPreference.getDeviceId().then((value) {
      setState(() {
        deviceId = value!;
      });
    });
    super.initState();

    // final doctorListViewmodel =
    //     Provider.of<DoctorListViewmodel>(context, listen: false);
    // final settingsViewModel =
    //     Provider.of<SettingsViewModel>(context, listen: false);
    // final bookAppointmentViewModel =
    //     Provider.of<BookAppointmentViewModel>(context, listen: false);
    // Timer(Duration(microseconds: 20), () {
    //   // doctorListViewmodel.fetchDoctorListApi(token);
    //   // settingsViewModel.fetchDoctorDetailsListApi(token);
    // });
    fetchDataFuture = fetchData(); // Call the API only once
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final doctorListViewmodel =
          Provider.of<DoctorListViewmodel>(context, listen: false);

      if (!doctorListViewmodel.loading) {
        final doctorNameProvider =
            Provider.of<DoctorNameProvider>(context, listen: false);

        doctorNameProvider.resetData();
        doctorListViewmodel.setLoading(true);

        doctorListViewmodel.fetchDoctorListApi(token);
      }
      final settingsViewModel =
          Provider.of<SettingsViewModel>(context, listen: false);

      if (!settingsViewModel.loading) {
        settingsViewModel.setLoading(true);

        settingsViewModel.fetchDoctorDetailsListApi(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ParthParthParth');
    final bookAppointmentViewModel =
        Provider.of<BookAppointmentViewModel>(context);
    final doctorListViewmodel =
        Provider.of<DoctorListViewmodel>(context, listen: false);
    final settingsViewModel =
        Provider.of<SettingsViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: FutureBuilder<void>(
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
              return ChangeNotifierProvider<SettingsViewModel>.value(
                value: settingsViewModel,
                child: Consumer<SettingsViewModel>(
                  builder: (context, value, _) {
                    switch (value.doctorDetailsList.status!) {
                      case Status.LOADING:
                        return Center(child: Container());
                      case Status.ERROR:
                        return Center(
                            child: Text(
                                value.doctorDetailsList.message.toString()));
                      case Status.COMPLETED:
                        return settingsViewModel.doctorDetailsList.data!
                                    .data![0].paymentGatewayEnabled
                                    .toString() ==
                                'true'
                            ? AppBar(
                                automaticallyImplyLeading: false,
                                centerTitle: false,
                                backgroundColor: Color(0xffffffff),
                                elevation: 0,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AxonIconForAppBarrWidget(),
                                      ScreenNameWidget(
                                        title: '  Book Appointment',
                                      ),
                                      WhatsappWidget(),
                                      PaymentWidget(),
                                      SettingsWidget(),
                                    ],
                                  ),
                                ),
                              )
                            : AppBar(
                                automaticallyImplyLeading: false,
                                centerTitle: false,
                                backgroundColor: Color(0xffffffff),
                                elevation: 0,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AxonIconForAppBarrWidget(),
                                      ScreenNameWidget(
                                        title: '  Book Appointment',
                                      ),
                                      WhatsappWidget(),
                                      SettingsWidget(),
                                    ],
                                  ),
                                ),
                              );
                    }
                  },
                ),
              );
            }
          },
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
                        print('object');
                        selectedDocotrId =
                            value.doctorList.data!.data![0].doctorId.toString();
                        return Stack(
                          children: [
                            SingleChildScrollView(
                              // physics: BouncingScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: isLoading
                                    ? isLoading
                                        ? Container()
                                        : Container()
                                    : Column(
                                        children: [
                                          ChangeNotifierProvider<
                                              SettingsViewModel>.value(
                                            value: settingsViewModel,
                                            child: Consumer<SettingsViewModel>(
                                                builder:
                                                    (context, value, child) {
                                              switch (value
                                                  .doctorDetailsList.status!) {
                                                case Status.LOADING:
                                                  return ImageSkelton(
                                                    height: 26.h,
                                                    width: 100.w,
                                                  );

                                                // Center(
                                                //     child:
                                                //         CircularProgressIndicator());
                                                case Status.ERROR:
                                                  return Center(
                                                      child: Text(value
                                                          .doctorDetailsList
                                                          .message
                                                          .toString()));
                                                case Status.COMPLETED:
                                                  number = value
                                                      .doctorDetailsList
                                                      .data!
                                                      .data![0]
                                                      .customerContact
                                                      .toString();
                                                  return Stack(
                                                    children: [
                                                      Container(
                                                        height: 26.h,
                                                        width: 100.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: MemoryImage(
                                                              base64Decode(
                                                                value
                                                                    .doctorDetailsList
                                                                    .data!
                                                                    .data![0]
                                                                    .logoImageURL
                                                                    .toString(),
                                                              ),
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 3,
                                                        left: 0,
                                                        right: 0,
                                                        child:
                                                            Transform.translate(
                                                          offset: Offset(0, 4),
                                                          child: Container(
                                                            height: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment.bottomCenter,
                                                                  colors: [
                                                                    Colors
                                                                        .transparent,
                                                                    Colors.grey
                                                                        .shade700
                                                                  ]),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 14,
                                                                      top: 8,
                                                                      bottom: 8,
                                                                      right: 8),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 70.w,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          value
                                                                              .doctorDetailsList
                                                                              .data!
                                                                              .data![0]
                                                                              .customerName
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10.sp,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          value
                                                                              .doctorDetailsList
                                                                              .data!
                                                                              .data![0]
                                                                              .customerAddress
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10.sp,
                                                                            color:
                                                                                Colors.white,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      number == null ||
                                                                              number ==
                                                                                  ''
                                                                          ? Utils.snackBar(
                                                                              'MobileNo Not Available',
                                                                              context)
                                                                          : launch(
                                                                              'tel://$number');
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          15.w,
                                                                      height:
                                                                          5.h,
                                                                      child: Image
                                                                          .asset(
                                                                              "images/phone-call.png"),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                              }
                                            }),
                                          ),
                                          SizedBox(
                                            height: 2.h,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  height: 12.h,
                                                  width: 78.w,
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '     Provider',
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors
                                                                .grey.shade700),
                                                      ),
                                                      SizedBox(height: 2.h),
                                                      Consumer<
                                                              DoctorNameProvider>(
                                                          builder: (context,
                                                              doctorNameProvider,
                                                              _) {
                                                        // print('qqqqqqq');
                                                        // print(
                                                        //     'provider ${selectedDoctor}');
                                                        // print(
                                                        //     'provider ${selectedDocotrId}');
                                                        return Container(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                            child: ButtonTheme(
                                                              alignedDropdown:
                                                                  true,
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                isDense: true,
                                                                // hint: Text(
                                                                //   "Select Doctor",
                                                                //   style: TextStyle(
                                                                //       fontSize:
                                                                //           15.sp,
                                                                //       fontWeight:
                                                                //           FontWeight
                                                                //               .w500,
                                                                //       color: Colors
                                                                //           .black),
                                                                // ),
                                                                value:
                                                                    selectedDocotrId,
                                                                onChanged: (String?
                                                                    newValue) {
                                                                  selectedDocotrId =
                                                                      newValue!;
                                                                  selectedDoctor = value
                                                                      .doctorList
                                                                      .data!
                                                                      .data!
                                                                      .firstWhere(
                                                                        (doctor) =>
                                                                            doctor.doctorId.toString() ==
                                                                            newValue,
                                                                      )
                                                                      .doctorName
                                                                      .toString();
                                                                  // print(
                                                                  //     selectedDocotrId);
                                                                  // print(
                                                                  //     selectedDoctor);
                                                                  doctorNameProvider
                                                                      .resetData();

                                                                  doctorNameProvider
                                                                      .updateTextValues(
                                                                    '${selectedDoctor}',
                                                                    '${selectedDocotrId}',
                                                                  );
                                                                  print(
                                                                      'updateTextValues');
                                                                  print(
                                                                      'provider ${selectedDoctor}');
                                                                  print(
                                                                      'provider ${selectedDocotrId}');
                                                                },
                                                                items: value
                                                                    .doctorList
                                                                    .data!
                                                                    .data!
                                                                    .map((map) {
                                                                  return new DropdownMenuItem<
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
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w500),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                        )),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      })
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
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                  height: 12.h,
                                                  width: 16.w,
                                                  child: Icon(
                                                    Icons.refresh_outlined,
                                                    color: Colors.white,
                                                    size: 3.5.h,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print(
                                                  'selectedDocotrIdselectedDocotrIdselectedDocotrIdselectedDocotrId');
                                              print(selectedDocotrId);
                                              print('selectedDocotrId');

                                              selectedDocotrId != "null"
                                                  ? _navigateDateAndTimeSelaction(
                                                      context)
                                                  : Utils.snackBar(
                                                      'Please Select a Doctor',
                                                      context);

                                              ;
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 8, right: 8, top: 5),
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 12.h,
                                                    width: 78.w,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8,
                                                              bottom: 8,
                                                              top: 8),
                                                      child: displayDate.isEmpty
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                    height:
                                                                        2.h),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              10),
                                                                  child: Text(
                                                                    displaySelectAppointmentDate,
                                                                    // displayDate,
                                                                    style: TextStyle(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        2.h),
                                                              ],
                                                            )
                                                          : Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                    '   Appointment',
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade700),
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //     height: 1),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              5),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Date   ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: Colors.grey.shade700),
                                                                      ),
                                                                      Text(
                                                                        appointmentDate,
                                                                        // displayDate,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        0.3.h),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Time  ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: Colors.grey.shade700),
                                                                      ),
                                                                      Text(
                                                                        displayTimeSlot,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFD5722),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        8))),
                                                    height: 12.h,
                                                    width: 16.w,
                                                    child: Icon(
                                                      Icons.access_time_rounded,
                                                      color: Colors.white,
                                                      size: 3.5.h,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _navigateNameAndGenderSelaction(
                                                  context);
                                              // Navigator.pushNamed(
                                              //     context, RoutesName.selectPatient);
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 8, right: 8, top: 5),
                                              color: Colors.white,
                                              shadowColor: Colors.white,
                                              elevation: 10,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 12.h,
                                                    width: 78.w,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 77.w,
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 10,
                                                              top: 3.h,
                                                            ),
                                                            child: Text(
                                                              displayPatientName,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          //
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFD5722),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        8))),
                                                    height: 12.h,
                                                    width: 16.w,
                                                    child: Icon(
                                                      Icons.person_outline,
                                                      color: Colors.white,
                                                      size: 3.5.h,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 7.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 5.h,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (displayDate.isEmpty) {
                                                        Utils.snackBar(
                                                            'Please Select Appointment Date',
                                                            context);
                                                      } else if (displayPatientName ==
                                                          'Select Patient') {
                                                        Utils.snackBar(
                                                            'Please Select Patient',
                                                            context);
                                                      } else {
                                                        Map<String, dynamic>
                                                            data = {
                                                          "CaseNo":
                                                              CaseNo.toString(),
                                                          "Name":
                                                              displayPatientName
                                                                  .toString(),
                                                          "Mobile":
                                                              mobile.toString(),
                                                          "Email": "",
                                                          "Gender":
                                                              displayGender
                                                                  .toString(),
                                                          "PatType": PatType
                                                              .toString(),
                                                          "ApptDate":
                                                              displayDate
                                                                  .toString(),
                                                          "CustomerToken":
                                                              token.toString(),
                                                          "DelayMinute":
                                                              DelayMinute
                                                                  .toString(),
                                                          "DeviceId": deviceId,
                                                          "DoctorId":
                                                              selectedDocotrId
                                                                  .toString(),
                                                          "TimingId":
                                                              displaytimingId
                                                                  .toString(),
                                                        };
                                                        userPreference
                                                            .saveUserData(data);

                                                        if (settingsViewModel
                                                                .doctorDetailsList
                                                                .data!
                                                                .data![0]
                                                                .isAdvanceBookingRequired
                                                                .toString() ==
                                                            'true') {
                                                          // Utils.snackBar(
                                                          //     'Appointment Book aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                                          //     context);
                                                          showModalBottomSheet<
                                                              void>(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return PaymentSheet();
                                                            },
                                                          );
                                                        } else {
                                                          bookAppointmentViewModel
                                                              .bookApointmentApi(
                                                                  data,
                                                                  context);
                                                        }

                                                        Timer(
                                                            Duration(
                                                                seconds: 5),
                                                            () {});
                                                      }
                                                    },
                                                    child: bookAppointmentViewModel
                                                            .signUpLoading
                                                        ? Container(
                                                            child: Container(
                                                                child:
                                                                    CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 2.0,
                                                          )))
                                                        : Text(
                                                            'BOOK APPOINTMENT',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    12.sp),
                                                          ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Color(
                                                                    0xFFFD5722)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Container(
                                                  height: 5.h,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        displayDate = '';
                                                        displayTimeSlot = '';
                                                        displaytimingId = '';
                                                        displayPatientName =
                                                            'Select Patient';
                                                        displayBirthDate = '';
                                                        displayGender = '';
                                                      });
                                                    },
                                                    child: Text(
                                                      'RESET',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Color(
                                                                    0xFFFD5722)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 10.h,
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
                ));
          }
        },
      ),
    );
  }

  _navigateDateAndTimeSelaction(BuildContext context) async {
    print('selectedDocotrId');
    print(selectedDocotrId);
    print('selectedDocotrId');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelectAppointmentDateScreen(
                selectedDocotrId: selectedDocotrId,
              )),
    );
    print(result[0]);
    print(result[1]);
    print(result[2]);
    print(result[3]);

    if (result != null) {
      setState(() {
        displayDate = result[0];
        displayTimeSlot = result[1];
        displaytimingId = result[2];
        DelayMinute = result[3];

        var inputDate = DateTime.parse(displayDate.toString());
        var outputFormat5 = DateFormat('d-MMM-yyyy');
        var outputDate5 = outputFormat5.format(inputDate);
        appointmentDate = outputDate5;
      });
    }
  }

  _navigateNameAndGenderSelaction(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectPatientScreen()),
    );
    print(result[0]);
    print(result[1]);
    print(result[2]);
    print(result[3]);
    print(result[4]);

    if (result != null) {
      setState(() {
        displayPatientName = result[0];
        displayBirthDate = result[1];
        displayGender = result[2];
        CaseNo = result[3];
        PatType = result[4];
      });
    }
  }
}

class ImageSkelton extends StatelessWidget {
  const ImageSkelton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}
