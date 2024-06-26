import 'dart:async';
import 'dart:convert';

import 'package:axonweb/Utils/utils.dart';
import 'package:axonweb/View_Model/News_View_Model/notification_services.dart';
import 'package:axonweb/View_Model/Report_View_Model/report_view_model.dart';
import 'package:axonweb/view/nevigationBar/my_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Res/colors.dart';
import '../../Utils/routes/routes_name.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late String token;
  late String mobile;
  bool isLoading = false;
  late Map<String, dynamic> data3;
  late String data1;
  late Future<void> fetchDataFuture;
  String? reportdate;
  String? messageCode;
  NotificationServices notificationServices = NotificationServices();
  int isPublishedCounter = 0;
  @override
  void initState() {
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1!;
      });
    });

    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    userPreference.getUserData().then((value) {
      setState(() {
        data3 = value!;
      });
    });

    super.initState();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    fetchDataFuture = fetchData(); // Call the API only once
  }

  createNewsListContainer(BuildContext context, int itemIndex) {
    final reportViewmodel =
        Provider.of<ReportViewmodel>(context, listen: false);
    String date =
        reportViewmodel.reportsList.data!.data![itemIndex].visitDate.toString();
    if (isPublishedCounter == 0) {
      reportViewmodel.reportsList.data!.data![itemIndex].isPublished == true
          ? isPublishedCounter = isPublishedCounter + 1
          : null;
    }

    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('E d-MMMM-yyyy');
    var outputFormat1 = DateFormat('E,yyyy');
    var outputFormat2 = DateFormat('d MMM');
    var outputFormat3 = DateFormat('hh:mm a');
    var outputFormat4 = DateFormat('d-MMM-yyyy');
    var outputFormat5 = DateFormat('d-MMM-yyyy, hh:mm a');
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var outputDate1 = outputFormat1.format(inputDate);
    var outputDate2 = outputFormat2.format(inputDate);
    var outputDate3 = outputFormat3.format(inputDate);
    var outputDate4 = outputFormat4.format(inputDate);
    var outputDate5 = outputFormat5.format(inputDate);
    reportdate = outputDate4;

    String displayDate = reportdate.toString() +
        ', ' +
        reportViewmodel.reportsList.data!.data![itemIndex].visitTime.toString();
    return Column(
      children: [
        SizedBox(
          height: 2,
        ),
        isPublishedCounter == 1
            ? reportViewmodel.reportsList.data!.data![itemIndex].isPublished ==
                    true
                ? InkWell(
                    onTap: () {
                      Map reportDetails = {
                        'providerName': reportViewmodel
                            .reportsList.data!.data![itemIndex].providerName
                            .toString(),
                        'patientName': reportViewmodel
                            .reportsList.data!.data![itemIndex].patientName
                            .toString(),
                        'date': displayDate.toString(),
                        'treatment': reportViewmodel
                            .reportsList.data!.data![itemIndex].treatment
                            .toString(),
                      };
                      Navigator.pushNamed(context, RoutesName.reportDetails,
                          arguments: reportDetails);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Doctor: ' +
                                  reportViewmodel.reportsList.data!
                                      .data![itemIndex].providerName
                                      .toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Member: ' +
                                  reportViewmodel.reportsList.data!
                                      .data![itemIndex].patientName
                                      .toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Updated on: ' + displayDate,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                InkWell(
                                  onTap: () {
                                    Map reportDetails = {
                                      'providerName': reportViewmodel
                                          .reportsList
                                          .data!
                                          .data![itemIndex]
                                          .providerName
                                          .toString(),
                                      'patientName': reportViewmodel.reportsList
                                          .data!.data![itemIndex].patientName
                                          .toString(),
                                      'date': displayDate.toString(),
                                      'treatment': reportViewmodel.reportsList
                                          .data!.data![itemIndex].treatment
                                          .toString(),
                                    };
                                    Navigator.pushNamed(
                                        context, RoutesName.reportDetails,
                                        arguments: reportDetails);
                                  },
                                  child: Container(
                                    child: Icon(Icons.info_outline),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  'You don\'t have any recent prescriptions.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      color: Color(0XFF545454),
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
              )
      ],
    );
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final reportViewmodel =
          Provider.of<ReportViewmodel>(context, listen: false);

      reportViewmodel.fetchReportsListApi(token, mobile);

      final settingsViewModel =
          Provider.of<SettingsViewModel>(context, listen: false);

      ;

      settingsViewModel.fetchDoctorDetailsListApi(token);
    });
  }

  Future refresh() async {
    Timer(Duration(microseconds: 20), () {
      final reportViewmodel =
          Provider.of<ReportViewmodel>(context, listen: false);
      reportViewmodel.fetchReportsListApi(token, mobile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportViewmodel =
        Provider.of<ReportViewmodel>(context, listen: false);
    final settingsViewModel =
        Provider.of<SettingsViewModel>(context, listen: false);
    Future refresh() async {
      Timer(Duration(microseconds: 20), () {
        reportViewmodel.fetchReportsListApi(token, mobile);
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
                                  title: '  Recent Prescription',
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
                                  title: '  Recent Prescription',
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
                                  title: ' Recent Prescription',
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
      body: ChangeNotifierProvider<ReportViewmodel>.value(
        value: reportViewmodel,
        child: Consumer<ReportViewmodel>(
          builder: (context, value, _) {
            switch (value.reportsList.status!) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                if (value.reportsList.message != " No Internet Connection") {
                  final splitedText = value.reportsList.message
                      .toString()
                      .split('Invalid request');
                  messageCode =
                      json.decode(splitedText[1])['displayMessage'].toString();
                }

                return value.reportsList.message == " No Internet Connection"
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          value.reportsList.message.toString(),
                                          style: TextStyle(
                                              fontSize: SizerUtil.deviceType ==
                                                      DeviceType.mobile
                                                  ? titleFontSize
                                                  : 12.sp,
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
                                          child: CircularProgressIndicator(
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
                                        builder: (context) => MyNavigationBar(
                                              indexNumber: 0,
                                            )));
                              },
                            ),
                          ),
                        ],
                      );
              case Status.COMPLETED:
                return reportViewmodel.reportsList.data!.data!.length != 0
                    ? RefreshIndicator(
                        onRefresh: refresh,
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.only(bottom: 10),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return createNewsListContainer(
                                        context, index);
                                  },
                                  childCount: reportViewmodel
                                      .reportsList.data!.data!.length,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          'You don\'t have any recent prescriptions.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: titleFontSize,
                                              color: Color(0XFF545454),
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
            }
          },
        ),
      ),
    );
  }
}
