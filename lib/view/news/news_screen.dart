import 'package:axonweb/data/response/status.dart';
import 'package:axonweb/repository/Get_Repository/repository.dart';
import 'package:axonweb/view_model/services/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/payment_widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';
import '../../res/components/appbar/settings_widget.dart';
import '../../res/components/appbar/whatsapp_widget.dart';
import '../../view_model/provider_view_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String token = '68cb311f-585a-4e86-8e89-06edf1814080';
  String token1 = '68cb311f-585a-4e86-8e89-06edf1814080';
  String token2 = '68cb311f-585a-4e86-8e89-06edf1814080';

  NewsViewmodel newsViewmodel = NewsViewmodel();
  @override
  void initState() {
    // _newsRepository.fetchCustomerToken();
    newsViewmodel.fetchNewsListApi(token);
    super.initState();
  }

  createNewsListContainer<NewsViewmodel>(BuildContext context, int index) {
    // final notificationObj = listOfColumns[itemIndex];

    // String parsedstring3 =
    //     Bidi.stripHtmlIfNeeded(newsData[itemIndex]["description"]);
    // print(parsedstring3);

    // String date = newsData[itemIndex]['displayDate'];

    // DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    // var inputDate = DateTime.parse(parseDate.toString());
    // var outputFormat = DateFormat('E d-MMMM-yyyy');
    // var outputFormat1 = DateFormat('E,yyyy');
    // var outputFormat2 = DateFormat('d MMM');
    // var outputFormat3 = DateFormat('hh:mm a');
    // var outputFormat4 = DateFormat('d-MM-yyyy');
    // var outputFormat5 = DateFormat('d-MMM-yyyy,hh:mm a');
    // // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    // var outputDate = outputFormat.format(inputDate);
    // var outputDate1 = outputFormat1.format(inputDate);
    // var outputDate2 = outputFormat2.format(inputDate);
    // var outputDate3 = outputFormat3.format(inputDate);
    // var outputDate4 = outputFormat4.format(inputDate);
    // var outputDate5 = outputFormat5.format(inputDate);
    // newsdate = outputDate5;
    // print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    // print(outputDate);
    // print(outputDate1);
    // print(outputDate2);
    // print(outputDate3);
    // print(outputDate4);
    // print(outputDate5);
    // // print(patientBirth);
    // print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    return Column(
      children: [
        InkWell(
          // onTap: () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) =>
          //               NewsDetails(token, newsData[itemIndex]['newsId'])));
          // },
          child: Card(
            margin: EdgeInsets.all(5),
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 10,
            child: Row(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.15,
                  color: Color(0xFFFD5722),
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Container(
                  // width: 291,
                  width: MediaQuery.of(context).size.width * 0.79,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.82,
                          // width: 280,
                          child: Text(
                            newsViewmodel.newsList.data!.data![index].title
                                .toString(),
                            // 'Why 100% PCR Testing Required?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          // width: 270,
                          // child: Html(
                          //   data: newsData[itemIndex]["description"],
                          //   // shrinkWrap: ,
                          // ),
                          child: Text(
                            newsViewmodel
                                .newsList.data!.data![index].description
                                .toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.67,
                                // width: 170,
                                child: Text(
                                  newsViewmodel
                                      .newsList.data!.data![index].displayDate
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
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
    final userPrefernce = Provider.of<GetProviderTokenViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                PaymentWidget(),
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
      body: ChangeNotifierProvider<NewsViewmodel>(
          create: (BuildContext context) => newsViewmodel,
          child: Consumer<NewsViewmodel>(
            builder: (context, value, child) {
              switch (value.newsList.status!) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.newsList.message.toString()));
                case Status.COMPLETED:
                  // return ListView.builder(
                  //     itemCount: value.newsList.data!.data!.length,
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //         child: ListTile(
                  //             title: Text(value
                  //                 .newsList.data!.data![index].title
                  //                 .toString())),
                  //       );
                  //     });

                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: 10),
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.newsList.data!.data!.length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return createNewsListContainer(context, itemIndex);
                      });
              }
              return Container();
            },
          )),
    );
  }
}
