// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../Res/Components/Appbar/payment_widget.dart';
// import '../../Res/Components/loader.dart';
// import '../../Res/colors.dart';
// import '../../Utils/utils.dart';
// import '../../View_Model/Book_View_Model/bookAppointment_view_model.dart';
// import '../../View_Model/Services/SharePreference/SharePreference.dart';
// import '../../View_Model/Settings_View_Model/settings_view_model.dart';
// import '../../data/response/status.dart';
// import '../../res/components/appbar/axonimage_appbar-widget.dart';
// import '../../res/components/appbar/screen_name_widget.dart';
// import '../../res/components/appbar/settings_widget.dart';
// import '../../res/components/appbar/whatsapp_widget.dart';

// class BookAppointmentScreen extends StatefulWidget {
//   const BookAppointmentScreen({Key? key}) : super(key: key);

//   @override
//   State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
// }

// class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
//   UserPreferences userPreference = UserPreferences();
//   late String? mobile;
//   late String token;
//   late String deviceId;
//   late String selectedDoctorId;

//   @override
//   void initState() {
//     super.initState();

//     userPreference.getMobile().then((value1) {
//       setState(() {
//         mobile = value1;
//       });
//     });

//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//       });
//     });

//     userPreference.getDeviceId().then((value) {
//       setState(() {
//         deviceId = value!;
//       });
//     });

//     Timer(Duration(microseconds: 20), () {
//       final doctorListViewModel =
//           Provider.of<DoctorListViewModel>(context, listen: false);
//       final settingsViewModel =
//           Provider.of<SettingsViewModel>(context, listen: false);

//       doctorListViewModel.fetchDoctorListApi(token);
//       settingsViewModel.fetchDoctorDetailsListApi(token);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bookAppointmentViewModel =
//         Provider.of<BookAppointmentViewModel>(context, listen: false);
//     final doctorListViewModel =
//         Provider.of<DoctorListViewModel>(context, listen: true);
//     final settingsViewModel =
//         Provider.of<SettingsViewModel>(context, listen: true);

//     return Scaffold(
//       backgroundColor: BackgroundColor,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: false,
//           backgroundColor: Color(0xffffffff),
//           elevation: 0,
//           title: Padding(
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AxonIconForAppBarWidget(),
//                 ScreenNameWidget(title: 'Book Appointment'),
//                 WhatsAppWidget(),
//                 PaymentWidget(),
//                 SettingsWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(0),
//               child: isLoading
//                   ? Loader()
//                   : Column(
//                       children: [
//                         ChangeNotifierProvider.value(
//                           value: settingsViewModel,
//                           child: Consumer<SettingsViewModel>(
//                             builder: (context, value, child) {
//                               switch (value.doctorDetailsList.status!) {
//                                 case Status.LOADING:
//                                   return Center(child: CircularProgressIndicator());
//                                 case Status.ERROR:
//                                   return Center(
//                                     child: Text(
//                                       value.doctorDetailsList.message.toString(),
//                                     ),
//                                   );
//                                 case Status.COMPLETED:
//                                   final doctorDetails =
//                                       value.doctorDetailsList.data!.data![0];

//                                   return Stack(
//                                     children: [
//                                       Container(
//                                         height: 26.h,
//                                         width: 100.w,
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                             image: MemoryImage(
//                                               base64Decode(
//                                                 doctorDetails.logoImageURL.toString(),
//                                               ),
//                                             ),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         bottom: 3,
//                                         left: 0,
//                                         right: 0,
//                                         child: Transform.translate(
//                                           offset: Offset(0, 4),
//                                           child: Container(
//                                             height: 70,
//                                             decoration: BoxDecoration(
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.topCenter,
//                                                 end: Alignment.bottomCenter,
//                                                 colors: [
//                                                   Colors.transparent,
//                                                   Colors.grey.shade700,
//                                                 ],
//                                               ),
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                 left: 14,
//                                                 top: 8,
//                                                 bottom: 8,
//                                                 right: 8,
//                                               ),
//                                               child: Row(
//                                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Container(
//                                                     width: 70.w,
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       mainAxisAlignment: MainAxisAlignment.end,
//                                                       children: [
//                                                         Text(
//                                                           doctorDetails.customerName.toString(),
//                                                           style: TextStyle(
//                                                             fontSize: 13,
//                                                             color: Colors.white,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                           maxLines: 1,
//                                                           overflow: TextOverflow.ellipsis,
//                                                         ),
//                                                         Text(
//                                                           doctorDetails.customerAddress.toString(),
//                                                           style: TextStyle(
//                                                             fontSize: 13,
//                                                             color: Colors.white,
//                                                             fontStyle: FontStyle.italic,
//                                                           ),
//                                                           maxLines: 1,
//                                                           overflow: TextOverflow.ellipsis,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   InkWell(
//                                                     onTap: () {
//                                                       if (doctorDetails.customerContact != null &&
//                                                           doctorDetails.customerContact!.isNotEmpty) {
//                                                         launch('tel://${doctorDetails.customerContact}');
//                                                       } else {
//                                                         Utils.snackBar('MobileNo Not Available', context);
//                                                       }
//                                                     },
//                                                     child: Container(
//                                                       width: 15.w,
//                                                       height: 5.h,
//                                                       child: Image.asset("images/phone-call.png"),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                               }
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           margin: EdgeInsets.only(left: 8, right: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 height: 12.h,
//                                 width: 78.w,
//                                 padding: EdgeInsets.all(8),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Provider',
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.grey.shade700,
//                                       ),
//                                     ),
//                                     SizedBox(height: 1.h),
//                                     Container(
//                                       alignment: Alignment.centerLeft,
//                                       child: DropdownButtonHideUnderline(
//                                         child: ButtonTheme(
//                                           alignedDropdown: true,
//                                           child: DropdownButton<String>(
//                                             isDense: true,
//                                             hint: Text(
//                                               doctorListViewModel
//                                                   .doctorList.data!.data![0].doctorName
//                                                   .toString(),
//                                               style: TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             value: selectedDoctorId =
//                                                 doctorListViewModel
//                                                     .doctorList.data!.data![0].doctorId
//                                                     .toString(),
//                                             onChanged: (String? newValue) {
//                                               setState(() {
//                                                 selectedDoctorId = newValue!;
//                                               });

//                                               print(selectedDoctorId);
//                                             },
//                                             items: doctorListViewModel
//                                                 .doctorList.data!.data!.map(
//                                               (map) {
//                                                 return new DropdownMenuItem<String>(
//                                                   value: map.doctorId.toString(),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                     children: <Widget>[
//                                                       Container(
//                                                         child: Text(
//                                                           map.doctorName.toString(),
//                                                           style: TextStyle(
//                                                             fontSize: 14.sp,
//                                                             fontWeight: FontWeight.w500,
//                                                           ),
//                                                           textAlign: TextAlign.start,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             ).toList(),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFFD5722),
//                                   borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(8),
//                                     bottomRight: Radius.circular(8),
//                                   ),
//                                 ),
//                                 height: 12.h,
//                                 width: 16.w,
//                                 child: IconButton(
//                                   onPressed: () {
//                                     doctorListViewModel.fetchDoctorListApi(token);
//                                     doctorDetailsListViewModel.fetchDoctorDetailsListApi(token);
//                                   },
//                                   icon: Icon(
//                                     Icons.refresh_outlined,
//                                     color: Colors.white,
//                                     size: 30,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
