// import 'dart:async';

// import 'package:axonweb/Model/Payment_Model/customerPayHead_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sizer/sizer.dart';

// import '../../View_Model/News_View_Model/news_view_model.dart';
// import '../../View_Model/Payment_View_Model/customerPayHead_view_model.dart';
// import '../../View_Model/Payment_View_Model/initiatePayment_view_model.dart';
// import '../../View_Model/Services/SharePreference/SharePreference.dart';
// import '../../data/response/status.dart';

// class PaymentHistory extends StatefulWidget {
//   const PaymentHistory({Key? key}) : super(key: key);

//   @override
//   State<PaymentHistory> createState() => _PaymentHistoryState();
// }

// class _PaymentHistoryState extends State<PaymentHistory> {
//   final scaffoldState = GlobalKey<ScaffoldState>();
//   late String genderValue;
//   final formKey = GlobalKey<FormState>();
//   // bool _enableBtn = false;
//   bool agree = false;

//   // final FocusNode _nodeAmount = FocusNode();
//   // final FocusNode _nodeEmail = FocusNode();
//   TextEditingController strAmount = TextEditingController();
//   TextEditingController strEmail = TextEditingController();
//   // void _showSheet() {
//   //   // Show BottomSheet here using the Scaffold state instead ot«f the Scaffold context
//   //   scaffoldState.currentState
//   //       ?.showBottomSheet((context) => Container(color: Colors.red));
//   // }

//   // late Razorpay _razorpay;

//   // void _handlePaymentSuccess(PaymentSuccessResponse response) {
//   //   Fluttertoast.showToast(
//   //       msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
//   // }

//   // void _handlePaymentError(PaymentFailureResponse response) {
//   //   Fluttertoast.showToast(
//   //       msg: "ERROR HERE: ${response.code} - ${response.message}",
//   //       timeInSecForIosWeb: 4);
//   // }

//   // void _handleExternalWallet(ExternalWalletResponse response) {
//   //   Fluttertoast.showToast(
//   //       msg: "EXTERNAL_WALLET IS: ${response.walletName}",
//   //       timeInSecForIosWeb: 4);
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _razorpay = Razorpay();
//   //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//   //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//   //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   // }

//   // void makePayment() async {
//   //   var options = {
//   //     'key': 'rzp_test_NyShBXSTj3KSXP',
//   //     'amount': 20000, // Rs 200
//   //     'name': "Parth",
//   //     'description': 'iphone 12',
//   //     'prefill': {
//   //       'contact': "+91123456789",
//   //       'email': "patelparth@gmail.com",
//   //     }
//   //   };

//   //   try {
//   //     _razorpay.open(options);
//   //   } catch (e) {
//   //     debugPrint(e.toString());
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       key: scaffoldState,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: false,
//           elevation: 0,
//           backgroundColor: Color(0xffffffff),
//           leading: Padding(
//             padding: EdgeInsets.only(top: 5.0),
//             child: IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_rounded),
//             ),
//           ),
//           title: Padding(
//             padding: EdgeInsets.only(
//               top: 5.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Payment History",
//                   style: TextStyle(
//                     color: Colors.black,
//                     // fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Padding(
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Card(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           height: 5.h,
//                           color: Color(0xFFFD5722),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'PayId: 09876543211234567890',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12.sp),
//                               ),
//                               Text(
//                                 'Pending',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 15.h,
//                           padding: EdgeInsets.all(8),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'ANIL KHIMJIBHAI',
//                                 style: TextStyle(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               Text(
//                                 'Vaccination',
//                                 style: TextStyle(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               Text(
//                                 'Rs 500.0',
//                                 style: TextStyle(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               Text(
//                                 '11-May-2023 12:33 PM',
//                                 style: TextStyle(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // makePayment();
//           showModalBottomSheet<void>(
//               isScrollControlled: true,
//               backgroundColor: Colors.transparent,
//               context: context,
//               builder: (BuildContext context) {
//                 return Stack(
//                   children: [
//                     PaymentSheet(),
//                   ],
//                 );
//               });
//         },
//         backgroundColor: Colors.green,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

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
//   UserPreferences userPreference = UserPreferences();
//   String selectedPayHeadIndex =
//       'Cunsultation'; // Index of the selected payHead, initially set to -1

//   CustomerPayHeadViewmodel customerPayHeadViewmodel =
//       CustomerPayHeadViewmodel();

//   InitiatePaymentViewModel initiatePaymentViewModel =
//       InitiatePaymentViewModel();
//   late Razorpay _razorpay;

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print("++++++============");
//     print("paymentId: ${response.paymentId}");
//     print("orderId: ${response.orderId}");
//     print("signature: ${response.signature}");
//     Fluttertoast.showToast(
//         msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//         msg: "ERROR HERE: ${response.code} - ${response.message}",
//         timeInSecForIosWeb: 4);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET IS: ${response.walletName}",
//         timeInSecForIosWeb: 4);
//   }

//   @override
//   void initState() {
//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//         print(token);
//       });
//     });
//     super.initState();
//     Timer(Duration(microseconds: 20), () {
//       print(token);
//       customerPayHeadViewmodel.fetchCustomerPayHeadListApi(token.toString());
//     });
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   void makePayment() async {
//     Map data = {
//       "customerId": '99999999',
//       "mobile": '6353335967',
//       "patientId": '1584514',
//       "caseNo": '1',
//       "name": "Parth Patel",
//       "email": "patelparth292906@gmail.com",
//       "payHead": "OPD",
//       "amount": '200',
//       "customerToken": "68cb311f-585a-4e86-8e89-06edf1814080",
//       "lat": "3af64010-f4cd-11ed-b2ab-021afc3343fe"
//     };
//     initiatePaymentViewModel.initiatePaymentApi(data, context);

//     var options = {
//       // 'key': 'rzp_test_NyShBXSTj3KSXP',
//       'key': 'rzp_test_8aGQyjie2ef5rn',
//       'order_id': 'order_MAv4O6Wbb4vfhr',

//       'amount': (int.parse(strAmount.text) * 100).toString(), // Rs 200
//       'name': "Parth",
//       'description': 'User Payment Request',
//       'prefill': {
//         'contact': "+916353335967",
//         'email': (strEmail.text).toString(),
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, state) {
//       return DraggableScrollableSheet(
//           initialChildSize: 0.87,
//           maxChildSize: 0.87,
//           minChildSize: 0.87,
//           // builder: (_, controller) {
//           builder: (BuildContext context, ScrollController scrollController) {
//             return Container(
//               margin: EdgeInsets.only(
//                 left: 4,
//                 right: 4,
//                 bottom: 4,
//               ),
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
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
//                                         fontSize: 23,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: Icon(
//                                       Icons.close,
//                                       color: Colors.black,
//                                     ),
//                                   )
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
//                                             child: CircularProgressIndicator());
//                                       case Status.ERROR:
//                                         return Center(
//                                             child: Text(value
//                                                 .CustomerPayHeadList.message
//                                                 .toString()));
//                                       case Status.COMPLETED:
//                                         return Container(
//                                           height: 46.h,
//                                           width: 90.w,
//                                           child: SingleChildScrollView(
//                                             physics:
//                                                 AlwaysScrollableScrollPhysics(),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: ListView.builder(
//                                                 physics:
//                                                     NeverScrollableScrollPhysics(), // Disable scrolling
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
//                                         color: Colors.black, fontSize: 17),
//                                   ),
//                                   InkWell(
//                                     onTap: () {},
//                                     child: Text(
//                                       'terms and conditions',
//                                       style: TextStyle(
//                                         color: Color(0xFFFD5722),
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width *
//                                         0.56,
//                                   ),
//                                   Container(
//                                     // padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                                     height: 36,
//                                     width: MediaQuery.of(context).size.width *
//                                         0.35,
//                                     child: ElevatedButton(
//                                       onPressed:
//                                           // print(genderValue);
//                                           // print(strAmount.text);
//                                           _enableBtn
//                                               ? () => makePayment()
//                                               : null,
//                                       child: Text(
//                                         'START PAYMENT',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white),
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
//                   Padding(
//                       padding: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).viewInsets.bottom)),
//                 ],
//               ),
//             );
//           });
//     });
//   }
// }
