// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:sizer/sizer.dart';

// // // class MyProvider1 extends ChangeNotifier {
// // //   String textValue1 = 'Text 1';
// // //   String textValue2 = 'Text 2';

// // //   void updateTextValues(String newValue1, String newValue2) {
// // //     textValue1 = newValue1;
// // //     textValue2 = newValue2;
// // //     notifyListeners();
// // //   }
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     print('aaaaaaa');
// // //     final myProvider = Provider.of<MyProvider1>(context, listen: false);
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       home: Scaffold(
// // //         appBar: AppBar(
// // //           title: Text('Text Values'),
// // //         ),
// // //         body: Center(
// // //           child: Column(
// // //             children: [
// // //               Consumer<MyProvider1>(
// // //                 builder: (context, myProvider, _) {
// // //                   return Column(
// // //                     mainAxisAlignment: MainAxisAlignment.center,
// // //                     children: [
// // //                       Text(
// // //                         myProvider.textValue1,
// // //                         style: TextStyle(fontSize: 24),
// // //                       ),
// // //                       SizedBox(height: 20),
// // //                       Text(
// // //                         myProvider.textValue2,
// // //                         style: TextStyle(fontSize: 24),
// // //                       ),
// // //                       SizedBox(height: 20),
// // //                     ],
// // //                   );
// // //                 },
// // //               ),
// // //               Consumer<MyProvider1>(
// // //                 builder: (context, myProvider, _) {
// // //                   return Column(
// // //                     mainAxisAlignment: MainAxisAlignment.center,
// // //                     children: [
// // //                       Text(
// // //                         myProvider.textValue1,
// // //                         style: TextStyle(fontSize: 24),
// // //                       ),
// // //                       SizedBox(height: 20),
// // //                       Text(
// // //                         myProvider.textValue2,
// // //                         style: TextStyle(fontSize: 24),
// // //                       ),
// // //                       SizedBox(height: 20),
// // //                       ElevatedButton(
// // //                         onPressed: () {
// // //                           print('object');
// // //                           Future.delayed(Duration.zero, () {
// // //                             myProvider.updateTextValues(
// // //                               'New Value 1 ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
// // //                               'New Value 2',
// // //                             );
// // //                           });
// // //                         },
// // //                         child: Text('Update Values'),
// // //                       ),
// // //                     ],
// // //                   );
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:googleapis_auth/auth.dart' as auth;
// // // import 'package:googleapis/calendar/v3.dart' as calendar;
// // // import 'package:googleapis_auth/auth_io.dart';
// // // import 'package:url_launcher/url_launcher.dart';

// // // void main() => runApp(MyApp());

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Google Calendar API Demo',
// // //       home: CalendarPage(),
// // //     );
// // //   }
// // // }

// // // class CalendarPage extends StatefulWidget {
// // //   @override
// // //   _CalendarPageState createState() => _CalendarPageState();
// // // }

// // // class _CalendarPageState extends State<CalendarPage> {
// // //   late auth.AutoRefreshingAuthClient _client;
// // //   late calendar.CalendarApi _calendarApi;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initGoogleAuth();
// // //   }

// // //   void _initGoogleAuth() async {
// // //     final credentials = auth.ClientId(
// // //       '807773773685-tmao5nfmugs973gsg2v92hq9b0k5bh0f.apps.googleusercontent.com',
// // //       'YOUR_CLIENT_SECRET',
// // //     );

// // //     final scopes = [calendar.CalendarApi.calendarScope];

// // //     _client = await clientViaUserConsent(credentials, scopes, _promptUser);

// // //     _calendarApi = calendar.CalendarApi(_client);
// // //   }

// // //   void _promptUser(String authorizationUrl) async {
// // //     if (await canLaunch(authorizationUrl)) {
// // //       await launch(authorizationUrl);
// // //     } else {
// // //       throw Exception('Could not launch authorization URL');
// // //     }
// // //   }

// // //   void _addEventToCalendar() async {
// // //     final newEvent = calendar.Event()
// // //       ..summary = 'Sample Event'
// // //       ..description = 'This is a test event added via Google Calendar API'
// // //       ..start = calendar.EventDateTime(dateTime: DateTime.now())
// // //       ..end = calendar.EventDateTime(
// // //           dateTime: DateTime.now().add(Duration(hours: 2)));

// // //     await _calendarApi.events.insert(newEvent, 'primary');
// // //     print('Event added to calendar!');
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (_client == null) {
// // //       return Scaffold(body: Center(child: CircularProgressIndicator()));
// // //     } else {
// // //       return Scaffold(
// // //         appBar: AppBar(title: Text('Google Calendar API Demo')),
// // //         body: Center(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               ElevatedButton(
// // //                 onPressed: _addEventToCalendar,
// // //                 child: Text('Add Event to Calendar'),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       );
// // //     }
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:googleapis_auth/auth_io.dart' as auth;
// // import 'package:googleapis/calendar/v3.dart' as calendar;

// // class CalendarPage extends StatefulWidget {
// //   @override
// //   _CalendarPageState createState() => _CalendarPageState();
// // }

// // class _CalendarPageState extends State<CalendarPage> {
// //   GoogleSignIn _googleSignIn = GoogleSignIn(
// //     scopes: [calendar.CalendarApi.calendarScope],
// //   );

// //   late calendar.CalendarApi _calendarApi;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initGoogleAuth();
// //   }

// //   void _initGoogleAuth() async {
// //     final isSignedIn = await _googleSignIn.isSignedIn();
// //     if (!isSignedIn) {
// //       await _googleSignIn.signIn();
// //     }

// //     final authHeaders = await _googleSignIn.currentUser!.authHeaders;
// //     final authClient =
// //         auth.autoRefreshingClient(auth.ClientId('', ''), authHeaders);

// //     _calendarApi = calendar.CalendarApi(authClient);
// //   }

// //   void _addEventToCalendar() async {
// //     final newEvent = calendar.Event()
// //       ..summary = 'Sample Event'
// //       ..description = 'This is a test event added via Google Calendar API'
// //       ..start = calendar.EventDateTime(dateTime: DateTime.now())
// //       ..end = calendar.EventDateTime(
// //           dateTime: DateTime.now().add(Duration(hours: 2)));

// //     await _calendarApi.events.insert(newEvent, 'primary');
// //     print('Event added to calendar!');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Google Calendar API Demo')),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             ElevatedButton(
// //               onPressed: _addEventToCalendar,
// //               child: Text('Add Event to Calendar'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:axonweb/Res/Components/Appbar/whatsapp_widget.dart';
// import 'package:axonweb/res/components/appbar/screen_name_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// import 'res/components/appbar/axonimage_appbar-widget.dart';

// class Appbarrwidget extends StatefulWidget {
//   const Appbarrwidget({super.key});

//   @override
//   State<Appbarrwidget> createState() => _AppbarrwidgetState();
// }

// class _AppbarrwidgetState extends State<Appbarrwidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: CustomScrollView(
//     slivers: <Widget>[
//       //2
//       SliverAppBar(
//   pinned: true,   // Set to true to keep the app bar static
//   floating: false,  // Set to false to prevent it from floating
//   snap: false,   // Set to false to prevent snap behavior
//   stretch: false,   // Set to false to prevent stretch behavior
//   expandedHeight: 250.0,
//   title: ,
//   flexibleSpace: FlexibleSpaceBar(
//     title: Text('Goa', textScaleFactor: 1),
//     background: Image.asset(
//       'assets/images/beach.png',
//       fit: BoxFit.fill,
//     ),
//   ),
// )

//       //3
//       // SliverList(
//       //   delegate: SliverChildBuilderDelegate(
//       //     (_, int index) {
//       //       return ListTile(
//       //         leading: Container(
//       //             padding: EdgeInsets.all(8),
//       //             width: 100,
//       //             child: Placeholder()),
//       //         title: Text('Place ${index + 1}', textScaleFactor: 2),
//       //       );
//       //     },
//       //     childCount: 20,
//       //   ),
//       // ),
    
//     ],
//   ),
    
    
//     // CustomScrollView(
//     //   Ch: SliverAppBar(
//     //     expandedHeight: 180.0,
//     //     backgroundColor: const Color(0xFF9e0118),
//     //     iconTheme: IconThemeData(color: Colors.white),
//     //     floating: true,
//     //     pinned: true,
//     //     flexibleSpace: FlexibleSpaceBar(
//     //       collapseMode: CollapseMode.pin,
//     //       centerTitle: true,
//     //       background: Column(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         crossAxisAlignment: CrossAxisAlignment.center,
//     //         children: <Widget>[
//     //           Container(
//     //               margin: EdgeInsets.only(top: 16.0),
//     //               padding: EdgeInsets.only(left: 32.0, right: 32.0),
//     //               child: Text(
//     //                 'Some text',
//     //                 textAlign: TextAlign.center,
//     //                 style: TextStyle(
//     //                     color: Colors.white,
//     //                     fontFamily: 'PlayfairDisplay',
//     //                     fontStyle: FontStyle.italic,
//     //                     fontSize: 16.0),
//     //               )),
//     //           Container(
//     //               margin: EdgeInsets.only(top: 16.0),
//     //               padding: EdgeInsets.only(left: 32.0, right: 32.0),
//     //               child: Text(
//     //                 'some text',
//     //                 textAlign: TextAlign.center,
//     //                 style: TextStyle(
//     //                     color: Colors.white,
//     //                     fontFamily: 'PlayfairDisplay',
//     //                     fontSize: 16.0),
//     //               )),
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // ),
//     // AppBar(
//     //                       flexibleSpace: ,
//     //                       automaticallyImplyLeading: false,
//     //                       backgroundColor: Colors.amber,
//     //                       elevation: 0,
//     //                       title: Padding(
//     //                         padding:  EdgeInsets.only(top: 2.0),
//     //                         child: Row(
//     //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                           children: [
//     //                             AxonIconForAppBarrWidget(),
//     //                             ScreenNameWidget(
//     //                               title: '  Notice Board',
//     //                             ),
//     //                             WhatsappWidget(),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     )
//                          );
//   }
// }