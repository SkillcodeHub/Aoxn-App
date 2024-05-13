import 'package:axonweb/Provider/backButton_provider.dart';
import 'package:axonweb/Utils/routes/routes_name.dart';
import 'package:axonweb/Utils/utils.dart';
import 'package:axonweb/View/PaymentHistory/payment_history_screen.dart';
import 'package:axonweb/View_Model/ChangeProvider_View_Model/provider_view_model.dart';
import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Res/Components/Appbar/screen_name_widget.dart';
import '../../Res/Components/loader.dart';
import '../../Res/colors.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  CustomerTkenViewmodel customerTkenViewmodel = CustomerTkenViewmodel();
  UserPreferences userPreference = UserPreferences();
  SettingsViewModel settingsViewModel = SettingsViewModel();
  late String mobile;
  late String token;
  late String name;
  late String age;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // FirebaseCrashlytics.instance.crash();

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
    userPreference.getName().then((value) {
      setState(() {
        name = value!;
      });
    });
    userPreference.getAge().then((value) {
      setState(() {
        age = value!;
      });
    });
  }

  //Logout Alert
  void showAlertDialog(BuildContext context) async {
    final buttonProvider = Provider.of<ButtonProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Logout",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Are you sure you want to logout?"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFD5722),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                buttonProvider.setBack(false);
                userPreference.logoutProcess();
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesName.login, (route) => false);
              },
              child: Text("Confirm"),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonProvider = Provider.of<ButtonProvider>(context, listen: false);

    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');

    print(buttonProvider.backk);
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    settingsViewModel.fetchDoctorDetailsListApi(token);

    Future refresh() async {
      settingsViewModel.fetchDoctorDetailsListApi(token);
    }

    print(age);
    print(name);
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
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
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenNameWidget(
                  title: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<SettingsViewModel>(
        create: (BuildContext context) => settingsViewModel,
        child: Consumer<SettingsViewModel>(
          builder: (context, value, child) {
            switch (value.doctorDetailsList.status!) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return RefreshIndicator(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Center(
                                  child: Image.asset(
                                    'images/loading.png',
                                    height: 20.h,
                                    // width: 90,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Center(
                                  child: Text(
                                    value.doctorDetailsList.message.toString(),
                                    style: TextStyle(
                                        fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? titleFontSize
                                            : 12.sp,
                                        fontWeight: FontWeight.w500),
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

              case Status.COMPLETED:
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: isLoading
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Doctor',
                                            style: TextStyle(
                                              fontSize: SizerUtil.deviceType ==
                                                      DeviceType.mobile
                                                  ? descriptionFontSize
                                                  : 8.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        settingsViewModel
                                                            .doctorDetailsList
                                                            .data!
                                                            .data![0]
                                                            .customerLogo
                                                            .toString(),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Container(
                                                      width: 45.w,
                                                      child: Text(
                                                        settingsViewModel
                                                            .doctorDetailsList
                                                            .data!
                                                            .data![0]
                                                            .customerName
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: SizerUtil
                                                                      .deviceType ==
                                                                  DeviceType
                                                                      .mobile
                                                              ? subTitleFontSize
                                                              : 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 4.h,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    buttonProvider
                                                        .setBack(true);
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutesName
                                                            .changeProvider);
                                                  },
                                                  child: Text('CHANGE',
                                                      style: SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  subTitleFontSize)
                                                          : TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 8.sp)),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFFFD5722),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            width: 70.w,
                                            child: Text(
                                              settingsViewModel
                                                  .doctorDetailsList
                                                  .data!
                                                  .data![0]
                                                  .customerAddress
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? subTitleFontSize
                                                        : 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Your Payment Details',
                                            style: TextStyle(
                                              fontSize: SizerUtil.deviceType ==
                                                      DeviceType.mobile
                                                  ? descriptionFontSize
                                                  : 8.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Row(
                                            children: [
                                              Container(
                                                height: 5.h,
                                                child: Icon(
                                                  Icons.history,
                                                  size: 4.h,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Container(
                                                child: Text(
                                                  ' Payment History',
                                                  style: TextStyle(
                                                      fontSize: SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? subTitleFontSize
                                                          : 11.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(height: 2),
                                              Container(
                                                height: 4.h,
                                                width: SizerUtil.deviceType ==
                                                        DeviceType.mobile
                                                    ? 25.w
                                                    : 14.w,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PaymentHistory()));
                                                  },
                                                  child: Text('VIEW',
                                                      style: SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  subTitleFontSize)
                                                          : TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 8.sp)),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFFFD5722),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Your login as',
                                            style: TextStyle(
                                              fontSize: SizerUtil.deviceType ==
                                                      DeviceType.mobile
                                                  ? descriptionFontSize
                                                  : 8.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Row(
                                            children: [
                                              Container(
                                                  height: 4.h,
                                                  child: age == 'Male'
                                                      ? Image.asset(
                                                          'images/male.png')
                                                      : Image.asset(
                                                          'images/female.png')),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      name,
                                                      style: TextStyle(
                                                        fontSize:
                                                            subTitleFontSize,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      mobile.replaceRange(
                                                          0, 7, 'xxxxxxx'),
                                                      style: TextStyle(
                                                        fontSize:
                                                            subTitleFontSize,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(height: 2),
                                              Container(
                                                height: 4.h,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showAlertDialog(context);
                                                  },
                                                  child: Text('LOGOUT',
                                                      style: SizerUtil
                                                                  .deviceType ==
                                                              DeviceType.mobile
                                                          ? TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  subTitleFontSize)
                                                          : TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 8.sp)),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFFFD5722),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Learn how we process your data in our ',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: Color(0xFFFD5722),
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                final url =
                                                    'https://app.axonsoftwares.net/privacy_policy.html';
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
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
        ),
      ),
    );
  }
}
