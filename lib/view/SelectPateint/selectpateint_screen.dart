import 'dart:async';

import 'package:axonweb/Utils/utils.dart';
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
  late Future<void> fetchDataFuture;

  SelectPatientByIdViewmodel selectPatientByIdViewmodel =
      SelectPatientByIdViewmodel();

  GetPatientByMobileListViewmodel getPatientByMobileListViewmodel =
      GetPatientByMobileListViewmodel();
  SettingsViewModel settingsViewModel = SettingsViewModel();

  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1;
      });
    });

    super.initState();
    fetchDataFuture = fetchData(); // Call the API only once
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final settingsViewModel =
          Provider.of<SettingsViewModel>(context, listen: false);
      Timer(
          Duration(microseconds: 20),
          () => [
                getPatientByMobileListViewmodel.fetchGetPatientByMobileListApi(
                    token.toString(), mobile.toString()),
                settingsViewModel.fetchDoctorDetailsListApi(token),
              ]);
    });
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
                        Text(
                            getPatientByMobileListViewmodel
                                .GetPatientByMobileList
                                .data!
                                .data![itemIndex]
                                .caseNo
                                .toString(),
                            style: TextStyle(
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? subTitleFontSize
                                      : 10.sp,
                              fontWeight: FontWeight.w500,
                            )),
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
                        Text(
                            getPatientByMobileListViewmodel
                                .GetPatientByMobileList
                                .data!
                                .data![itemIndex]
                                .patientName
                                .toString(),
                            style: TextStyle(
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? subTitleFontSize
                                      : 10.sp,
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                            getPatientByMobileListViewmodel
                                .GetPatientByMobileList
                                .data!
                                .data![itemIndex]
                                .patientMobile
                                .toString(),
                            style: TextStyle(
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? subTitleFontSize
                                      : 10.sp,
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(registeredpatientBirth!,
                            style: TextStyle(
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? subTitleFontSize
                                      : 10.sp,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _GetById() {
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
            padding: EdgeInsets.only(top: 2),
            child: IconButton(
              iconSize: SizerUtil.deviceType == DeviceType.mobile ? 2.5.h : 3.h,
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 2.0),
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
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? descriptionFontSize
                          : 7.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Set the desired font size
                ),
              ),
              Tab(
                child: Text(
                  'UNREGISTERED',
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? descriptionFontSize
                          : 7.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Set the desired font size
                ),
              ),
              Tab(
                child: Text(
                  'PATIENT ID',
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? descriptionFontSize
                          : 7.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Set the desired font size
                ),
              ),
            ],
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
              return TabBarView(
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
                                  child: Text(value
                                      .GetPatientByMobileList.message
                                      .toString()));
                            case Status.COMPLETED:
                              return Container(
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      getPatientByMobileListViewmodel
                                                  .GetPatientByMobileList
                                                  .data!
                                                  .data!
                                                  .length !=
                                              0
                                          ? ListView.builder(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  getPatientByMobileListViewmodel
                                                      .GetPatientByMobileList
                                                      .data!
                                                      .data!
                                                      .length,
                                              itemBuilder:
                                                  (BuildContext context,
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
                                                        fontSize:
                                                            subTitleFontSize,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                                                          fontSize:
                                                              subTitleFontSize,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
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

                            case Status.ERROR:
                              return Center(
                                  child: Text(value.doctorDetailsList.message
                                      .toString()));
                            case Status.COMPLETED:
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: settingsViewModel
                                              .doctorDetailsList
                                              .data!
                                              .data![0]
                                              .paymentGatewayEnabled
                                              .toString() ==
                                          'false'
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Center(
                                              child: Text(
                                                'Add new Patient',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: headerFontSize,
                                                  color: Color(0XFF545454),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Form(
                                                key: formKey,
                                                onChanged: () => setState(() =>
                                                    _enableBtn = formKey
                                                        .currentState!
                                                        .validate()),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
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
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Full Name',
                                                      ),
                                                      style: TextStyle(
                                                        fontSize:
                                                            subTitleFontSize,
                                                        color:
                                                            Color(0XFF545454),
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Birthday(optional)',
                                                      ),
                                                      style: TextStyle(
                                                        fontSize:
                                                            subTitleFontSize,
                                                        color:
                                                            Color(0XFF545454),
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                                activeColor: Color(
                                                                    0xFFFD5722),
                                                                groupValue:
                                                                    genderValue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    genderValue =
                                                                        value!;
                                                                  });
                                                                },
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  "Male",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        titleFontSize,
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
                                                                activeColor: Color(
                                                                    0xFFFD5722),
                                                                groupValue:
                                                                    genderValue,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    genderValue =
                                                                        value!;
                                                                  });
                                                                },
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  "Female",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        titleFontSize,
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
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 0, 8, 0),
                                                        height: 5.h,
                                                        width: 55.w,
                                                        child: ElevatedButton(
                                                          onPressed: _enableBtn
                                                              ? () =>
                                                                  Navigator.pop(
                                                                      context, [
                                                                    strName
                                                                        .text,
                                                                    strBirthDate
                                                                        .text,
                                                                    genderValue,
                                                                    CaseNo =
                                                                        '0',
                                                                    PatType =
                                                                        "New",
                                                                  ])
                                                              : null,
                                                          child: Text(
                                                            'SAVE',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    subTitleFontSize,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xFFFD5722),
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
                                              height: 15.h,
                                            ),
                                            Center(
                                              child: Column(children: [
                                                Text(
                                                  "To book an appointment, you need to be a registered patient.Please visit our hospital in person to complete your registration.Once you're registered,you'll be able to easily book appointments through the app.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? titleFontSize
                                                        : 13.sp,
                                                    color: Color(0XFF545454),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  'Thank you.',
                                                  style: TextStyle(
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? titleFontSize
                                                        : 13.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ]),
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
                            children: [
                              TextFormField(
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    strPatientId.text = value;
                                    _GetById();
                                  });
                                },
                                scrollPadding: EdgeInsets.only(bottom: 60),
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  errorMaxLines: 10,
                                  contentPadding: const EdgeInsets.all(10.0),
                                  hintText: ' Unique ID',
                                  prefixIconConstraints: BoxConstraints(
                                      maxHeight: 28, maxWidth: 28),
                                  prefixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      )),
                                ),
                                style: TextStyle(
                                  fontSize:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? subTitleFontSize
                                          : 10.sp,
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
                                        child: Consumer<
                                            SelectPatientByIdViewmodel>(
                                          builder: (context, value, child) {
                                            switch (value
                                                .SelectPatientById.status!) {
                                              case Status.LOADING:
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              case Status.ERROR:
                                                return Center(
                                                  child: Text(
                                                    value.SelectPatientById
                                                        .message
                                                        .toString(),
                                                  ),
                                                );
                                              case Status.COMPLETED:
                                                patientById =
                                                    selectPatientByIdViewmodel
                                                        .SelectPatientById
                                                        .data!
                                                        .data!
                                                        .toList();

                                                List data1 =
                                                    selectPatientByIdViewmodel
                                                        .SelectPatientById
                                                        .data!
                                                        .data!
                                                        .toList();

                                                if (data1.length > 0) {
                                                  date =
                                                      selectPatientByIdViewmodel
                                                          .SelectPatientById
                                                          .data!
                                                          .data![0]
                                                          .patientDob
                                                          .toString();
                                                  DateTime parseDate =
                                                      new DateFormat(
                                                              "yyyy-MM-dd'T'HH:mm:ss")
                                                          .parse(date);
                                                  var inputDate =
                                                      DateTime.parse(
                                                          parseDate.toString());

                                                  var outputFormat5 =
                                                      DateFormat('d-MMM-yyyy');

                                                  var outputDate5 =
                                                      outputFormat5
                                                          .format(inputDate);
                                                  patientBirth = outputDate5;
                                                } else {
                                                  date = '';
                                                }

                                                return data1.length > 0
                                                    ? InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context, [
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
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                                            selectPatientByIdViewmodel.SelectPatientById.data!.data![0].caseNo.toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              subTitleFontSize,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            1.h,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            5.h,
                                                                        child: Image.asset(
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
                                                                        width:
                                                                            60.w,
                                                                        child:
                                                                            Text(
                                                                          selectPatientByIdViewmodel
                                                                              .SelectPatientById
                                                                              .data!
                                                                              .data![0]
                                                                              .patientName
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                                                                ? subTitleFontSize
                                                                                : 10.sp,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      Text(
                                                                        selectPatientByIdViewmodel
                                                                            .SelectPatientById
                                                                            .data!
                                                                            .data![
                                                                                0]
                                                                            .patientMobile
                                                                            .toString()
                                                                            .replaceRange(
                                                                                0,
                                                                                7,
                                                                                'xxxxxxx'),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                                                                              ? subTitleFontSize
                                                                              : 10.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      Text(
                                                                        patientBirth
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize: SizerUtil.deviceType == DeviceType.mobile
                                                                              ? subTitleFontSize
                                                                              : 10.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
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
                                                                    fontSize: SizerUtil.deviceType ==
                                                                            DeviceType
                                                                                .mobile
                                                                        ? titleFontSize
                                                                        : 12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? titleFontSize
                                                        : 12.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              );
            }
          },
        ),
      ),
    );
  }
}
