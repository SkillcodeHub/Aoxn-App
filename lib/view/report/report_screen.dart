import 'package:axonweb/View_Model/Report_View_Model/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Res/Components/loader.dart';
import '../../Res/colors.dart';
import '../../Utils/routes/routes_name.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/payment_widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late String token = '2dda9fd0-55f7-11e9-9855-029527c1db28';
  late String mobile = '8140629967';
  bool isLoading = false;
  ReportViewmodel reportViewmodel = ReportViewmodel();
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
    reportViewmodel.fetchReportsListApi(token, mobile);
    Future refresh() async {
      reportViewmodel.fetchReportsListApi(token, mobile);
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
                // PaymentWidget(),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 0),
                          physics: BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount:
                              reportViewmodel.reportsList.data!.data!.length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return createNewsListContainer(context, itemIndex);
                          }),
                    ),
                  );
              }
            },
          )),
    );
  }
}
