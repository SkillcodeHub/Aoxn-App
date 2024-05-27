import 'dart:async';

import 'package:axonweb/Res/Components/Appbar/screen_name_widget.dart';
import 'package:axonweb/Utils/utils.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late String displayDate;

  @override
  Widget build(BuildContext context) {
    token = widget.data['token'].toString();
    newsId = widget.data['newsId'].toString();
    newsDetailsViewmodel.fetchNewsDetailsListApi(
        context, token.toString(), newsId.toString());
    Future refresh() async {
      Timer(Duration(microseconds: 20), () {
        token = widget.data['token'].toString();
        newsId = widget.data['newsId'].toString();
        newsDetailsViewmodel.fetchNewsDetailsListApi(
            context, token.toString(), newsId.toString());
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: SizerUtil.deviceType == DeviceType.mobile
            ? Size.fromHeight(7.h)
            : Size.fromHeight(5.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
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
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenNameWidget(
                  title: '  Notice Board',
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
                  displayDate = widget.data['displayDate'].toString();

                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: isLoading
                                  ? isLoading
                                      ? Container()
                                      : Container()
                                  : Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 28,
                                              right: 8,
                                              bottom: 8,
                                              top: 8),
                                          alignment: Alignment.center,
                                          child: Text(
                                            newsDetailsViewmodel.newsDetailsList
                                                .data!.data!.title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: titleFontSize,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(displayDate.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: descriptionFontSize,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        SizedBox(height: 20),
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Html(
                                              data: newsDetailsViewmodel
                                                  .newsDetailsList
                                                  .data!
                                                  .data!
                                                  .description
                                                  .toString(),
                                              tagsList: Html.tags
                                                ..addAll(["bird", "flutter"]),
                                              onLinkTap: (url, _, __, ___) {
                                                // Check if the tapped link is associated with a YouTube video
                                                if (url != null &&
                                                    url.contains(
                                                        'youtube.com')) {
                                                  // Extract the video ID from the YouTube link
                                                  String videoId = YoutubePlayer
                                                          .convertUrlToId(
                                                              url) ??
                                                      '';
                                                  // Build the YouTube video URL
                                                  String youtubeVideoUrl =
                                                      'https://www.youtube.com/watch?v=$videoId';
                                                  // Open the YouTube video URL in the default browser
                                                  launch(youtubeVideoUrl);
                                                } else {
                                                  // If it's not a YouTube link, open the link in the default browser
                                                  launch(url!);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                        ),
                        isLoading ? Loader() : Container(),
                      ],
                    ),
                  );
              }
            },
          )),
    );
  }
}
