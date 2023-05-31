import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:provider/provider.dart';

import '../../Res/Components/loader.dart';
import '../../View_Model/NewsDetails_View_model/newsdetails_view_model.dart';

class NewsDetailsScreen extends StatefulWidget {
  final dynamic data;
  const NewsDetailsScreen({super.key, required this.data});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isLoading = false;
  NewsDetailsViewmodel newsDetailsViewmodel = NewsDetailsViewmodel();
  var token;
  var newsId;
  @override
  Widget build(BuildContext context) {
    token = widget.data['token'].toString();
    newsId = widget.data['newsId'].toString();
    newsDetailsViewmodel.fetchNewsDetailsListApi(
        context, token.toString(), newsId.toString());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "News Details",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<NewsDetailsViewmodel>(
          create: (BuildContext context) => newsDetailsViewmodel,
          child: Consumer<NewsDetailsViewmodel>(
            builder: (context, value, _) {
              switch (value.newsDetailsList.status!) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.newsDetailsList.message.toString()));
                case Status.COMPLETED:
                  return Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isLoading
                                ? isLoading
                                    ? Container()
                                    : Container()
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 28,
                                            right: 8,
                                            bottom: 8,
                                            top: 8),
                                        // alignment: Alignment.center,
                                        child: Text(
                                          // newsDetailsData["title"],
                                          newsDetailsViewmodel
                                              .newsDetailsList.data!.data!.title
                                              .toString(),
                                          // title,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        // newsDetailsData["displayDate"],
                                        newsDetailsViewmodel.newsDetailsList
                                            .data!.data!.displayDate
                                            .toString(),
                                      ),
                                      SizedBox(height: 20),
                                      Card(
                                        // color: Colors.amber,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Html(
                                            data: newsDetailsViewmodel
                                                .newsDetailsList
                                                .data!
                                                .data!
                                                .description
                                                .toString(),
                                            // newsDetailsData["description"],
                                          ),
                                          // Text(
                                          //   newsDetailsData["description"],
                                          //   style: TextStyle(
                                          //     fontSize: 15,
                                          //     fontWeight: FontWeight.normal,
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  )),
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



      // body: ChangeNotifierProvider<NewsDetailsViewmodel>(
      //     create: (BuildContext context) => newsDetailsViewmodel,
      //     child: Consumer<NewsDetailsViewmodel>(
      //       builder: (context, value, _) {
      //         switch (value.newsDetailsList.status!) {
      //           case Status.LOADING:
      //             return Center(child: CircularProgressIndicator());
      //           case Status.ERROR:
      //             return Center(
      //                 child: Text(value.newsDetailsList.message.toString()));
      //           case Status.COMPLETED:
      //             return Text('data');
      //         }
      //       },
      //     )),

 