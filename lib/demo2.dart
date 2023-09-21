// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sizer/sizer.dart';

// // class MyProvider1 extends ChangeNotifier {
// //   String textValue1 = 'Text 1';
// //   String textValue2 = 'Text 2';

// //   void updateTextValues(String newValue1, String newValue2) {
// //     textValue1 = newValue1;
// //     textValue2 = newValue2;
// //     notifyListeners();
// //   }
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     print('aaaaaaa');
// //     final myProvider = Provider.of<MyProvider1>(context, listen: false);
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Text Values'),
// //         ),
// //         body: Center(
// //           child: Column(
// //             children: [
// //               Consumer<MyProvider1>(
// //                 builder: (context, myProvider, _) {
// //                   return Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         myProvider.textValue1,
// //                         style: TextStyle(fontSize: 24),
// //                       ),
// //                       SizedBox(height: 20),
// //                       Text(
// //                         myProvider.textValue2,
// //                         style: TextStyle(fontSize: 24),
// //                       ),
// //                       SizedBox(height: 20),
// //                     ],
// //                   );
// //                 },
// //               ),
// //               Consumer<MyProvider1>(
// //                 builder: (context, myProvider, _) {
// //                   return Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         myProvider.textValue1,
// //                         style: TextStyle(fontSize: 24),
// //                       ),
// //                       SizedBox(height: 20),
// //                       Text(
// //                         myProvider.textValue2,
// //                         style: TextStyle(fontSize: 24),
// //                       ),
// //                       SizedBox(height: 20),
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           print('object');
// //                           Future.delayed(Duration.zero, () {
// //                             myProvider.updateTextValues(
// //                               'New Value 1 ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
// //                               'New Value 2',
// //                             );
// //                           });
// //                         },
// //                         child: Text('Update Values'),
// //                       ),
// //                     ],
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:googleapis_auth/auth.dart' as auth;
// // import 'package:googleapis/calendar/v3.dart' as calendar;
// // import 'package:googleapis_auth/auth_io.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // void main() => runApp(MyApp());

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Google Calendar API Demo',
// //       home: CalendarPage(),
// //     );
// //   }
// // }

// // class CalendarPage extends StatefulWidget {
// //   @override
// //   _CalendarPageState createState() => _CalendarPageState();
// // }

// // class _CalendarPageState extends State<CalendarPage> {
// //   late auth.AutoRefreshingAuthClient _client;
// //   late calendar.CalendarApi _calendarApi;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initGoogleAuth();
// //   }

// //   void _initGoogleAuth() async {
// //     final credentials = auth.ClientId(
// //       '807773773685-tmao5nfmugs973gsg2v92hq9b0k5bh0f.apps.googleusercontent.com',
// //       'YOUR_CLIENT_SECRET',
// //     );

// //     final scopes = [calendar.CalendarApi.calendarScope];

// //     _client = await clientViaUserConsent(credentials, scopes, _promptUser);

// //     _calendarApi = calendar.CalendarApi(_client);
// //   }

// //   void _promptUser(String authorizationUrl) async {
// //     if (await canLaunch(authorizationUrl)) {
// //       await launch(authorizationUrl);
// //     } else {
// //       throw Exception('Could not launch authorization URL');
// //     }
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
// //     if (_client == null) {
// //       return Scaffold(body: Center(child: CircularProgressIndicator()));
// //     } else {
// //       return Scaffold(
// //         appBar: AppBar(title: Text('Google Calendar API Demo')),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               ElevatedButton(
// //                 onPressed: _addEventToCalendar,
// //                 child: Text('Add Event to Calendar'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:googleapis/calendar/v3.dart' as calendar;

// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [calendar.CalendarApi.calendarScope],
//   );

//   late calendar.CalendarApi _calendarApi;

//   @override
//   void initState() {
//     super.initState();
//     _initGoogleAuth();
//   }

//   void _initGoogleAuth() async {
//     final isSignedIn = await _googleSignIn.isSignedIn();
//     if (!isSignedIn) {
//       await _googleSignIn.signIn();
//     }

//     final authHeaders = await _googleSignIn.currentUser!.authHeaders;
//     final authClient =
//         auth.autoRefreshingClient(auth.ClientId('', ''), authHeaders);

//     _calendarApi = calendar.CalendarApi(authClient);
//   }

//   void _addEventToCalendar() async {
//     final newEvent = calendar.Event()
//       ..summary = 'Sample Event'
//       ..description = 'This is a test event added via Google Calendar API'
//       ..start = calendar.EventDateTime(dateTime: DateTime.now())
//       ..end = calendar.EventDateTime(
//           dateTime: DateTime.now().add(Duration(hours: 2)));

//     await _calendarApi.events.insert(newEvent, 'primary');
//     print('Event added to calendar!');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Google Calendar API Demo')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _addEventToCalendar,
//               child: Text('Add Event to Calendar'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
