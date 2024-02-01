import 'dart:async';

import 'package:axonweb/Res/Components/Appbar/screen_name_widget.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
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

    // print(outputDate5);
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
                // Text(
                //   "News Details",
                //   style: TextStyle(
                //     color: Colors.black,
                //     // fontWeight: FontWeight.bold,
                //     fontSize: 22,
                //   ),
                // ),
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
                  String date = newsDetailsViewmodel
                      .newsDetailsList.data!.data!.displayDate
                      .toString();
                  DateTime parseDate =
                      new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
                  var inputDate = DateTime.parse(parseDate.toString());
                  var outputFormat5 = DateFormat('d-MMM-yyyy, hh:mm a');
                  var outputDate5 = outputFormat5.format(inputDate);
                  displayDate = outputDate5;
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
                                            // title,
                                            style: TextStyle(
                                                fontSize:

                                                    // SizerUtil.deviceType ==
                                                    //         DeviceType.mobile
                                                    //     ?
                                                    14.sp
                                                // : 11.sp
                                                ,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        // SizedBox(height: 10),
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
                                                  fontSize:

                                                      // SizerUtil.deviceType ==
                                                      //         DeviceType.mobile
                                                      //     ?
                                                      11.sp
                                                  // : 8.sp
                                                  ,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        SizedBox(height: 20),
                                        // Card(
                                        //   child: Padding(
                                        //     padding: EdgeInsets.all(12.0),
                                        //     child: Html(
                                        //         data: newsDetailsViewmodel
                                        //             .newsDetailsList
                                        //             .data!
                                        //             .data!
                                        //             .description
                                        //             .toString(),
                                        //         tagsList: Html.tags
                                        //           ..addAll(["bird", "flutter"]),
                                        //         onLinkTap: (url, _, __, ___) {
                                        //           launch(url!);
                                        //         }),
                                        //   ),
                                        // ),
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

//      class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text('flutter_html Example'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Html(
//           data: htmlData,
//           tagsList: Html.tags..addAll(["bird", "flutter"]),
//           style: {
//             "table": Style(
//               backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
//             ),
//             "tr": Style(
//               border: Border(bottom: BorderSide(color: Colors.grey)),
//             ),
//             "th": Style(
//               padding: EdgeInsets.all(6),
//               backgroundColor: Colors.grey,
//             ),
//             "td": Style(
//               padding: EdgeInsets.all(6),
//               alignment: Alignment.topLeft,
//             ),
//             'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
//           },
//           customRender: {
//             "table": (context, child) {
//               return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child:
//                     (context.tree as TableLayoutElement).toWidget(context),
//               );
//             },
//             "bird": (RenderContext context, Widget child) {
//               return TextSpan(text: "🐦");
//             },
//             "flutter": (RenderContext context, Widget child) {
//               return FlutterLogo(
//                 style: (context.tree.element!.attributes['horizontal'] != null)
//                     ? FlutterLogoStyle.horizontal
//                     : FlutterLogoStyle.markOnly,
//                 textColor: context.style.color!,
//                 size: context.style.fontSize!.size! * 5,
//               );
//             },
//           },
//           customImageRenders: {
//             networkSourceMatcher(domains: ["flutter.dev"]):
//                 (context, attributes, element) {
//               return FlutterLogo(size: 36);
//             },
//             networkSourceMatcher(domains: ["mydomain.com"]):
//                 networkImageRender(
//               headers: {"Custom-Header": "some-value"},
//               altWidget: (alt) => Text(alt ?? ""),
//               loadingWidget: () => Text("Loading..."),
//             ),
//             // On relative paths starting with /wiki, prefix with a base url
//             (attr, _) =>
//                     attr["src"] != null && attr["src"]!.startsWith("/wiki"):
//                 networkImageRender(
//                     mapUrl: (url) => "https://upload.wikimedia.org" + url!),
//             // Custom placeholder image for broken links
//             networkSourceMatcher():
//                 networkImageRender(altWidget: (_) => FlutterLogo()),
//           },
//           onLinkTap: (url, _, __, ___) {
//             print("Opening $url...");
//           },
//           onImageTap: (src, _, __, ___) {
//             print(src);
//           },
//           onImageError: (exception, stackTrace) {
//             print(exception);
//           },
//           onCssParseError: (css, messages) {
//             print("css that errored: $css");
//             print("error messages:");
//             messages.forEach((element) {
//               print(element);
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
