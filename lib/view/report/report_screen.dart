import 'dart:async';

import 'package:axonweb/View_Model/Report_View_Model/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Res/Components/Appbar/payment_widget.dart';
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
  ReportViewmodel reportViewmodel = ReportViewmodel();
  late Map<String, dynamic> data;
  late String data1;
  late Future<void> fetchDataFuture;

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
        data = value!;
        print('data1');
        print(data);
        print('data1');
      });
    });

    // setState(() {});
    // super.initState();
    super.initState();
    fetchDataFuture = fetchData(); // Call the API only once

    // final bookAppointmentViewModel =
    //     Provider.of<BookAppointmentViewModel>(context, listen: false);
  }

  createNewsListContainer(BuildContext context, int itemIndex) {
    return Column(
      children: [
        SizedBox(
          height: 2,
        ),
        InkWell(
          onTap: () {
            Map reportDetails = {
              'providerName': reportViewmodel
                  .reportsList.data!.data![itemIndex].providerName
                  .toString(),
              'patientName': reportViewmodel
                  .reportsList.data!.data![itemIndex].patientName
                  .toString(),
              'date': reportViewmodel
                  .reportsList.data!.data![itemIndex].visitDate
                  .toString(),
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
                    'Provider: ' +
                        reportViewmodel
                            .reportsList.data!.data![itemIndex].providerName
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
                        reportViewmodel
                            .reportsList.data!.data![itemIndex].patientName
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
                        'Updated on: ' +
                            reportViewmodel
                                .reportsList.data!.data![itemIndex].visitDate
                                .toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      InkWell(
                        onTap: () {
                          Map reportDetails = {
                            'providerName': reportViewmodel
                                .reportsList.data!.data![itemIndex].providerName
                                .toString(),
                            'patientName': reportViewmodel
                                .reportsList.data!.data![itemIndex].patientName
                                .toString(),
                            'date': reportViewmodel
                                .reportsList.data!.data![itemIndex].visitDate
                                .toString(),
                            'treatment': reportViewmodel
                                .reportsList.data!.data![itemIndex].treatment
                                .toString(),
                          };
                          Navigator.pushNamed(context, RoutesName.reportDetails,
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
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => SearchBarScreen()));
        //   },
        //   child: Text('aaaaa'),
        // )
      ],
    );
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      reportViewmodel.fetchReportsListApi(token, mobile);

      final settingsViewModel =
          Provider.of<SettingsViewModel>(context, listen: false);

      ;

      settingsViewModel.fetchDoctorDetailsListApi(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsViewModel =
        Provider.of<SettingsViewModel>(context, listen: false);
    // print(
    //     'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    // Timer(Duration(microseconds: 20), () {
    //   reportViewmodel.fetchReportsListApi(token, mobile);
    // });
    Future refresh() async {
      Timer(Duration(microseconds: 20), () {
        reportViewmodel.fetchReportsListApi(token, mobile);
      });
    }

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
                                        title: '  Recent Precription',
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
                                        title: '  Notice Board',
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
      body: ChangeNotifierProvider<ReportViewmodel>.value(
        value: reportViewmodel,
        child: Consumer<ReportViewmodel>(
          builder: (context, value, _) {
            switch (value.reportsList.status!) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(
                    child: Text(value.reportsList.message.toString()));
              case Status.COMPLETED:
                print('providerNameproviderNameproviderNameproviderName');
                print(reportViewmodel.reportsList.data!.data![1].providerName
                    .toString());
                return reportViewmodel.reportsList.data!.data!.length != 0
                    ? RefreshIndicator(
                        onRefresh: refresh,
                        child: Stack(
                          children: [
                            Container(
                              height: 100.h,
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 0),
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: reportViewmodel
                                        .reportsList.data!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int itemIndex) {
                                      return createNewsListContainer(
                                          context, itemIndex);
                                    }),
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
                              physics: BouncingScrollPhysics(),
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
                                          fontSize: 14.sp,
                                          color: Color(0XFF545454),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Center(
                                        child: Image.asset(
                                          'images/axon.png',
                                          height: 10.h,
                                          // width: 90,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Center(
                                        child: Text(
                                          'You  don\'t have any bookings or upcoming events',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Color(0XFF545454),
                                              fontWeight: FontWeight.w600),
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
