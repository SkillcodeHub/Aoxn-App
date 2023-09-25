import 'dart:async';
import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
import 'package:axonweb/view/Book/book_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Res/Components/Appbar/screen_name_widget.dart';
import '../../Res/colors.dart';
import '../../View_Model/SelectPateint_View_Model/getPatientByMobileNo_view_model.dart';
import '../../View_Model/SelectPateint_View_Model/selectPateintById_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../data/response/status.dart';

class SelectPatientScreen extends StatefulWidget {
  const SelectPatientScreen({super.key});

  @override
  State<SelectPatientScreen> createState() => _SelectPatientScreenState();
}

class _SelectPatientScreenState extends State<SelectPatientScreen> {
  TextEditingController strPatientId = TextEditingController();
  UserPreferences userPreference = UserPreferences();
  var token;
  var mobile;
  List patientById = [];
  String? registeredpatientBirth;
  String genderValue = "Male";
  bool _enableBtn = false;
  String? PatType;
  String? patientBirth;
  String CaseNo = "";
  String data = '';
  String date = '';
  final formKey = GlobalKey<FormState>();
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodeBirth = FocusNode();
  TextEditingController strName = TextEditingController();
  TextEditingController strBirthDate = TextEditingController();

  SelectPatientByIdViewmodel selectPatientByIdViewmodel =
      SelectPatientByIdViewmodel();

  GetPatientByMobileListViewmodel getPatientByMobileListViewmodel =
      GetPatientByMobileListViewmodel();
  SettingsViewModel settingsViewModel = SettingsViewModel();

  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value;
        print(token);
      });
    });
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1;
        print(token);
      });
    });

    // _newsRepository.fetchCustomerToken();
    super.initState();
  }

  createPatientListContainer(BuildContext context, int itemIndex) {
    String date = getPatientByMobileListViewmodel
        .GetPatientByMobileList.data!.data![itemIndex].patientDob
        .toString();

    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());

    var outputFormat5 = DateFormat('d-MMM-yyyy');

    var outputDate5 = outputFormat5.format(inputDate);
    registeredpatientBirth = outputDate5;
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    print(outputDate5);
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context, [
              getPatientByMobileListViewmodel
                  .GetPatientByMobileList.data!.data![itemIndex].patientName
                  .toString(),
              registeredpatientBirth,
              getPatientByMobileListViewmodel
                  .GetPatientByMobileList.data!.data![itemIndex].patientGender
                  .toString(),
              getPatientByMobileListViewmodel
                  .GetPatientByMobileList.data!.data![itemIndex].caseNo
                  .toString(),
              PatType = "Old",
            ]);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 25.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(getPatientByMobileListViewmodel
                            .GetPatientByMobileList
                            .data!
                            .data![itemIndex]
                            .caseNo
                            .toString()),
                        Container(
                          child: Icon(Icons.person),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getPatientByMobileListViewmodel
                            .GetPatientByMobileList
                            .data!
                            .data![itemIndex]
                            .patientName
                            .toString()),
                        SizedBox(
                          height: 10,
                        ),
                        Text(getPatientByMobileListViewmodel
                            .GetPatientByMobileList
                            .data!
                            .data![itemIndex]
                            .patientMobile
                            .toString()),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(registeredpatientBirth!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }

  _GetById() {
    print(token);
    print('strPatientId.text');
    print(strPatientId.text != "");
    print('strPatientId.text');
    strPatientId.text != ""
        ? [
            selectPatientByIdViewmodel.fetchSelectPatientByIdApi(
                token.toString(), strPatientId.text),
            patientById = [strPatientId.text]
          ]
        : [
            patientById.remove([]),
          ];
  }

  @override
  Widget build(BuildContext context) {
    final settingsViewModel =
        Provider.of<SettingsViewModel>(context, listen: false);
    Timer(
        Duration(microseconds: 20),
        () => [
              print('token.toString()'),
              print(token.toString()),
              print(mobile.toString()),
              print('mobile.toString()'),
              getPatientByMobileListViewmodel.fetchGetPatientByMobileListApi(
                  token.toString(), mobile.toString()),
              settingsViewModel.fetchDoctorDetailsListApi(token),
            ]);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: BackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenNameWidget(
                  title: 'Change Patient',
                ),
              ],
            ),
          ),
          bottom: TabBar(
            indicatorColor: Color(0xFFFD5722),
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'REGISTERED',
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Set the desired font size
                ),
              ),
              Tab(
                child: Text(
                  'UNREGISTERED',
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Set the desired font size
                ),
              ),
              Tab(
                child: Text(
                  'PATIENT ID',
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Set the desired font size
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChangeNotifierProvider<GetPatientByMobileListViewmodel>.value(
                value: getPatientByMobileListViewmodel,
                child: Consumer<GetPatientByMobileListViewmodel>(
                  builder: (context, value, _) {
                    switch (value.GetPatientByMobileList.status!) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return Center(
                            child: Text(value.GetPatientByMobileList.message
                                .toString()));
                      case Status.COMPLETED:
                        print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
                        print(getPatientByMobileListViewmodel
                            .GetPatientByMobileList.data!.data!.length);
                        print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
                        return Container(
                          child: Column(
                            children: [
                              getPatientByMobileListViewmodel
                                          .GetPatientByMobileList
                                          .data!
                                          .data!
                                          .length !=
                                      0
                                  ? ListView.builder(
                                      padding: EdgeInsets.only(bottom: 10),
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: getPatientByMobileListViewmodel
                                          .GetPatientByMobileList
                                          .data!
                                          .data!
                                          .length,
                                      itemBuilder: (BuildContext context,
                                          int itemIndex) {
                                        return createPatientListContainer(
                                            context, itemIndex);
                                      })
                                  : Container(
                                      height: 60.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text(
                                            'Swipe down to refresh page',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Container(
                                            height: 20.h,
                                            child: Image.asset(
                                                'images/loading.png'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 80.w,
                                            child: Text(
                                              "Oops. You haven't registered any patient yet.",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        );
                    }
                  },
                )),
            Stack(
              children: [
                ChangeNotifierProvider<SettingsViewModel>.value(
                  value: settingsViewModel,
                  child: Consumer<SettingsViewModel>(
                      builder: (context, value, child) {
                    switch (value.doctorDetailsList.status!) {
                      case Status.LOADING:
                        return ImageSkelton(
                          height: 26.h,
                          width: 100.w,
                        );

                      // Center(
                      //     child:
                      //         CircularProgressIndicator());
                      case Status.ERROR:
                        return Center(
                            child: Text(
                                value.doctorDetailsList.message.toString()));
                      case Status.COMPLETED:
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: settingsViewModel.doctorDetailsList.data!
                                        .data![0].paymentGatewayEnabled
                                        .toString() ==
                                    'false'
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // SizedBox(
                                      //   height: 30.h,
                                      // ),
                                      // Center(
                                      //   child: Text(
                                      //     'Plz Register Patient from Hospital!',
                                      //     textAlign: TextAlign.center,
                                      //     style: TextStyle(
                                      //       fontSize: 15.sp,
                                      //       color: Color(0XFF545454),
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Center(
                                        child: Text(
                                          'Add new Patient',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Color(0XFF545454),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Form(
                                          key: formKey,
                                          onChanged: () => setState(() =>
                                              _enableBtn = formKey.currentState!
                                                  .validate()),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                focusNode: _nodeName,
                                                controller: strName,
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (value) => value!
                                                        .isEmpty
                                                    ? "Please enter full name"
                                                    : null,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  hintText: 'Full Name',
                                                ),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Color(0XFF545454),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              TextFormField(
                                                focusNode: _nodeBirth,
                                                controller: strBirthDate,
                                                keyboardType:
                                                    TextInputType.text,
                                                // // validator: (value) => value.isEmpty
                                                //     ? "Please enter BirthDate"
                                                //     : null,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Birthday(optional)',
                                                ),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Color(0XFF545454),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          value: 'Male',
                                                          activeColor:
                                                              Color(0xFFFD5722),
                                                          groupValue:
                                                              genderValue,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              genderValue =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "Male",
                                                            style: TextStyle(
                                                              fontSize: 15.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 7.w,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          value: 'Female',
                                                          activeColor:
                                                              Color(0xFFFD5722),
                                                          groupValue:
                                                              genderValue,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              genderValue =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "Female",
                                                            style: TextStyle(
                                                              fontSize: 15.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Center(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 8, 0),
                                                  height: 5.h,
                                                  width: 55.w,
                                                  child: ElevatedButton(
                                                    onPressed: _enableBtn
                                                        ? () => Navigator.pop(
                                                                context, [
                                                              strName.text,
                                                              strBirthDate.text,
                                                              genderValue,
                                                              CaseNo = '0',
                                                              PatType = "New",
                                                            ])
                                                        : null,
                                                    child: Text(
                                                      'SAVE',
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Color(0xFFFD5722),
                                                      // shape: RoundedRectangleBorder(
                                                      //   borderRadius: BorderRadius.circular(
                                                      //       25), // <-- Radius
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Center(
                                        child: Text(
                                          'Plz Register Patient from Hospital!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Color(0XFF545454),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                    }
                  }),
                ),
              ],
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          onFieldSubmitted: (value) {
                            setState(() {
                              print(token);
                              strPatientId.text = value;
                              print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
                              print(value);
                              print(strPatientId.text);
                              print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
                              _GetById();
                              // selectPatientByIdViewmodel
                              //     .fetchSelectPatientByIdApi(
                              //         token.toString(), strPatientId.text);

                              print(patientById);
                            });
                          },
                          scrollPadding: EdgeInsets.only(bottom: 60),
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            errorMaxLines: 10,
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: ' Unique ID',
                            prefixIconConstraints:
                                BoxConstraints(maxHeight: 28, maxWidth: 28),
                            prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                )),
                          ),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0XFF545454),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          child: patientById.isNotEmpty
                              ? ChangeNotifierProvider<
                                      SelectPatientByIdViewmodel>.value(
                                  value: selectPatientByIdViewmodel,
                                  child: Consumer<SelectPatientByIdViewmodel>(
                                    builder: (context, value, child) {
                                      switch (value.SelectPatientById.status!) {
                                        case Status.LOADING:
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        case Status.ERROR:
                                          return Center(
                                            child: Text(
                                              value.SelectPatientById.message
                                                  .toString(),
                                            ),
                                          );
                                        case Status.COMPLETED:
                                          patientById =
                                              selectPatientByIdViewmodel
                                                  .SelectPatientById.data!.data!
                                                  .toList();

                                          List data1 =
                                              selectPatientByIdViewmodel
                                                  .SelectPatientById.data!.data!
                                                  .toList();
                                          print('data');
                                          print(data1);

                                          print('data');
                                          print(data1);

// convert date format
                                          print(data1.length);
                                          // data1.length > 0
                                          //     ? date =
                                          //         selectPatientByIdViewmodel
                                          //             .SelectPatientById
                                          //             .data!
                                          //             .data![0]
                                          //             .patientDob
                                          //             .toString()
                                          //     : date = '';
                                          if (data1.length > 0) {
                                            date = selectPatientByIdViewmodel
                                                .SelectPatientById
                                                .data!
                                                .data![0]
                                                .patientDob
                                                .toString();
                                            DateTime parseDate = new DateFormat(
                                                    "yyyy-MM-dd'T'HH:mm:ss")
                                                .parse(date);
                                            var inputDate = DateTime.parse(
                                                parseDate.toString());

                                            var outputFormat5 =
                                                DateFormat('d-MMM-yyyy');
                                            // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');

                                            var outputDate5 =
                                                outputFormat5.format(inputDate);
                                            patientBirth = outputDate5;
                                            print(
                                                '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
                                            print(outputDate5);
                                            print(
                                                '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
                                          } else {
                                            date = '';
                                          }

                                          // DateTime parseDate = new DateFormat(
                                          //         "yyyy-MM-dd'T'HH:mm:ss")
                                          //     .parse(date);
                                          // var inputDate = DateTime.parse(
                                          //     parseDate.toString());

                                          // var outputFormat5 =
                                          //     DateFormat('d-MMM-yyyy');
                                          // // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');

                                          // var outputDate5 =
                                          //     outputFormat5.format(inputDate);
                                          // patientBirth = outputDate5;
                                          // print(
                                          //     '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
                                          // print(outputDate5);
                                          // print(
                                          //     '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');

                                          return data1.length > 0
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context, [
                                                      // patientById[0]['patient_name'],
                                                      // patientBirth,
                                                      // patientById[0]['patient_gender'],
                                                      // patientById[0]['case_no'].toString(),

                                                      selectPatientByIdViewmodel
                                                          .SelectPatientById
                                                          .data!
                                                          .data![0]
                                                          .patientName
                                                          .toString(),
                                                      selectPatientByIdViewmodel
                                                          .SelectPatientById
                                                          .data!
                                                          .data![0]
                                                          .patientGender
                                                          .toString(),
                                                      patientBirth,
                                                      selectPatientByIdViewmodel
                                                          .SelectPatientById
                                                          .data!
                                                          .data![0]
                                                          .caseNo
                                                          .toString(),
                                                      PatType = "Old",
                                                    ]);
                                                  },
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 22.w,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  '# ' +
                                                                      selectPatientByIdViewmodel
                                                                          .SelectPatientById
                                                                          .data!
                                                                          .data![
                                                                              0]
                                                                          .caseNo
                                                                          .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 1.h,
                                                                ),
                                                                Container(
                                                                  height: 5.h,
                                                                  child: Image
                                                                      .asset(
                                                                          'images/selectPatient.png'),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: 60.w,
                                                                  child: Text(
                                                                    selectPatientByIdViewmodel
                                                                        .SelectPatientById
                                                                        .data!
                                                                        .data![
                                                                            0]
                                                                        .patientName
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                Text(
                                                                  selectPatientByIdViewmodel
                                                                      .SelectPatientById
                                                                      .data!
                                                                      .data![0]
                                                                      .patientMobile
                                                                      .toString()
                                                                      .replaceRange(
                                                                          0,
                                                                          10,
                                                                          'xxxxxxxxxx'),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                Text(
                                                                  patientBirth
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 60.h,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 20.h,
                                                        child: Image.asset(
                                                            'images/loading.png'),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Container(
                                                        width: 80.w,
                                                        child: Text(
                                                          'Please enter your Unique Id to search for Patients.',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                      }
                                    },
                                  ))
                              : Container(
                                  height: 60.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 20.h,
                                        child:
                                            Image.asset('images/loading.png'),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        width: 80.w,
                                        child: Text(
                                          'Please enter your Unique Id to search for Patients.',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
