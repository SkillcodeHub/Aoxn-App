import 'dart:async';

import 'package:axonweb/View_Model/NewsDetails_View_model/newsdetails_view_model.dart';
import 'package:axonweb/data/response/status.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Res/colors.dart';
import '../../Utils/routes/routes_name.dart';
import '../../View_Model/News_View_Model/news_view_model.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/payment_widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';
import '../../view_model/services/SharePreference/SharePreference.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late String token;
  UserPreferences userPreference = UserPreferences();
  String? newsdate;

  NewsViewmodel newsViewmodel = NewsViewmodel();
  NewsDetailsViewmodel newsDetailsViewmodel = NewsDetailsViewmodel();
  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
        print(token);
      });
    });

    // _newsRepository.fetchCustomerToken();
    super.initState();
  }

  createNewsListContainer<NewsViewmodel>(BuildContext context, int index) {
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
    var outputFormat5 = DateFormat('d-MMM-yyyy,hh:mm a');
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
          height: 3,
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
                  height: 17.h,
                  width: MediaQuery.of(context).size.width * 0.15,
                  color: Color(0xFFFD5722),
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Container(
                  height: 17.h,
                  width: MediaQuery.of(context).size.width * 0.79,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 0, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 90.w,
                          child: Text(
                            newsViewmodel.newsList.data!.data![index].title
                                .toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          width: 85.w,
                          child: Text(
                            discription,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 65.w,
                                child: Text(
                                  newsdate!,
                                  style: TextStyle(
                                      fontSize: 11.sp,
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
                                  child: Icon(Icons.info_outline),
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

  @override
  Widget build(BuildContext context) {
    Timer(Duration(microseconds: 20),
        () => newsViewmodel.fetchNewsListApi(token));
    // newsViewmodel.fetchNewsListApi(token);
    Future refresh() async {
      newsViewmodel.fetchNewsListApi(token);
    }

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
                  title: '  Notice Board',
                ),
                WhatsappWidget(),
                // PaymentWidget(),
                SettingsWidget(),
              ],
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<NewsViewmodel>(
          create: (BuildContext context) => newsViewmodel,
          child: Consumer<NewsViewmodel>(
            builder: (context, value, _) {
              switch (value.newsList.status!) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.newsList.message.toString()));
                case Status.COMPLETED:
                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6, left: 4, right: 6),
                      child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 10),
                          physics: BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: value.newsList.data!.data!.length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return createNewsListContainer(context, itemIndex);
                          }),
                    ),
                  );
              }
            },
          )),
    );
  }
}
