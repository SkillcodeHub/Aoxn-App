import 'dart:async';
import 'dart:convert';

import 'package:axonweb/Res/Components/Appbar/screen_name_widget.dart';
import 'package:axonweb/View/NevigationBar/my_navigationbar.dart';
import 'package:axonweb/View_Model/Payment_View_Model/paymentHistory_view_model.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                  padding: EdgeInsets.all(8.sp),
                  height: 5.h,
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
                                fontSize: 12.sp,
                              ),
                            )
                          : Container(),
                      Text(
                        paymentHistoryViewmodel.paymentHistoryList.data!
                            .data![itemIndex].payStatusText
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 15.h,
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
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        paymentHistoryViewmodel
                            .paymentHistoryList.data!.data![itemIndex].payHead
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        paymentHistoryViewmodel
                            .paymentHistoryList.data!.data![itemIndex].amount
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '11-May-2023 12:33 PM',
                        style: TextStyle(
                          fontSize: 12.sp,
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
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: IconButton(
              color: Colors.black,
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
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Text(
                            messageCode.toString(),
                            style: TextStyle(
                                // fontWeight:
                                //     FontWeight
                                //         .bold,
                                fontSize: 12.sp),
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            SizedBox(
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
                                            fontSize: 14.sp,
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
                                            physics: BouncingScrollPhysics(),
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
                                                  'You  don\'t have any payment history',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
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
                              );
                    }
                  },
                ));
          }
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showModalBottomSheet<void>(
      //       isScrollControlled: true,
      //       backgroundColor: Colors.transparent,
      //       context: context,
      //       builder: (BuildContext context) {
      //         return PaymentSheet();
      //       },
      //     );
      //   },
      //   backgroundColor: Colors.green,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

// class PaymentSheet extends StatefulWidget {
//   const PaymentSheet({Key? key}) : super(key: key);

//   @override
//   State<PaymentSheet> createState() => _PaymentSheetState();
// }

// class _PaymentSheetState extends State<PaymentSheet> {
//   String? genderValue;
//   final formKey = GlobalKey<FormState>();
//   bool _enableBtn = false;
//   bool agree = false;
//   final FocusNode _nodeAmount = FocusNode();
//   final FocusNode _nodeEmail = FocusNode();
//   TextEditingController strAmount = TextEditingController();
//   TextEditingController strEmail = TextEditingController();
//   late String token;
//   late String mobile;
//   late String name;
//   late String letId;

//   UserPreferences userPreference = UserPreferences();
//   String selectedPayHeadIndex =
//       'Consultation'; // Index of the selected payHead, initially set to -1

//   CustomerPayHeadViewmodel customerPayHeadViewmodel =
//       CustomerPayHeadViewmodel();

//   InitiatePaymentViewModel initiatePaymentViewModel =
//       InitiatePaymentViewModel();
//   AdvanceBookAppointmentViewModel advanceBookAppointmentViewModel =
//       AdvanceBookAppointmentViewModel();
//   SettingsViewModel settingsViewModel = SettingsViewModel();

//   @override
//   void initState() {
//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//         print(token);
//       });
//     });
//     userPreference.getMobile().then((value) {
//       setState(() {
//         mobile = value!;
//         print(token);
//       });
//     });
//     userPreference.getName().then((value) {
//       setState(() {
//         name = value!;
//         print(token);
//       });
//     });
//     userPreference.getletId().then((value) {
//       setState(() {
//         letId = value!;
//         print(token);
//       });
//     });

//     super.initState();
//     Timer(Duration(microseconds: 20), () {
//       print(token);
//       customerPayHeadViewmodel.fetchCustomerPayHeadListApi(token.toString());
//     });
//   }

//   void makePayment() async {
//     _nodeAmount.unfocus();
//     _nodeEmail.unfocus();

//     Map<String, dynamic> data = {
//       "CaseNo": '20731',
//       "Name": name,
//       "Mobile": mobile.toString(),
//       "Email": strEmail.text.toString(),
//       "Gender": "Male",
//       "PatType": "Old",
//       "ApptDate": "2023-09-22",
//       "CustomerToken": token.toString(),
//       "DelayMinute":
//           "30", //DelayMinutes from minuteInterval form slot timing selection
//       "DeviceId": "App",
//       "DoctorId": "1",
//       "TimingId": '1', //TimingId from slot timing selection
//       "AppointmentPaymentHead": selectedPayHeadIndex.toString(),
//       "Amount": '200',

//       // "customerId": settingsViewModel
//       //     .doctorDetailsList.data!.data![0].customerId
//       //     .toString(),

//       // "mobile": mobile.toString(),
//       // "patientId": '1647895',
//       // "caseNo": '20731',
//       // "name": name,
//       // "email": strEmail.text.toString(),
//       // "payHead": selectedPayHeadIndex.toString(),
//       // "amount": '200',
//       // "customerToken": token.toString(),
//       // "lat": letId.toString(),
//     };
//     // initiatePaymentViewModel.initiatePaymentApi(data, context);
//     advanceBookAppointmentViewModel.advancebookappointmentapi(data, context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     settingsViewModel.fetchDoctorDetailsListApi(token.toString());

//     return Scaffold(
//       // persistentFooterAlignment: AlignmentDirectional.centerEnd,
//       backgroundColor: Colors.transparent,
//       body: SizedBox(
//         height: 100.h,
//         // alignment: Alignment.bottomCenter,
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.84,
//           maxChildSize: 0.84,
//           minChildSize: 0.84,
//           builder: (BuildContext context, ScrollController scrollController) {
//             return Container(
//               margin: EdgeInsets.only(left: 4.sp, right: 4.sp, bottom: 4.sp),
//               padding: EdgeInsets.all(8.sp),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.sp),
//                 color: Colors.white,
//               ),
//               child: ListView(
//                 controller: scrollController,
//                 children: [
//                   Form(
//                     key: formKey,
//                     onChanged: () => setState(
//                         () => _enableBtn = formKey.currentState!.validate()),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.57,
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Select Payment Reason',
//                                     style: TextStyle(
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: Icon(
//                                       Icons.close,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.02,
//                               ),
//                               ChangeNotifierProvider<CustomerPayHeadViewmodel>(
//                                 create: (BuildContext context) =>
//                                     customerPayHeadViewmodel,
//                                 child: Consumer<CustomerPayHeadViewmodel>(
//                                   builder: (context, value, _) {
//                                     switch (value.CustomerPayHeadList.status!) {
//                                       case Status.LOADING:
//                                         return Center(
//                                           child: CircularProgressIndicator(),
//                                         );
//                                       case Status.ERROR:
//                                         return Center(
//                                           child: Text(value
//                                               .CustomerPayHeadList.message
//                                               .toString()),
//                                         );
//                                       case Status.COMPLETED:
//                                         return Container(
//                                           // height: 30.h,
//                                           width: 90.w,
//                                           child: SingleChildScrollView(
//                                             physics:
//                                                 AlwaysScrollableScrollPhysics(),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: ListView.builder(
//                                                 // physics:
//                                                 //     NeverScrollableScrollPhysics(), // Disable scrolling
//                                                 shrinkWrap: true,
//                                                 itemCount:
//                                                     customerPayHeadViewmodel
//                                                         .CustomerPayHeadList
//                                                         .data!
//                                                         .data!
//                                                         .length,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         index) {
//                                                   return Column(
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                             customerPayHeadViewmodel
//                                                                 .CustomerPayHeadList
//                                                                 .data!
//                                                                 .data![index]
//                                                                 .payHead
//                                                                 .toString(),
//                                                             style: TextStyle(
//                                                               fontSize: 13.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                             ),
//                                                           ),
//                                                           Radio<String>(
//                                                             value: customerPayHeadViewmodel
//                                                                 .CustomerPayHeadList
//                                                                 .data!
//                                                                 .data![index]
//                                                                 .payHead
//                                                                 .toString(),
//                                                             groupValue:
//                                                                 selectedPayHeadIndex
//                                                                     .toString(),
//                                                             onChanged: (value) {
//                                                               setState(() {
//                                                                 selectedPayHeadIndex =
//                                                                     value!;

//                                                                 print(
//                                                                     'selectedPayHeadIndex:');
//                                                                 strAmount.text = customerPayHeadViewmodel
//                                                                     .CustomerPayHeadList
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .defaultAmount
//                                                                     .toString();
//                                                                 print(
//                                                                   customerPayHeadViewmodel
//                                                                       .CustomerPayHeadList
//                                                                       .data!
//                                                                       .data![
//                                                                           index]
//                                                                       .defaultAmount
//                                                                       .toString(),
//                                                                 );
//                                                                 print(
//                                                                     selectedPayHeadIndex);
//                                                               });
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Container(
//                                                         color: Colors.black,
//                                                         height: 1,
//                                                       )
//                                                     ],
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Column(
//                             children: [
//                               TextFormField(
//                                 focusNode: _nodeAmount,
//                                 controller: strAmount,
//                                 keyboardType: TextInputType.number,
//                                 validator: (value) => value!.isEmpty
//                                     ? "Please enter Amount"
//                                     : null,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 textInputAction: TextInputAction.next,
//                                 decoration: InputDecoration(
//                                   hintText: 'Amount',
//                                 ),
//                               ),
//                               TextFormField(
//                                 focusNode: _nodeEmail,
//                                 controller: strEmail,
//                                 keyboardType: TextInputType.text,
//                                 validator: (value) => value!.isEmpty
//                                     ? "Please enter email"
//                                     : null,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 textInputAction: TextInputAction.next,
//                                 decoration: InputDecoration(
//                                   hintText: 'Email Id',
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Checkbox(
//                                     value: agree,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         agree = value ?? false;
//                                       });
//                                     },
//                                   ),
//                                   Text(
//                                     'I accept  ',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12.sp,
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () async {
//                                       final url = settingsViewModel
//                                           .doctorDetailsList
//                                           .data!
//                                           .data![0]
//                                           .termsLink
//                                           .toString();
//                                       if (await canLaunch(url)) {
//                                         await launch(url);
//                                       } else {
//                                         throw 'Could not launch $url';
//                                       }
//                                     },
//                                     child: Text(
//                                       'terms and conditions',
//                                       style: TextStyle(
//                                         color: Color(0xFFFD5722),
//                                         fontSize: 12.sp,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Spacer(),
//                                   Container(
//                                     height: 28.sp,
//                                     width: 40.w,
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         if (!agree) {
//                                           Utils.snackBar(
//                                               'Please select terms & conditions',
//                                               context);
//                                         } else if (!_enableBtn) {
//                                           Utils.snackBar(
//                                               'Please select terms & conditions',
//                                               context);
//                                         } else {
//                                           makePayment();
//                                         }
//                                       },

//                                       // _enableBtn
//                                       //     ? () => makePayment()
//                                       //     : null,
//                                       child: Text(
//                                         'START PAYMENT',
//                                         style: TextStyle(
//                                           fontSize: 11.sp,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       style: ElevatedButton.styleFrom(
//                                         primary: _enableBtn
//                                             ? Color(0xFFFD5722)
//                                             : Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
