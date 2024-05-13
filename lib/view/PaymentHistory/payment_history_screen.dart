import 'dart:async';
import 'dart:convert';

import 'package:axonweb/Res/Components/Appbar/screen_name_widget.dart';
import 'package:axonweb/Utils/utils.dart';
import 'package:axonweb/View/NevigationBar/my_navigationbar.dart';
import 'package:axonweb/View_Model/Payment_View_Model/paymentHistory_view_model.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../View_Model/Settings_View_Model/settings_view_model.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  late String token;
  late String letId;
  late String mobile;
  late Future<void> fetchDataFuture;
  String? messageCode;

  @override
  void initState() {
    super.initState();
    userPreference.getToken().then((value1) {
      setState(() {
        token = value1!;
      });
    });
    userPreference.getletId().then((value) {
      setState(() {
        letId = value!;
        print('letId');
        print(letId);
        print('letId');
      });
    });
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1!;
      });
    });
    fetchDataFuture = fetchData(); // Call the API only once
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final paymentHistoryViewmodel =
          Provider.of<PaymentHistoryViewmodel>(context, listen: false);

      paymentHistoryViewmodel.fetchPaymentHistoryApi(token, letId, mobile);
    });
  }

  createAppointmentListContainer(BuildContext context, int itemIndex) {
    final paymentHistoryViewmodel =
        Provider.of<PaymentHistoryViewmodel>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: SizerUtil.deviceType == DeviceType.mobile
                      ? EdgeInsets.all(8.sp)
                      : EdgeInsets.all(2.sp),
                  height: SizerUtil.deviceType == DeviceType.mobile ? 5.h : 5.h,
                  color: Color(0xFFFD5722),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      paymentHistoryViewmodel.paymentHistoryList.data!
                                  .data![itemIndex].payTransID
                                  .toString() !=
                              ""
                          ? Text(
                              "PayId: " +
                                  paymentHistoryViewmodel.paymentHistoryList
                                      .data!.data![itemIndex].payTransID
                                      .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? subTitleFontSize
                                        : 9.sp,
                              ),
                            )
                          : Container(),
                      Text(
                        paymentHistoryViewmodel.paymentHistoryList.data!
                            .data![itemIndex].payStatusText
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? titleFontSize
                              : 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height:
                      SizerUtil.deviceType == DeviceType.mobile ? 15.h : 20.h,
                  padding: EdgeInsets.all(8.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paymentHistoryViewmodel
                            .paymentHistoryList.data!.data![itemIndex].name
                            .toString(),
                        style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? subTitleFontSize
                              : 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        paymentHistoryViewmodel
                            .paymentHistoryList.data!.data![itemIndex].payHead
                            .toString(),
                        style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? subTitleFontSize
                              : 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        paymentHistoryViewmodel
                            .paymentHistoryList.data!.data![itemIndex].amount
                            .toString(),
                        style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? subTitleFontSize
                              : 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '11-May-2023 12:33 PM',
                        style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                              ? subTitleFontSize
                              : 10.sp,
                          fontWeight: FontWeight.w500,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentHistoryViewmodel =
        Provider.of<PaymentHistoryViewmodel>(context, listen: false);
    Future refresh() async {
      Timer(Duration(microseconds: 20), () {
        paymentHistoryViewmodel.fetchPaymentHistoryApi(token, letId, mobile);
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: IconButton(
              color: Colors.black,
              iconSize: SizerUtil.deviceType == DeviceType.mobile ? 2.5.h : 3.h,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ScreenNameWidget(title: 'Payment History')],
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
            return ChangeNotifierProvider<PaymentHistoryViewmodel>.value(
                value: paymentHistoryViewmodel,
                child: Consumer<PaymentHistoryViewmodel>(
                  builder: (context, value, _) {
                    switch (value.paymentHistoryList.status!) {
                      case Status.LOADING:
                        return Center(
                            child: Center(child: CircularProgressIndicator()));
                      case Status.ERROR:
                        print(
                            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                        print(value.paymentHistoryList.message.runtimeType);
                        final splitedText = value.paymentHistoryList.message
                            .toString()
                            .split('Invalid request');
                        messageCode = json
                            .decode(splitedText[1])['displayMessage']
                            .toString();
                        print(json.decode(splitedText[1])['displayMessage']);
                        print(
                            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              'Alert!',
                              style: TextStyle(
                                  fontSize:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? titleFontSize
                                          : 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Text(
                            messageCode.toString(),
                            style: TextStyle(
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 12.sp
                                        : 9.sp),
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            SizedBox(
                              height: 5.h,
                              width: 80.w,
                              child: ElevatedButton(
                                child: paymentHistoryViewmodel.loading1
                                    ? Container(
                                        child: Container(
                                            child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      )))
                                    : Text(
                                        'OK',
                                        style: TextStyle(
                                            fontSize: SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? titleFontSize
                                                : 10.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                onPressed: () {
                                  paymentHistoryViewmodel.setLoading1(true);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyNavigationBar(
                                                indexNumber: 0,
                                              )));
                                  // Timer(Duration(seconds: 5),() =>  settingsViewModel.setLoading1(true)) ;
                                },
                              ),
                            ),
                          ],
                        );

                      case Status.COMPLETED:
                        return value.paymentHistoryList.data!.data!.length != 0
                            ? RefreshIndicator(
                                onRefresh: refresh,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 100.h,
                                      child: SingleChildScrollView(
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        child: ListView.builder(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: value.paymentHistoryList
                                                .data!.data!.length,
                                            itemBuilder: (BuildContext context,
                                                int itemIndex) {
                                              return createAppointmentListContainer(
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
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.mobile
                                                          ? titleFontSize
                                                          : 12.sp,
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
                                                  // width: 90,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Center(
                                                child: Text(
                                                  'You don\'t have any payment history',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? titleFontSize
                                                          : 12.sp,
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
