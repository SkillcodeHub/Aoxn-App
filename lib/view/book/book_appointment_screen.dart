import 'dart:async';
import 'dart:convert';

import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Res/Components/loader.dart';
import '../../Res/colors.dart';
import '../../Utils/routes/routes_name.dart';
import '../../Utils/utils.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/payment_widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';

class BookApointmentScreen extends StatefulWidget {
  const BookApointmentScreen({super.key});

  @override
  State<BookApointmentScreen> createState() => _BookApointmentScreenState();
}

class _BookApointmentScreenState extends State<BookApointmentScreen> {
  UserPreferences userPreference = UserPreferences();
  DoctorListViewmodel doctorListViewmodel = DoctorListViewmodel();
  SettingsViewModel settingsViewModel = SettingsViewModel();
  late String number;

  late String selectedDocotrId;

  bool isLoading = false;
  var mobile;
  late String token;

  // List doctorData = [];
  // List customerData = [];

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
    setState(() {});
    // super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ParthParthParth');

    Timer(Duration(microseconds: 20), () {
      doctorListViewmodel.fetchDoctorListApi(token);
      settingsViewModel.fetchDoctorDetailsListApi(token);
    });
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
                  title: 'Book Appointment',
                ),
                WhatsappWidget(),
                // PaymentWidget(),
                SettingsWidget(),
              ],
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     userPrefernce.remove().then((value) {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => LoginScreen()));
          //     });
          //   },
          //   child: Text('Logout'),
          // )
        ),
      ),
      body: ChangeNotifierProvider<DoctorListViewmodel>(
          create: (BuildContext context) => doctorListViewmodel,
          child: Consumer<DoctorListViewmodel>(
            builder: (context, value, child) {
              switch (value.doctorList.status!) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.doctorList.message.toString()));
                case Status.COMPLETED:
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: isLoading
                              ? isLoading
                                  ? Container()
                                  : Container()
                              : Column(
                                  children: [
                                    ChangeNotifierProvider<SettingsViewModel>(
                                      create: (BuildContext context) =>
                                          settingsViewModel,
                                      child: Consumer<SettingsViewModel>(
                                          builder: (context, value, child) {
                                        switch (
                                            value.doctorDetailsList.status!) {
                                          case Status.LOADING:
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          case Status.ERROR:
                                            return Center(
                                                child: Text(
                                              // value
                                              //   .doctorDetailsList
                                              //   .message
                                              //   .toString()
                                              'aaaa',
                                            ));
                                          case Status.COMPLETED:
                                            number = settingsViewModel
                                                .doctorDetailsList
                                                .data!
                                                .data![0]
                                                .customerContact
                                                .toString();
                                            return Container(
                                                height: 22.h,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: MemoryImage(
                                                      base64Decode(
                                                        settingsViewModel
                                                            .doctorDetailsList
                                                            .data!
                                                            .data![0]
                                                            .logoImageURL
                                                            .toString(),
                                                      ),
                                                    ),
                                                    // onError: (exception,
                                                    //     stackTrace) {
                                                    //   return ;
                                                    // },
                                                    // image: NetworkImage(
                                                    //   customerData[0]['logoImageURL'],
                                                    // ),
                                                    // image: AssetImage('images/c5.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 80.w,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              settingsViewModel
                                                                  .doctorDetailsList
                                                                  .data!
                                                                  .data![0]
                                                                  .customerName
                                                                  .toString(),
                                                              // 'aaaa',
                                                              // customerData[0]['customerName'],
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              settingsViewModel
                                                                  .doctorDetailsList
                                                                  .data!
                                                                  .data![0]
                                                                  .customerAddress
                                                                  .toString(),
                                                              // customerData[0]['customerAddress'],
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          number == null ||
                                                                  number == ''
                                                              ? Utils.snackBar(
                                                                  'MobileNo Not Available',
                                                                  context)
                                                              : launch(
                                                                  'tel://$number');
                                                        },
                                                        child: Container(
                                                          width: 15.w,
                                                          height: 5.h,
                                                          child: Image.asset(
                                                            "images/phone-call.png",
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                        }
                                      }),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      margin: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            height: 12.h,
                                            width: 81.3.w,
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Provider',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          Colors.grey.shade700),
                                                ),
                                                SizedBox(height: 1.h),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child: DropdownButton<
                                                          String>(
                                                        isDense: true,
                                                        hint: Text(
                                                          // "Select Doctor",
                                                          doctorListViewmodel
                                                              .doctorList
                                                              .data!
                                                              .data![0]
                                                              .doctorName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        value: selectedDocotrId =
                                                            doctorListViewmodel
                                                                .doctorList
                                                                .data!
                                                                .data![0]
                                                                .doctorId
                                                                .toString(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedDocotrId =
                                                                newValue!;
                                                          });

                                                          print(
                                                              selectedDocotrId);
                                                        },
                                                        items:
                                                            doctorListViewmodel
                                                                .doctorList
                                                                .data!
                                                                .data!
                                                                .map((map) {
                                                          return new DropdownMenuItem<
                                                              String>(
                                                            value: map.doctorId
                                                                .toString(),
                                                            // value: _mySelection,
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                    // width: 249,
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    child: Text(
                                                                      map.doctorName
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                              ],
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFFD5722),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8))),
                                            height: 12.h,
                                            width: 16.w,
                                            child: Icon(
                                              Icons.punch_clock,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          // isLoading ? Loader() : Container(),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Map selectedDocotrIdData = {
                                          'selectedDocotrId':
                                              selectedDocotrId.toString(),
                                        };
                                        selectedDocotrId != "null"
                                            ? Navigator.pushNamed(
                                                context,
                                                RoutesName
                                                    .selectAppointmentDate,
                                                arguments: selectedDocotrIdData)
                                            // _navigateDateAndTimeSelaction(context)
                                            : Utils.snackBar(
                                                'Please Select a Doctor',
                                                context);

                                        ;
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        margin: EdgeInsets.all(5),
                                        color: Colors.white,
                                        // shadowColor: Colors.white,
                                        // // shape: RoundedRectangleBorder(
                                        // //     borderRadius: BorderRadius.all(Radius.circular(5))),
                                        // elevation: 10,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 12.h,
                                              width: 81.3.w,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 20),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, top: 10),
                                                      child: Text(
                                                        'Select Appointment Date',
                                                        // displayDate,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    // Container(
                                                    //   padding: EdgeInsets.only(
                                                    //       left: 10),
                                                    //   child: Text(
                                                    //     '',
                                                    //     // displayTimeSlot,
                                                    //     // style: TextStyle(
                                                    //     //     fontSize: 16,
                                                    //     //     fontWeight: FontWeight.w400),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFD5722),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8))),
                                              height: 12.h,
                                              width: 16.w,
                                              child: Icon(
                                                Icons.punch_clock,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.selectPatient);
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 5, right: 5, top: 5),
                                        color: Colors.white,
                                        shadowColor: Colors.white,
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.all(Radius.circular(5))),
                                        elevation: 10,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 12.h,
                                              width: 81.3.w,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 77.w,
                                                      padding: EdgeInsets.only(
                                                        left: 10,
                                                        top: 25,
                                                      ),
                                                      child: Text(
                                                        'Select Patient',
                                                        // 'Select Patient',
                                                        // displayPatientName,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    //
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFD5722),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8))),
                                              height: 12.h,
                                              width: 16.w,
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                                size: 30,
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
                                                // _bookAppointment();
                                              },
                                              child: Text(
                                                'BOOK APPOINTMENT',
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFFFD5722)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 5.h,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // setState(() {
                                                //   // displayDate = 'Select Appointment Date';
                                                //   // displayTimeSlot = '';
                                                //   // displaytimingId = '';
                                                //   // displayPatientName = 'Select Patient';
                                                //   // displayBirthDate = '';
                                                //   // displayGender = '';
                                                // });
                                              },
                                              child: Text('RESET'),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFFFD5722)),
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
          )),
    );
  }
}
