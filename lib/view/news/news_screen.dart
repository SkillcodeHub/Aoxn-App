import 'dart:async';
import 'package:axonweb/Provider/backButton_provider.dart';
import 'package:axonweb/View_Model/NewsDetails_View_model/newsdetails_view_model.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Res/Components/Appbar/payment_widget.dart';
import '../../Res/colors.dart';
import '../../Utils/routes/routes_name.dart';
import '../../View_Model/News_View_Model/news_view_model.dart';
import '../../View_Model/News_View_Model/notification_services.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late String token;
  String? letId;

  UserPreferences userPreference = UserPreferences();
  String? newsdate;
  String deviceId = 'Unknown';
  late Future<void> fetchDataFuture;
  String _udid = 'Unknown';
  ButtonProvider buttonProvider = ButtonProvider();
  SettingsViewModel settingsViewModel = SettingsViewModel();
  // NewsViewmodel newsViewmodel = NewsViewmodel();
  NewsDetailsViewmodel newsDetailsViewmodel = NewsDetailsViewmodel();
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
        print(token);
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
    userPreference.getDeviceId().then((value) {
      setState(() {
        value!;
        print('value');
        print(value);
        print('value');
      });
    });
    setState(() {
      main();
    });

    super.initState();
    print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
    print(buttonProvider.backk);
    print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');

    initPlatformState();

    fetchDataFuture = fetchData(); // Call the API only once
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('device token');
      print(value);
    });
  }

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
      print('_udid_udid_udid_udid_udid_udid_udid_udid');
      print(_udid);
      print('_udid_udid_udid_udid_udid_udid_udid_udid');
      // userPreference.setDeviceId(_udid.toString());
    });
  }

  void main() async {
    // Retrieve the list
    List<String> retrievedList =
        await userPreference.getListFromSharedPreferences();
    print('Retrieved list from SharedPreferences:');
    print(retrievedList);
  }

  String _getFirstTwoLines(String description) {
    String trimmedDescription = description.trim();
    List<String> lines = trimmedDescription.split('\n');
    if (lines.length >= 2) {
      String firstLine = lines[0].trimLeft();
      String secondLine = lines[1].trimLeft();
      return '$firstLine\n$secondLine...';
    } else {
      return trimmedDescription;
    }
  }

  createNewsListContainer(BuildContext context, int index) {
    final newsViewmodel = Provider.of<NewsViewmodel>(context, listen: false);

    // final notificationObj = listOfColumns[itemIndex];
    String newsId = newsViewmodel.newsList.data!.data![index].newsId.toString();
    String discription = Bidi.stripHtmlIfNeeded(
        newsViewmodel.newsList.data!.data![index].description.toString());
    print(discription);

    String date =
        newsViewmodel.newsList.data!.data![index].displayDate.toString();

    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('E d-MMMM-yyyy');
    var outputFormat1 = DateFormat('E,yyyy');
    var outputFormat2 = DateFormat('d MMM');
    var outputFormat3 = DateFormat('hh:mm a');
    var outputFormat4 = DateFormat('d-MM-yyyy');
    var outputFormat5 = DateFormat('d-MMM-yyyy, hh:mm a');
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var outputDate1 = outputFormat1.format(inputDate);
    var outputDate2 = outputFormat2.format(inputDate);
    var outputDate3 = outputFormat3.format(inputDate);
    var outputDate4 = outputFormat4.format(inputDate);
    var outputDate5 = outputFormat5.format(inputDate);
    newsdate = outputDate5;
    // print(outputDate5);

    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        InkWell(
          onTap: () {
            // newsDetailsViewmodel.fetchNewsDetailsListApi(
            //     context, token, newsId);
            // print(token);
            // print(newsId);
            Map data = {'token': token.toString(), 'newsId': newsId};
            Navigator.pushNamed(context, RoutesName.newsdetails,
                arguments: data);
          },
          child: Card(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 10,
            child: Row(
              children: [
                Container(
                    height: 18.h,
                    // width: MediaQuery.of(context).size.width * 0.15,
                    width: 15.w,
                    color: Color(0xFFFD5722),
                    child: Center(
                      child: Image.asset(
                        'images/Iicon.png',
                        // width: 2,
                        height: 3.h,
                      ),
                    )),
                Container(
                  height: 18.h,
                  // width: MediaQuery.of(context).size.width * 0.79,
                  width:
                      SizerUtil.deviceType == DeviceType.mobile ? 78.w : 82.w,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          width: 85.w,
                          child: Text(
                            newsViewmodel.newsList.data!.data![index].title
                                .toString(),
                            style: TextStyle(
                                fontSize:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 14.sp
                                        : 11.sp,
                                fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          height: 7.h,
                          width: 85.w,
                          child: Html(
                            data: _getFirstTwoLines(newsViewmodel
                                    .newsList.data!.data![index].description
                                    .toString()
                                // .substring(0, 71)

                                ),
                            style: {
                              'h3': Style(
                                fontWeight: FontWeight
                                    .normal, // Remove bold style from h3 tag
                                fontStyle: FontStyle
                                    .normal, // Remove italic style from h3 tag
                                textDecoration: TextDecoration
                                    .none, // Remove underline style from h3 tag
                              ),
                              'b': Style(
                                fontWeight: FontWeight
                                    .normal, // Remove bold style from b tag
                              ),
                              'u': Style(
                                textDecoration: TextDecoration
                                    .none, // Remove underline style from u tag
                              ),
                              'p': Style(
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                                margin:
                                    EdgeInsets.zero, // Remove margin from p tag

                                fontWeight: FontWeight
                                    .normal, // Remove bold style from p tag
                                fontStyle: FontStyle
                                    .normal, // Remove italic style from p tag
                                textDecoration: TextDecoration
                                    .none, // Remove underline style from p tag
                              ),
                            },
                            customRender: {
                              'img': (RenderContext context, Widget child) {
                                if (context.tree.element!.attributes
                                    .containsKey('src')) {
                                  // Remove the substring limitation to include the entire image tag
                                  return Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 15,
                                      child: Image.asset('images/obj.png'));
                                }
                                return child;
                              },
                            },
                            onLinkTap: (url, _, __, ___) {
                              // Handle link tap here
                            },
                            onImageTap: (src, _, __, ___) {
                              // Handle image tap here
                            },
                            onImageError: (exception, stackTrace) {
                              // Handle image error here
                            },
                            // Add any additional properties or callbacks you require
                          ),
                        ),
                        SizedBox(
                            // height: 1.h,
                            ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                width: 65.w,
                                child: Text(
                                  newsdate!,
                                  style: TextStyle(
                                      fontSize: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 11.sp
                                          : 9.sp,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                // onTap: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => NewsDetails(
                                //               token,
                                //               newsData[itemIndex]['newsId'])));
                                // },
                                child: Container(
                                  width: 8.w,
                                  child: Icon(
                                    Icons.info_outline,
                                    size: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 2.5.h
                                        : 3.h,
                                  ),
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
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final newsViewmodel = Provider.of<NewsViewmodel>(context, listen: false);

      if (!newsViewmodel.loading) {
        newsViewmodel.setLoading(true);

        newsViewmodel.fetchNewsListApi(token, letId.toString());
      }
      final settingsViewModel =
          Provider.of<SettingsViewModel>(context, listen: false);

      if (!settingsViewModel.loading) {
        settingsViewModel.setLoading(true);

        settingsViewModel.fetchDoctorDetailsListApi(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ParthParthParth');
    final newsViewmodel = Provider.of<NewsViewmodel>(context, listen: false);
    final settingsViewModel =
        Provider.of<SettingsViewModel>(context, listen: false);

    // Timer(Duration(microseconds: 20), () {
    //   newsViewmodel.fetchNewsListApi(token);
    //   settingsViewModel.fetchDoctorDetailsListApi(token);
    // });
    // newsViewmodel.fetchNewsListApi(token);
    Future refresh() async {
      newsViewmodel.fetchNewsListApi(token, letId.toString());
    }

    settingsViewModel.setLoading1(false);
// print(object)
    // final doctorNameProvider =
    //     Provider.of<DoctorNameProvider>(context, listen: false);

    // doctorNameProvider.resetData();
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
        child: FutureBuilder<void>(
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
              return ChangeNotifierProvider<SettingsViewModel>.value(
                value: settingsViewModel,
                child: Consumer<SettingsViewModel>(
                  builder: (context, value, _) {
                    switch (value.doctorDetailsList.status!) {
                      case Status.LOADING:
                        return Center(child: Container());
                      case Status.ERROR:
                        return AppBar(
                          automaticallyImplyLeading: false,
                          // centerTitle: false,
                          backgroundColor: Color(0xffffffff),
                          elevation: 0,
                          title: Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AxonIconForAppBarrWidget(),
                                ScreenNameWidget(
                                  title: '  Notice Board',
                                ),
                                WhatsappWidget(),
                                SettingsWidget(),
                              ],
                            ),
                          ),
                        );

                      // Center(
                      //     child: Column(
                      //   children: [
                      //     Text(value.doctorDetailsList.message.toString()),
                      //   ],
                      // ));
                      case Status.COMPLETED:
                        return AppBar(
                          automaticallyImplyLeading: false,
                          // centerTitle: false,
                          backgroundColor: Color(0xffffffff),
                          elevation: 0,
                          title: Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AxonIconForAppBarrWidget(),
                                ScreenNameWidget(
                                  title: '  Notice Board',
                                ),
                                WhatsappWidget(),
                                SettingsWidget(),
                              ],
                            ),
                          ),
                        );
                    }
                  },
                ),
              );
            }
          },
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
            return ChangeNotifierProvider<NewsViewmodel>.value(
              value: newsViewmodel,
              child: Consumer<NewsViewmodel>(
                builder: (context, value, _) {
                  switch (value.newsList.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/loading.png',
                                height: 15.h,
                                // width: 90,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                value.newsList.message.toString(),
                                style: TextStyle(
                                  fontSize:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 14.sp
                                          : 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    case Status.COMPLETED:
                      return newsViewmodel.newsList.data!.data!.length != 0
                          ? RefreshIndicator(
                              onRefresh: refresh,
                              child: Container(
                                height: 100.h,
                                child: SingleChildScrollView(
                                  // Wrap with SingleChildScrollView
                                  physics:
                                      AlwaysScrollableScrollPhysics(), // Enable scrolling
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6, left: 4, right: 6),
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(bottom: 10),
                                      physics:
                                          NeverScrollableScrollPhysics(), // Disable scrolling
                                      shrinkWrap: true,
                                      itemCount:
                                          value.newsList.data!.data!.length,
                                      itemBuilder: (BuildContext context,
                                          int itemIndex) {
                                        return createNewsListContainer(
                                            context, itemIndex);
                                      },
                                    ),
                                  ),
                                ),
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
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.mobile
                                                        ? 14.sp
                                                        : 12.sp,
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
                                                'You  don\'t have any news or upcoming events',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.mobile
                                                        ? 14.sp
                                                        : 12.sp,
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
              ),
            );
          }
        },
      ),
    );
  }
}
