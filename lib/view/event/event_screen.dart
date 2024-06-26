import 'dart:async';
import 'dart:convert';

import 'package:axonweb/Provider/backButton_provider.dart';
import 'package:axonweb/Utils/utils.dart';
import 'package:axonweb/View/NevigationBar/my_navigationbar.dart';
import 'package:axonweb/View_Model/News_View_Model/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Res/colors.dart';
import '../../Utils/routes/routes_name.dart';
import '../../View_Model/Event_View_Model/event_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  UserPreferences userPreference = UserPreferences();
  late String token;
  late String deviceId;
  EventListViewmodel eventListViewmodel = EventListViewmodel();
  ButtonProvider buttonProvider = ButtonProvider();
  NotificationServices notificationServices = NotificationServices();

  late Future<void> fetchDataFuture;
  String? messageCode;
  @override
  void initState() {
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
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    final buttonProvider = Provider.of<ButtonProvider>(context, listen: false);
    fetchDataFuture = fetchData(); // Call the API only once
  }

  createAppointmentListContainer(BuildContext context, int itemIndex) {
    String date =
        eventListViewmodel.EventList.data!.data![itemIndex].apptDate.toString();
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('E d-MMMM-yyyy');
    var outputFormat1 = DateFormat('E, yyyy');
    var outputFormat2 = DateFormat('d MMM');
    var outputFormat3 = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var outputDate1 = outputFormat1.format(inputDate);
    var outputDate2 = outputFormat2.format(inputDate);
    var outputDate3 = outputFormat3.format(inputDate);
    String doctorName = eventListViewmodel
        .EventList.data!.data![itemIndex].doctorName
        .toString();
    String patientName =
        eventListViewmodel.EventList.data!.data![itemIndex].name.toString();
    String status = eventListViewmodel
        .EventList.data!.data![itemIndex].statusText
        .toString();
    String appointmentId = eventListViewmodel
        .EventList.data!.data![itemIndex].appointmentId
        .toString();
    return Column(
      children: [
        InkWell(
          onTap: () {
            Map data = {
              'date': outputDate,
              'doctorName': doctorName,
              'outputDate3': outputDate3,
              'patientName': patientName,
              'status': status,
              'appointmentId': appointmentId,
            };
            status == 'Booked'
                ? Navigator.pushNamed(context, RoutesName.eventDetails,
                    arguments: data)
                : null;
          },
          child: Card(
            margin: EdgeInsets.only(top: 20, left: 18, right: 18),
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 10,
            child: Row(
              children: [
                Container(
                    height: 18.h,
                    width: 25.w,
                    color: status == 'Booked' ? Colors.green : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Text(
                            outputDate1,
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            outputDate2,
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            outputDate3,
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  height: 18.h,
                  width: 63.w,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Doctor  ' +
                                eventListViewmodel
                                    .EventList.data!.data![itemIndex].doctorName
                                    .toString(),
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Container(
                          child: Text(
                            'Patient  ' +
                                eventListViewmodel
                                    .EventList.data!.data![itemIndex].name
                                    .toString(),
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Container(
                          child: Text(
                            'Mobile  ' +
                                eventListViewmodel
                                    .EventList.data!.data![itemIndex].mobile
                                    .toString(),
                            style: TextStyle(
                              fontSize: subTitleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ref No  -',
                                style: TextStyle(
                                  fontSize: subTitleFontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              InkWell(
                                onTap: () {
                                  Map data = {
                                    'date': outputDate,
                                    'doctorName': doctorName,
                                    'outputDate3': outputDate3,
                                    'patientName': patientName,
                                    'status': status,
                                    'appointmentId': appointmentId,
                                  };
                                  status == 'Booked'
                                      ? Navigator.pushNamed(
                                          context, RoutesName.eventDetails,
                                          arguments: data)
                                      : null;
                                },
                                child: Icon(
                                  Icons.info_outline,
                                  size: 3.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final settingsViewModel =
          Provider.of<SettingsViewModel>(context, listen: false);

      settingsViewModel.fetchDoctorDetailsListApi(token);

      eventListViewmodel.fetchEventListApi(
          deviceId.toString(), token.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsViewModel =
        Provider.of<SettingsViewModel>(context, listen: false);
    Future refresh() async {
      Timer(Duration(microseconds: 20), () {
        eventListViewmodel.fetchEventListApi(
            deviceId.toString(), token.toString());
      });
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
                          backgroundColor: Color(0xffffffff),
                          elevation: 0,
                          title: Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AxonIconForAppBarrWidget(),
                                ScreenNameWidget(
                                  title: '  Events',
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
                          backgroundColor: Color(0xffffffff),
                          elevation: 0,
                          title: Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AxonIconForAppBarrWidget(),
                                ScreenNameWidget(
                                  title: '  Events',
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
                          backgroundColor: Color(0xffffffff),
                          elevation: 0,
                          title: Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AxonIconForAppBarrWidget(),
                                ScreenNameWidget(
                                  title: ' Events',
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
            return ChangeNotifierProvider<EventListViewmodel>.value(
                value: eventListViewmodel,
                child: Consumer<EventListViewmodel>(
                  builder: (context, value, _) {
                    switch (value.EventList.status!) {
                      case Status.LOADING:
                        return Center(
                            child: Center(child: CircularProgressIndicator()));
                      case Status.ERROR:
                        if (value.EventList.message !=
                            " No Internet Connection") {
                          final splitedText = value.EventList.message
                              .toString()
                              .split('Invalid request');
                          messageCode =
                              json.decode(splitedText[1])['displayMessage'];
                        }

                        return value.EventList.message ==
                                " No Internet Connection"
                            ? RefreshIndicator(
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
                                                  value.EventList.message
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: titleFontSize,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : AlertDialog(
                                title: Center(
                                  child: Text(
                                    'Alert!',
                                    style: TextStyle(
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                content: Text(
                                  messageCode.toString(),
                                  style: TextStyle(fontSize: subTitleFontSize),
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  SizedBox(
                                    width: 80.w,
                                    child: ElevatedButton(
                                      child: settingsViewModel.loading1
                                          ? Container(
                                              child: Container(
                                                  child:
                                                      CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.0,
                                            )))
                                          : Text(
                                              'OK',
                                              style: TextStyle(
                                                  fontSize: titleFontSize,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      onPressed: () {
                                        settingsViewModel.setLoading1(true);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyNavigationBar(
                                                      indexNumber: 0,
                                                    )));
                                      },
                                    ),
                                  ),
                                ],
                              );

                      case Status.COMPLETED:
                        return eventListViewmodel
                                    .EventList.data!.data!.length !=
                                0
                            ? RefreshIndicator(
                                onRefresh: refresh,
                                child: CustomScrollView(
                                  slivers: [
                                    SliverPadding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      sliver: SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            return createAppointmentListContainer(
                                                context, index);
                                          },
                                          childCount: eventListViewmodel
                                              .EventList.data!.data!.length,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RefreshIndicator(
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
                                              Text(
                                                'Swipe down to refresh page',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: titleFontSize,
                                                  color: Color(0XFF545454),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Center(
                                                child: Image.asset(
                                                  'images/axon.png',
                                                  height: 10.h,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Center(
                                                child: Text(
                                                  'You don\'t have any bookings or upcoming events',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: titleFontSize,
                                                      color: Color(0XFF545454),
                                                      fontWeight:
                                                          FontWeight.w500),
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
                    }
                  },
                ));
          }
        },
      ),
    );
  }
}
