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
    // setState(() {});
    // super.initState();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    Timer(Duration(microseconds: 20), () {
      reportViewmodel.fetchReportsListApi(token, mobile);
    });
    Future refresh() async {
      Timer(Duration(microseconds: 20), () {
        reportViewmodel.fetchReportsListApi(token, mobile);
      });
    }

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
                  title: 'Recent Precription',
                ),
                WhatsappWidget(),
                PaymentWidget(),
                SettingsWidget(),
              ],
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<ReportViewmodel>(
          create: (BuildContext context) => reportViewmodel,
          child: Consumer<ReportViewmodel>(
            builder: (context, value, _) {
              switch (value.reportsList.status!) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.reportsList.message.toString()));
                case Status.COMPLETED:
                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: reportViewmodel.reportsList.data!.data!.length !=
                                0
                            ? ListView.builder(
                                padding: EdgeInsets.only(bottom: 0),
                                physics: BouncingScrollPhysics(),
                                // shrinkWrap: true,
                                itemCount: reportViewmodel
                                    .reportsList.data!.data!.length,
                                itemBuilder:
                                    (BuildContext context, int itemIndex) {
                                  return createNewsListContainer(
                                      context, itemIndex);
                                })
                            : Stack(
                                children: [
                                  SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
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
                                              height: 30,
                                            ),
                                            Text(
                                              'Swipe down to refresh page',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0XFF545454),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 120,
                                            ),
                                            Center(
                                              child: Image.asset(
                                                'images/axon.png',
                                                height: 90,
                                                width: 90,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Text(
                                                'You  don\'t have any bookings or upcoming events',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0XFF545454),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
              }
            },
          )),
    );
  }
}
