import 'dart:async';
import 'dart:convert';

import 'package:axonweb/Provider/backButton_provider.dart';
import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
import 'package:axonweb/View_Model/Book_View_Model/advanceBookAppointment_view_model.dart';
import 'package:axonweb/View_Model/Book_View_Model/bookAppointment_view_model.dart';
import 'package:axonweb/View_Model/News_View_Model/notification_services.dart';
import 'package:axonweb/View_Model/Payment_View_Model/customerPayHead_view_model.dart';
import 'package:axonweb/View_Model/Payment_View_Model/initiatePayment_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Res/Components/loader.dart';
import '../../Res/colors.dart';
import '../../Utils/utils.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';
import '../SelectAppointmentDate/selectappointmentdate_screen.dart';
import '../SelectPateint/selectpateint_screen.dart';

class BookApointmentScreen extends StatefulWidget {
  const BookApointmentScreen({super.key});

  @override
  State<BookApointmentScreen> createState() => _BookApointmentScreenState();
}

class _BookApointmentScreenState extends State<BookApointmentScreen> {
  ButtonProvider buttonProvider = ButtonProvider();
  UserPreferences userPreference = UserPreferences();
  DoctorListViewmodel doctorListViewmodel = DoctorListViewmodel();
  SettingsViewModel settingsViewModel = SettingsViewModel();
  BookAppointmentViewModel bookAppointmentViewModel =
      BookAppointmentViewModel();
  String? number;
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
  bool? isSubscriptionExpired;
  NotificationServices notificationServices = NotificationServices();

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
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    final buttonProvider = Provider.of<ButtonProvider>(context, listen: false);
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
    final buttonProvider = Provider.of<ButtonProvider>(context, listen: false);

    final bookAppointmentViewModel =
        Provider.of<BookAppointmentViewModel>(context);
    final doctorListViewmodel =
        Provider.of<DoctorListViewmodel>(context, listen: false);
    final settingsViewModel =
        Provider.of<SettingsViewModel>(context, listen: false);

    Future refresh() async {
      doctorListViewmodel.fetchDoctorListApi(token);
      settingsViewModel.fetchDoctorDetailsListApi(token);
    }

    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
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
                        return AppBar(
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
                                  title: '  Book Appointment',
                                ),
                                Container(
                                  margin: EdgeInsets.all(6),
                                  height: 4.h,
                                  width: 5.h,
                                ),
                                SettingsWidget(),
                              ],
                            ),
                          ),
                        );
                      case Status.ERROR:
                        return AppBar(
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
                                  title: '  Book Appointment',
                                ),
                                Container(
                                  margin: EdgeInsets.all(6),
                                  height: 4.h,
                                  width: 5.h,
                                ),
                                SettingsWidget(),
                              ],
                            ),
                          ),
                        );
                      case Status.COMPLETED:
                        return AppBar(
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
                                  title: ' Book Appointment',
                                ),
                                value.doctorDetailsList.data!.data![0]
                                            .whatsapplink
                                            .toString() ==
                                        "null"
                                    ? Container()
                                    : WhatsappWidget(),
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
                        return RefreshIndicator(
                          onRefresh: refresh,
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Container(
                                    height: 74.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Center(
                                          child: Image.asset(
                                            'images/loading.png',
                                            height: 20.h,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Center(
                                          child: Text(
                                            value.doctorList.message.toString(),
                                            style: TextStyle(
                                                fontSize: titleFontSize,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                      case Status.COMPLETED:
                        selectedDocotrId =
                            value.doctorList.data!.data![0].doctorId.toString();
                        selectedDoctor = value
                            .doctorList.data!.data![0].doctorName
                            .toString();
                        void _showDoctorSelectionAlertDialog(
                            BuildContext context,
                            DoctorNameProvider doctorNameProvider) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              DoctorListViewmodel value =
                                  Provider.of<DoctorListViewmodel>(context);

                              return AlertDialog(
                                title: Text(
                                  'Select a Doctor',
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                content: Container(
                                  height: value.doctorList.data!.data!.length *
                                      50.0, // Adjust the height based on item count
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    itemCount:
                                        value.doctorList.data!.data!.length,
                                    itemBuilder: (context, index) {
                                      var doctor =
                                          value.doctorList.data!.data![index];
                                      return ListTile(
                                        title: Text(
                                          doctor.doctorName.toString(),
                                          style: TextStyle(
                                              fontSize: subTitleFontSize),
                                        ),
                                        onTap: () {
                                          selectedDocotrId =
                                              doctor.doctorId.toString();
                                          if (kDebugMode) {
                                            if (kDebugMode) {
                                              print(
                                                  'buttonProvider ${buttonProvider}');
                                            }
                                          }
                                          selectedDoctor =
                                              doctor.doctorName.toString();
                                          doctorNameProvider.updateTextValues(
                                            '${doctor.doctorName}',
                                            '${doctor.doctorId}',
                                          );

                                          // Close the dialog
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }

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
                                                  isSubscriptionExpired = value
                                                      .doctorDetailsList
                                                      .data!
                                                      .data![0]
                                                      .isSubscriptionExpired;
                                                  return Stack(
                                                    children: [
                                                      value
                                                                  .doctorDetailsList
                                                                  .data!
                                                                  .data![0]
                                                                  .logoImageURL
                                                                  .toString() !=
                                                              "null"
                                                          ? Container(
                                                              height: 26.h,
                                                              width: 100.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      MemoryImage(
                                                                    base64Decode(
                                                                      value
                                                                          .doctorDetailsList
                                                                          .data!
                                                                          .data![
                                                                              0]
                                                                          .logoImageURL
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 26.h,
                                                              width: 100.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      'https://www.axonweb.in/MyResource/CustomerLogo/no-image.png'),
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                              padding: EdgeInsets
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
                                                                                descriptionFontSize,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
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
                                                                                descriptionFontSize,
                                                                            color:
                                                                                Colors.white,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      number == null ||
                                                                              number ==
                                                                                  ''
                                                                          ? Utils.flushBarErrorMessage(
                                                                              "MobileNo Not Available",
                                                                              Duration(seconds: 2),
                                                                              context)
                                                                          : launch('tel://$number');
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
                                                        '   Doctor',
                                                        style: TextStyle(
                                                            fontSize:
                                                                subTitleFontSize,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors
                                                                .grey.shade700),
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Consumer<
                                                          DoctorNameProvider>(
                                                        builder: (context,
                                                            doctorNameProvider,
                                                            _) {
                                                          if (value.doctorList
                                                                      .data !=
                                                                  null &&
                                                              value
                                                                  .doctorList
                                                                  .data!
                                                                  .data!
                                                                  .isNotEmpty) {
                                                            var firstDoctor =
                                                                value
                                                                    .doctorList
                                                                    .data!
                                                                    .data!
                                                                    .first;
                                                            if (doctorNameProvider
                                                                .doctorName
                                                                .isEmpty) {
                                                              doctorNameProvider
                                                                  .updateTextValues(
                                                                '${firstDoctor.doctorName}',
                                                                '${firstDoctor.doctorId}',
                                                              );
                                                              selectedDoctor =
                                                                  firstDoctor
                                                                      .doctorName
                                                                      .toString();
                                                            }
                                                          }

                                                          return InkWell(
                                                            onTap: () {
                                                              _showDoctorSelectionAlertDialog(
                                                                  context,
                                                                  doctorNameProvider);
                                                            },
                                                            child: SizerUtil
                                                                        .deviceType ==
                                                                    DeviceType
                                                                        .mobile
                                                                ? Container(
                                                                    height: 5.h,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              60.w,
                                                                          child:
                                                                              Text(
                                                                            "   ${selectedDoctor}",
                                                                            style:
                                                                                TextStyle(fontSize: subTitleFontSize, fontWeight: FontWeight.w500),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            child:
                                                                                Icon(Icons.arrow_drop_down)),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 5.h,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              68.w,
                                                                          child:
                                                                              Text(
                                                                            "   ${selectedDoctor}",
                                                                            style:
                                                                                TextStyle(fontSize: descriptionFontSize, fontWeight: FontWeight.w500),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            child:
                                                                                Icon(Icons.arrow_drop_down)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                          );
                                                        },
                                                      )
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
                                              if (kDebugMode) {
                                                print(
                                                    'selectedDoctor ${selectedDocotrId}');
                                              }

                                              selectedDocotrId != "null"
                                                  ? _navigateDateAndTimeSelaction(
                                                      context)
                                                  : Utils.flushBarErrorMessage(
                                                      "Please Select a Doctor",
                                                      Duration(seconds: 2),
                                                      context);
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
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            titleFontSize,
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
                                                                        fontSize:
                                                                            subTitleFontSize,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade700),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        1.h),
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
                                                                                subTitleFontSize,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.grey.shade700),
                                                                      ),
                                                                      Text(
                                                                        appointmentDate,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                subTitleFontSize,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        0.8.h),
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
                                                                                subTitleFontSize,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.grey.shade700),
                                                                      ),
                                                                      Text(
                                                                        displayTimeSlot,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                descriptionFontSize,
                                                                            fontWeight:
                                                                                FontWeight.w500),
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
                                                                      titleFontSize,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                                                        Utils.flushBarErrorMessage(
                                                            "Please Select Appointment Date",
                                                            Duration(
                                                                seconds: 2),
                                                            context);
                                                      } else if (displayPatientName ==
                                                          'Select Patient') {
                                                        Utils.flushBarErrorMessage(
                                                            "Please Select Patient",
                                                            Duration(
                                                                seconds: 2),
                                                            context);
                                                      } else if (isSubscriptionExpired ==
                                                          true) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Center(
                                                                  child: Text(
                                                                    'Alert!',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            titleFontSize,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                content: Text(
                                                                  " Oops Sorry! Operation cannot be performed at this moment. Please contact your doctor to use this feature!",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          subTitleFontSize),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                actions: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                    width: 80.w,
                                                                    child:
                                                                        ElevatedButton(
                                                                      child:
                                                                          Text(
                                                                        'OK',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                titleFontSize,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            });
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
                                                              return PaymentSheet(
                                                                  arguments:
                                                                      data);
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
                                                                    subTitleFontSize),
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
                                                        if (kDebugMode) {
                                                          print(
                                                              'buttonProvider ${buttonProvider}');
                                                        }

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
                                                          fontSize:
                                                              subTitleFontSize),
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
    if (kDebugMode) {
      print('selectedDocotrId ${selectedDocotrId}');
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelectAppointmentDateScreen(
                selectedDocotrId: selectedDocotrId,
              )),
    );

    if (kDebugMode) {
      print('displayDate ${result[0]}');
      print('displayTimeSlot ${result[1]}');
      print('displaytimingId ${result[2]}');
      print('DelayMinute ${result[3]}');
    }
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
    if (kDebugMode) {
      print('displayPatientName ${result[0]}');
      print('displayBirthDate ${result[1]}');
      print('displayGender ${result[2]}');
      print('CaseNo ${result[3]}');
      print('PatType ${result[4]}');
    }

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

class PaymentSheet extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const PaymentSheet({Key? key, required this.arguments}) : super(key: key);

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  String? genderValue;
  final formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  bool agree = false;
  final FocusNode _nodeAmount = FocusNode();
  final FocusNode _nodeEmail = FocusNode();
  TextEditingController strAmount = TextEditingController();
  TextEditingController strEmail = TextEditingController();
  late String token;
  late String mobile;
  late String name;
  late String letId;

  int? amount;
  double? amountFloat;
  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
  );

  UserPreferences userPreference = UserPreferences();
  String? selectedPayHeadIndex;

  CustomerPayHeadViewmodel customerPayHeadViewmodel =
      CustomerPayHeadViewmodel();

  InitiatePaymentViewModel initiatePaymentViewModel =
      InitiatePaymentViewModel();
  AdvanceBookAppointmentViewModel advanceBookAppointmentViewModel =
      AdvanceBookAppointmentViewModel();
  SettingsViewModel settingsViewModel = SettingsViewModel();

  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    userPreference.getMobile().then((value) {
      setState(() {
        mobile = value!;
      });
    });
    userPreference.getName().then((value) {
      setState(() {
        name = value!;
      });
    });
    userPreference.getletId().then((value) {
      setState(() {
        letId = value!;
      });
    });

    super.initState();
    Timer(Duration(microseconds: 20), () {
      customerPayHeadViewmodel.fetchCustomerPayHeadListApi(token.toString());
    });
  }

  void makePayment() async {
    final advanceBookAppointmentViewModel =
        Provider.of<AdvanceBookAppointmentViewModel>(context, listen: false);
    _nodeAmount.unfocus();
    _nodeEmail.unfocus();
    if (kDebugMode) {
      print('arguments');
      print(widget.arguments['CaseNo']);
      print(widget.arguments['Gender']);
      print(widget.arguments['PatType']);
      print(widget.arguments['ApptDate']);
      print(widget.arguments['DeviceId']);
      print(widget.arguments['DoctorId']);
      print(widget.arguments['TimingId']);
      print(name);
      print(mobile);
      print(strEmail.text.toString());
      print(token.toString());
      print(selectedPayHeadIndex.toString());
      print(amount.toString());
      print('arguments');
    }

    Map<String, dynamic> data = {
      "CaseNo": widget.arguments['CaseNo'],
      "Name": name.toString(),
      "Mobile": mobile.toString(),
      "Email": strEmail.text.toString(),
      "Gender": widget.arguments['Gender'],
      "PatType": widget.arguments['PatType'],
      "ApptDate": widget.arguments['ApptDate'],
      "CustomerToken": token.toString(),
      "DelayMinute": widget.arguments['DelayMinute'],
      "DeviceId": widget.arguments['DeviceId'],
      "DoctorId": widget.arguments['DoctorId'],
      "TimingId": widget.arguments['TimingId'],
      "AppointmentPaymentHead": selectedPayHeadIndex.toString(),
      "Amount": strAmount.text.toString(),
      "LAT": letId.toString(),
    };
    advanceBookAppointmentViewModel.advancebookappointmentapi(data, context);
    advanceBookAppointmentViewModel.setPLoading(true);
  }

  @override
  Widget build(BuildContext context) {
    final advanceBookAppointmentViewModel =
        Provider.of<AdvanceBookAppointmentViewModel>(context);
    settingsViewModel.fetchDoctorDetailsListApi(token.toString());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: 100.h,
        child: DraggableScrollableSheet(
          initialChildSize: 0.84,
          maxChildSize: 0.84,
          minChildSize: 0.84,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              margin: EdgeInsets.only(left: 4.sp, right: 4.sp, bottom: 4.sp),
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: Colors.white,
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Form(
                    key: formKey,
                    onChanged: () => setState(
                        () => _enableBtn = formKey.currentState!.validate()),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.57,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Select Payment Reason',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              ChangeNotifierProvider<CustomerPayHeadViewmodel>(
                                create: (BuildContext context) =>
                                    customerPayHeadViewmodel,
                                child: Consumer<CustomerPayHeadViewmodel>(
                                  builder: (context, value, _) {
                                    switch (value.CustomerPayHeadList.status!) {
                                      case Status.LOADING:
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.ERROR:
                                        return Center(
                                          child: Text(value
                                              .CustomerPayHeadList.message
                                              .toString()),
                                        );
                                      case Status.COMPLETED:
                                        return Container(
                                          width: 90.w,
                                          child: SingleChildScrollView(
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    customerPayHeadViewmodel
                                                        .CustomerPayHeadList
                                                        .data!
                                                        .data!
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            customerPayHeadViewmodel
                                                                .CustomerPayHeadList
                                                                .data!
                                                                .data![index]
                                                                .payHead
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  titleFontSize,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Radio<String>(
                                                            value: customerPayHeadViewmodel
                                                                .CustomerPayHeadList
                                                                .data!
                                                                .data![index]
                                                                .payHead
                                                                .toString(),
                                                            groupValue:
                                                                selectedPayHeadIndex
                                                                    .toString(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedPayHeadIndex =
                                                                    value!;

                                                                String rs = customerPayHeadViewmodel
                                                                    .CustomerPayHeadList
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .defaultAmount
                                                                    .toString();
                                                                amountFloat =
                                                                    double.parse(
                                                                        rs.toString());
                                                                amount =
                                                                    amountFloat!
                                                                        .toInt();

                                                                strAmount.text =
                                                                    amount
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        color: Colors.black,
                                                        height: 1,
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              TextFormField(
                                focusNode: _nodeAmount,
                                controller: strAmount,
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                validator: (value) => value!.isEmpty
                                    ? "Please enter Amount"
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Amount',
                                ),
                              ),
                              TextFormField(
                                focusNode: _nodeEmail,
                                controller: strEmail,
                                keyboardType: TextInputType.text,
                                validator: (value) => value!.isEmpty
                                    ? "Please enter email"
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Email Id',
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: agree,
                                    onChanged: (value) {
                                      setState(() {
                                        agree = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    'I accept  ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: subTitleFontSize,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final url = settingsViewModel
                                          .doctorDetailsList
                                          .data!
                                          .data![0]
                                          .termsLink
                                          .toString();
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      'terms and conditions',
                                      style: TextStyle(
                                        color: Color(0xFFFD5722),
                                        fontSize: subTitleFontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 5.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (selectedPayHeadIndex == null ||
                                            selectedPayHeadIndex == ' ') {
                                          Utils.flushBarErrorMessage(
                                              "Please select PayHead",
                                              Duration(seconds: 2),
                                              context);
                                        } else if (!emailRegex
                                            .hasMatch(strEmail.text)) {
                                          Utils.flushBarErrorMessage(
                                              "Please enter a valid Email address*",
                                              Duration(seconds: 2),
                                              context);
                                        } else if (!agree) {
                                          Utils.flushBarErrorMessage(
                                              "Please select terms & conditions",
                                              Duration(seconds: 2),
                                              context);
                                        } else if (!_enableBtn) {
                                        } else {
                                          advanceBookAppointmentViewModel
                                                  .Ploading
                                              ? null
                                              : makePayment();
                                        }
                                      },
                                      child: advanceBookAppointmentViewModel
                                              .Ploading
                                          ? Container(
                                              height: 2.h,
                                              width: 2.h,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.0,
                                              ))
                                          : Text(
                                              'START PAYMENT',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: subTitleFontSize,
                                                color: Colors.white,
                                              ),
                                            ),
                                      style: ElevatedButton.styleFrom(
                                        primary: _enableBtn
                                            ? Color(0xFFFD5722)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
