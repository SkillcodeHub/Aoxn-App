// import 'package:axonweb/Utils/routes/routes_name.dart';
// import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:axonweb/data/response/status.dart';
// import 'package:sizer/sizer.dart';

// import '../../Res/Components/Appbar/screen_name_widget.dart';
// import '../../Res/Components/loader.dart';
// import '../../Res/colors.dart';
// import '../../View_Model/Services/SharePreference/SharePreference.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   UserPreferences userPreference = UserPreferences();
//   SettingsViewModel settingsViewModel = SettingsViewModel();
//   var mobile;
//   late String token;

//   bool isLoading = false;

//   @override
//   void initState() {
//     userPreference.getMobile().then((value1) {
//       setState(() {
//         mobile = value1;
//       });
//     });

//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//       });
//     });
//     setState(() {});
//     // super.initState();
//     super.initState();
//   }

//   //Logout Alert
//   showAlertDialog(BuildContext context) async {
//     // set up the button
//     Widget okButton = Column(
//       children: [
//         SizedBox(
//           width: (MediaQuery.of(context).size.width * 0.90),
//           height: 40,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFFFD5722),
//               foregroundColor: Colors.white,
//               textStyle: TextStyle(color: Color(0xFFFD5722), fontSize: 18),
//               // shape: RoundedRectangleBorder(
//               //   borderRadius: BorderRadius.circular(25), // <-- Radius
//               // ),
//             ),
//             child: Text("Confirm"),
//             onPressed: () {
//               userPreference.logoutProcess();
//               Navigator.pushNamedAndRemoveUntil(
//                   context, RoutesName.login, (route) => false);
//             },
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         )
//       ],
//     );

//     Widget cancelButton = Column(
//       children: [
//         SizedBox(
//           width: (MediaQuery.of(context).size.width * 0.90),
//           height: 40,
//           child: OutlinedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               // foregroundColor: Colors.white,
//               textStyle: TextStyle(color: Color(0xFFFD5722), fontSize: 18),
//               // shape: RoundedRectangleBorder(
//               //   borderRadius: BorderRadius.circular(25), // <-- Radius
//               // ),
//             ),
//             onPressed: () {
//               Navigator.of(context, rootNavigator: true).pop();
//             },
//             child: Text(
//               "Cancel",
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         )
//       ],
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(
//         "Logout",
//         textAlign: TextAlign.center,
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       content: Text("Are you sure you want to logout?"),
//       // shape: RoundedRectangleBorder(
//       //   borderRadius: BorderRadius.circular(30),
//       // ),
//       actions: [okButton, cancelButton],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     settingsViewModel.fetchDoctorDetailsListApi(token);

//     print(token);

//     return Scaffold(
//       backgroundColor: BackgroundColor,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: false,
//           backgroundColor: Color(0xffffffff),
//           elevation: 0,
//           leading: Padding(
//             padding: EdgeInsets.only(top: 5.0),
//             child: IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_rounded),
//             ),
//           ),
//           title: Padding(
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ScreenNameWidget(
//                   title: 'Settings',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: ChangeNotifierProvider<SettingsViewModel>(
//           create: (BuildContext context) => settingsViewModel,
//           child: Consumer<SettingsViewModel>(
//             builder: (context, value, child) {
//               switch (value.doctorDetailsList.status!) {
//                 case Status.LOADING:
//                   return Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return Center(
//                       child: Text(value.doctorDetailsList.message.toString()));
//                 case Status.COMPLETED:
//                   return Stack(
//                     children: [
//                       SingleChildScrollView(
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: isLoading
//                               ? isLoading
//                                   ? Container()
//                                   : Container()
//                               : Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Card(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Provider',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.grey.shade600),
//                                             ),
//                                             SizedBox(height: 5),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Container(
//                                                   // width: MediaQuery.of(context).size.width * 0.68,
//                                                   child: Row(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         backgroundImage:
//                                                             NetworkImage(
//                                                           settingsViewModel
//                                                               .doctorDetailsList
//                                                               .data!
//                                                               .data![0]
//                                                               .customerLogo
//                                                               .toString(),
//                                                           // customerData[0]['customerLogo'],
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Container(
//                                                         width: 52.w,
//                                                         child: Text(
//                                                           settingsViewModel
//                                                               .doctorDetailsList
//                                                               .data!
//                                                               .data![0]
//                                                               .customerName
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                             fontSize: 12.sp,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                           maxLines: 1,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),

//                                                 // SizedBox(
//                                                 //   width: 109,
//                                                 // ),
//                                                 //
//                                                 Container(
//                                                   height: 30,
//                                                   child: ElevatedButton(
//                                                     onPressed: () {
//                                                       Navigator.pushNamed(
//                                                           context,
//                                                           RoutesName
//                                                               .changeProvider);
//                                                     },
//                                                     child: Text('CHANGE'),
//                                                     style: ElevatedButton
//                                                         .styleFrom(
//                                                       backgroundColor:
//                                                           Color(0xFFFD5722),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: 5),
//                                             Container(
//                                               width: 70.w,
//                                               child: Text(
//                                                 settingsViewModel
//                                                     .doctorDetailsList
//                                                     .data!
//                                                     .data![0]
//                                                     .customerAddress
//                                                     .toString(),
//                                                 // customerData[0]['customerAddress'],
//                                                 style: TextStyle(
//                                                   fontSize: 12.sp,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Card(
//                                       color: Colors.white,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Your login as',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.grey.shade600),
//                                             ),
//                                             SizedBox(height: 10),
//                                             // Text(
//                                             //   'PARTH',
//                                             //   style: TextStyle(fontWeight: FontWeight.w500),
//                                             // ),
//                                             SizedBox(height: 5),
//                                             Text(
//                                               mobile.replaceRange(
//                                                   0, 7, 'xxxxxxx'),
//                                               style: TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Container(
//                                                   // width: MediaQuery.of(context).size.width * 0.68,
//                                                   height: 2,
//                                                 ),
//                                                 Container(
//                                                   height: 30,
//                                                   child: ElevatedButton(
//                                                     onPressed: () {
//                                                       showAlertDialog(context);
//                                                     },
//                                                     child: Text(
//                                                       'LOGOUT',
//                                                     ),
//                                                     style: ElevatedButton
//                                                         .styleFrom(
//                                                       backgroundColor:
//                                                           Color(0xFFFD5722),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: 3),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                         ),
//                       ),
//                       isLoading ? Loader() : Container(),
//                     ],
//                   );
//               }
//             },
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:axonweb/Utils/routes/routes_name.dart';
import 'package:axonweb/View_Model/Settings_View_Model/settings_view_model.dart';
import 'package:axonweb/data/response/status.dart';
import 'package:sizer/sizer.dart';

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
    settingsViewModel.fetchDoctorDetailsListApi(token);
    print(age);
    print(name);
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
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
                return Center(
                    child: Text(value.doctorDetailsList.message.toString()));
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
                                            'Provider',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          SizedBox(height: 5),
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
                                                      width: 52.w,
                                                      child: Text(
                                                        settingsViewModel
                                                            .doctorDetailsList
                                                            .data!
                                                            .data![0]
                                                            .customerName
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
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
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutesName
                                                            .changeProvider);
                                                  },
                                                  child: Text('CHANGE'),
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
                                                fontSize: 12.sp,
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
                                  SizedBox(height: 5),
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
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(height: 5),
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
                                                    Text(name),
                                                    Text(
                                                      mobile.replaceRange(
                                                          0, 7, 'xxxxxxx'),
                                                      style: TextStyle(
                                                        fontSize: 17,
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
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showAlertDialog(context);
                                                  },
                                                  child: Text('LOGOUT'),
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
