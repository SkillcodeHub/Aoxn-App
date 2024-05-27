import 'dart:async';

import 'package:axonweb/Provider/backButton_provider.dart';
import 'package:axonweb/Utils/utils.dart';
import 'package:axonweb/View_Model/NewsDetails_View_model/newsdetails_view_model.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:upgrader/upgrader.dart';

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
  late String timeZoneName;

  ButtonProvider buttonProvider = ButtonProvider();
  SettingsViewModel settingsViewModel = SettingsViewModel();
  NewsDetailsViewmodel newsDetailsViewmodel = NewsDetailsViewmodel();
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
        print('token : $token');
      });
    });
    userPreference.getletId().then((value) {
      setState(() {
        letId = value!;
        print('letId : ${letId}');
      });
    });
    userPreference.getDeviceId().then((value) {
      setState(() {
        value!;
        print('value ${value}');
      });
    });
    setState(() {
      main();
    });

    super.initState();
    print(buttonProvider.backk);

    initPlatformState();
    tzdata.initializeTimeZones();

    fetchDataFuture = fetchData(); // Call the API only once
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('device token${value}');
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
      print('_udid_ : ${_udid}');
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

  String mapTimeZone(String timeZoneName) {
    switch (timeZoneName) {
      case "International Date Line West":
        return "Pacific/Midway";
      case "Midway Island":
        return "Pacific/Midway";
      case "Samoa":
        return "Pacific/Apia";
      case "Dateline Standard Time":
        return "Etc/GMT+12";
      case "UTC-11":
        return "Pacific/Midway";
      case "Hawaiian Standard Time":
        return "Pacific/Honolulu";
      case "Alaskan Standard Time":
        return "America/Anchorage";
      case "Pacific Standard Time":
        return "America/Los_Angeles";
      case "Mountain Standard Time":
        return "America/Denver";
      case "Mountain Standard Time (Mexico)":
        return "America/Chihuahua";
      case "US Mountain Standard Time":
        return "America/Phoenix";
      case "Canada Central Standard Time":
        return "America/Regina";
      case "Central America Standard Time":
        return "America/Guatemala";
      case "Central Standard Time":
        return "America/Chicago";
      case "Eastern Standard Time":
        return "America/New_York";
      case "SA Pacific Standard Time":
        return "America/Bogota";
      case "US Eastern Standard Time":
        return "America/Indianapolis";
      case "Venezuela Standard Time":
        return "America/Caracas";
      case "Atlantic Standard Time":
        return "America/Halifax";
      case "Central Brazilian Standard Time":
        return "America/Cuiaba";
      case "Pacific SA Standard Time":
        return "America/Santiago";
      case "Paraguay Standard Time":
        return "America/Asuncion";
      case "SA Western Standard Time":
        return "America/La_Paz";
      case "Newfoundland Standard Time":
        return "America/St_Johns";
      case "Bahia Standard Time":
        return "America/Bahia";
      case "Argentina Standard Time":
        return "America/Buenos_Aires";
      case "E. South America Standard Time":
        return "America/Sao_Paulo";
      case "Greenland Standard Time":
        return "America/Godthab";
      case "Montevideo Standard Time":
        return "America/Montevideo";
      case "SA Eastern Standard Time":
        return "America/Cayenne";
      case "UTC-02":
        return "America/Noronha";
      case "Azores Standard Time":
        return "Atlantic/Azores";
      case "Cape Verde Standard Time":
        return "Atlantic/Cape_Verde";
      case "GMT Standard Time":
        return "Europe/London";
      case "Greenwich Standard Time":
        return "Atlantic/Reykjavik";
      case "Morocco Standard Time":
        return "Africa/Casablanca";
      case "UTC":
        return "Etc/UTC";
      case "Central Europe Standard Time":
        return "Europe/Budapest";
      case "Central European Standard Time":
        return "Europe/Warsaw";
      case "Namibia Standard Time":
        return "Africa/Windhoek";
      case "Romance Standard Time":
        return "Europe/Paris";
      case "W. Central Africa Standard Time":
        return "Africa/Lagos";
      case "W. Europe Standard Time":
        return "Europe/Berlin";
      case "Egypt Standard Time":
        return "Africa/Cairo";
      case "FLE Standard Time":
        return "Europe/Kiev";
      case "GTB Standard Time":
        return "Europe/Bucharest";
      case "Israel Standard Time":
        return "Asia/Jerusalem";
      case "Libya Standard Time":
        return "Africa/Tripoli";
      case "Middle East Standard Time":
        return "Asia/Beirut";
      case "South Africa Standard Time":
        return "Africa/Johannesburg";
      case "Syria Standard Time":
        return "Asia/Damascus";
      case "Turkey Standard Time":
        return "Europe/Istanbul";
      case "Arab Standard Time":
        return "Asia/Riyadh";
      case "Arabic Standard Time":
        return "Asia/Baghdad";
      case "Belarus Standard Time":
        return "Europe/Minsk";
      case "E. Africa Standard Time":
        return "Africa/Nairobi";
      case "Jordan Standard Time":
        return "Asia/Amman";
      case "Kaliningrad Standard Time":
        return "Europe/Kaliningrad";
      case "Iran Standard Time":
        return "Asia/Tehran";
      case "Arabian Standard Time":
        return "Etc/GMT-4";
      case "Azerbaijan Standard Time":
        return "Asia/Baku";
      case "Caucasus Standard Time":
        return "Asia/Yerevan";
      case "Georgian Standard Time":
        return "Asia/Tbilisi";
      case "Mauritius Standard Time":
        return "Indian/Mauritius";
      case "Russia Time Zone 3":
        return "Europe/Samara";
      case "Russian Standard Time":
        return "Europe/Moscow";
      case "Afghanistan Standard Time":
        return "Asia/Kabul";
      case "Pakistan Standard Time":
        return "Asia/Karachi";
      case "West Asia Standard Time":
        return "Asia/Tashkent";
      case "India Standard Time":
        return "Asia/Kolkata";
      case "Sri Lanka Standard Time":
        return "Asia/Colombo";
      case "Nepal Standard Time":
        return "Asia/Kathmandu";
      case "Bangladesh Standard Time":
        return "Asia/Dhaka";
      case "Central Asia Standard Time":
        return "Asia/Almaty";
      case "Ekaterinburg Standard Time":
        return "Asia/Yekaterinburg";
      case "Myanmar Standard Time":
        return "Asia/Rangoon";
      case "SE Asia Standard Time":
        return "Asia/Bangkok";
      case "N. Central Asia Standard Time":
        return "Asia/Novosibirsk";
      case "China Standard Time":
        return "Asia/Shanghai";
      case "North Asia Standard Time":
        return "Asia/Krasnoyarsk";
      case "Singapore Standard Time":
        return "Asia/Singapore";
      case "Taipei Standard Time":
        return "Asia/Taipei";
      case "Ulaanbaatar Standard Time":
        return "Asia/Ulaanbaatar";
      case "W. Australia Standard Time":
        return "Australia/Perth";
      case "Korea Standard Time":
        return "Asia/Seoul";
      case "North Asia East Standard Time":
        return "Asia/Irkutsk";
      case "Tokyo Standard Time":
        return "Asia/Tokyo";
      case "AUS Central Standard Time":
        return "Australia/Darwin";
      case "Cen. Australia Standard Time":
        return "Australia/Adelaide";
      case "AUS Eastern Standard Time":
        return "Australia/Sydney";
      case "E. Australia Standard Time":
        return "Australia/Brisbane";
      case "Tasmania Standard Time":
        return "Australia/Hobart";
      case "West Pacific Standard Time":
        return "Pacific/Port_Moresby";
      case "Yakutsk Standard Time":
        return "Asia/Yakutsk";
      case "Central Pacific Standard Time":
        return "Pacific/Guadalcanal";
      case "Vladivostok Standard Time":
        return "Asia/Vladivostok";
      case "Fiji Standard Time":
        return "Pacific/Fiji";
      case "Magadan Standard Time":
        return "Asia/Magadan";
      case "New Zealand Standard Time":
        return "Pacific/Auckland";
      case "Tonga Standard Time":
        return "Pacific/Tongatapu";
      case "Line Islands Standard Time":
        return "Pacific/Kiritimati";
      default:
        return timeZoneName;
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
    DateTime utcTime = DateTime.parse("${date}Z");

    // Manually map "India Standard Time" to "Asia/Kolkata"
    String timeZoneIdentifier = mapTimeZone(timeZoneName);

    // Load the local time zone
    final location = tz.getLocation(timeZoneIdentifier);
    if (location == null) {
      throw ArgumentError(
          'Location with the name "$timeZoneIdentifier" doesn\'t exist.');
    }
    // Convert UTC time to local time
    tz.TZDateTime localTime = tz.TZDateTime.from(utcTime, location);

    // Format the local time
    String formattedLocalTime =
        DateFormat('dd-MMM-yyyy, hh:mm a').format(localTime);

    newsdate = formattedLocalTime;

    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        InkWell(
          onTap: () {
            if (int.parse(newsId) >= 0) {
              Map data = {
                'token': token.toString(),
                'newsId': newsId,
                'displayDate': formattedLocalTime
              };
              Navigator.pushNamed(context, RoutesName.newsdetails,
                  arguments: data);
            }
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
                    width: 15.w,
                    color: Color(0xFFFD5722),
                    child: Center(
                      child: newsViewmodel
                                  .newsList.data!.data![index].description
                                  .toString() !=
                              ""
                          ? Image.asset(
                              'images/Iicon.png',
                              // width: 2,
                              height: 3.h,
                            )
                          : Icon(Icons.remove_circle,
                              color: Colors.white, size: 3.7.h),
                    )),
                newsViewmodel.newsList.data!.data![index].description
                            .toString() !=
                        ""
                    ? Container(
                        height: 18.h,
                        width: 78.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                width: 85.w,
                                child: Text(
                                  newsViewmodel
                                      .newsList.data!.data![index].title
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w500),
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
                                  data: _getFirstTwoLines(newsViewmodel.newsList
                                          .data!.data![index].description
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
                                      margin: EdgeInsets
                                          .zero, // Remove margin from p tag

                                      fontWeight: FontWeight
                                          .normal, // Remove bold style from p tag
                                      fontStyle: FontStyle
                                          .normal, // Remove italic style from p tag
                                      textDecoration: TextDecoration
                                          .none, // Remove underline style from p tag
                                    ),
                                  },
                                  customRender: {
                                    'img':
                                        (RenderContext context, Widget child) {
                                      if (context.tree.element!.attributes
                                          .containsKey('src')) {
                                        // Remove the substring limitation to include the entire image tag
                                        return Container(
                                            margin: EdgeInsets.only(top: 10),
                                            height: 15,
                                            child:
                                                Image.asset('images/obj.png'));
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      width: 65.w,
                                      child: Text(
                                        newsdate!,
                                        style: TextStyle(
                                            fontSize: descriptionFontSize,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        width: 8.w,
                                        child: Icon(
                                          Icons.info_outline,
                                          size: 2.5.h
                                          // : 3.h
                                          ,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: 17.h,
                        width: 78.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                width: 85.w,
                                child: Text(
                                  newsViewmodel
                                      .newsList.data!.data![index].title
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 4,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                  // height: 1.h,
                                  ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      width: 65.w,
                                      child: Text(
                                        newsdate!,
                                        style: TextStyle(
                                            fontSize: descriptionFontSize,

                                            // 11.sp,

                                            fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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

    Future refresh() async {
      newsViewmodel.fetchNewsListApi(token, letId.toString());
    }

    settingsViewModel.setLoading1(false);
    return UpgradeAlert(
      upgrader: Upgrader(
        canDismissDialog: false,
        showLater: false,
        showIgnore: false,
        showReleaseNotes: false,
      ),
      child: Scaffold(
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
                          return AppBar(
                            automaticallyImplyLeading: false,
                            // centerTitle: false,
                            backgroundColor: Color(0xffffffff),
                            elevation: 0,
                            title: Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AxonIconForAppBarrWidget(),
                                  ScreenNameWidget(
                                    title: '  Notice Board',
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(6),
                                    height: 4.h,
                                    width: 5.h,
                                    // child: Image.asset('images/whatsapp.png'),
                                  ),
                                  SettingsWidget(),
                                ],
                              ),
                            ),
                          );

                        case Status.ERROR:
                          return AppBar(
                            automaticallyImplyLeading: false,
                            // centerTitle: false,
                            backgroundColor: Color(0xffffffff),
                            elevation: 0,
                            title: Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AxonIconForAppBarrWidget(),
                                  ScreenNameWidget(
                                    title: '  Notice Board',
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(6),
                                    height: 4.h,
                                    width: 5.h,
                                    // child: Image.asset('images/whatsapp.png'),
                                  ),
                                  SettingsWidget(),
                                ],
                              ),
                            ),
                          );

                        case Status.COMPLETED:
                          timeZoneName = settingsViewModel
                              .doctorDetailsList.data!.data![0].timeZoneId
                              .toString();

                          return AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Color(0xffffffff),
                            elevation: 0,
                            title: Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AxonIconForAppBarrWidget(),
                                  ScreenNameWidget(
                                    title: '  Notice Board',
                                  ),
                                  value.doctorDetailsList.data!.data![0]
                                              .whatsapplink
                                              .toString() ==
                                          "null"
                                      ? Container()
                                      : WhatsappWidget(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Center(
                                          child: Text(
                                            value.newsList.message.toString(),
                                            style: TextStyle(
                                                fontSize: titleFontSize,
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
                        return ChangeNotifierProvider<SettingsViewModel>.value(
                          value: settingsViewModel,
                          child: Consumer<SettingsViewModel>(
                            builder: (context, value, _) {
                              switch (value.doctorDetailsList.status!) {
                                case Status.LOADING:
                                  return Center(
                                      child: CircularProgressIndicator());
                                case Status.ERROR:
                                  return RefreshIndicator(
                                    onRefresh: refresh,
                                    child: Stack(
                                      children: [
                                        SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
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
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Center(
                                                    child: Image.asset(
                                                      'images/loading.png',
                                                      height: 20.h,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      value.doctorDetailsList
                                                          .message
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              titleFontSize,
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

                                case Status.COMPLETED:
                                  timeZoneName = settingsViewModel
                                      .doctorDetailsList
                                      .data!
                                      .data![0]
                                      .timeZoneId
                                      .toString();

                                  return newsViewmodel
                                              .newsList.data!.data!.length !=
                                          0
                                      ? RefreshIndicator(
                                          onRefresh: refresh,
                                          child: Container(
                                            height: 100.h,
                                            child: SingleChildScrollView(
                                              physics:
                                                  AlwaysScrollableScrollPhysics(), // Enable scrolling
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6, left: 4, right: 6),
                                                child: ListView.builder(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  physics:
                                                      NeverScrollableScrollPhysics(), // Disable scrolling
                                                  shrinkWrap: true,
                                                  itemCount: newsViewmodel
                                                      .newsList
                                                      .data!
                                                      .data!
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
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
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                child: Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Container(
                                                    height: 74.h,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Text(
                                                          'Swipe down to refresh page',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize:
                                                                titleFontSize,
                                                            color: Color(
                                                                0XFF545454),
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                            'You don\'t have any news or upcoming events',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    titleFontSize,
                                                                color: Color(
                                                                    0XFF545454),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
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
          },
        ),
      ),
    );
  }
}
