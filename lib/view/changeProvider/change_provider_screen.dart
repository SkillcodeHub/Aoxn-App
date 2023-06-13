// import 'package:flutter/material.dart';
// import '../../Res/colors.dart';
// import '../../View_Model/News_View_Model/news_view_model.dart';
// import '../../view_model/services/SharePreference/SharePreference.dart';

// class ChangeProviderScreen extends StatefulWidget {
//   const ChangeProviderScreen({super.key});

//   @override
//   State<ChangeProviderScreen> createState() => _ChangeProviderScreenState();
// }

// class _ChangeProviderScreenState extends State<ChangeProviderScreen> {
//   final FocusNode _nodeAppcode = FocusNode();
//   TextEditingController strAppcode = TextEditingController();
//   UserPreferences userPreference = UserPreferences();
//   late String mobile;
//   CustomerTkenViewmodel customerTkenViewmodel = CustomerTkenViewmodel();
//   List<String> providerList = [];
//   @override
//   void initState() {
//     setState(() {
//       main();
//     });
//     // _newsRepository.fetchCustomerToken();
//     super.initState();
//   }

//   void main() async {
//     // Retrieve the list
//     List<String> retrievedList =
//         await userPreference.getListFromSharedPreferences();
//     print('Retrieved list from SharedPreferences:');
//     print(retrievedList);
//     providerList = retrievedList;
//     print('providerList');
//     print(providerList);
//     print('providerList');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: BackgroundColor,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: false,
//           elevation: 0,
//           backgroundColor: Color(0xffffffff),
//           leading: Padding(
//             padding: EdgeInsets.only(top: 20),
//             child: IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_rounded),
//             ),
//           ),
//           title: Padding(
//             padding: EdgeInsets.only(
//               top: 16.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Change Provider",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Card(
//                     elevation: 3,
//                     // color: Colors.amber,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 100,
//                             child: Image(image: AssetImage('images/axon.png')),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Select Hospital by: ',
//                               style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           InkWell(
//                             onTap: () {
//                               // _qrScanner();
//                             },
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 10),
//                                 Container(
//                                   height: 40,
//                                   child: Image(
//                                       image: AssetImage('images/axon.png')),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'SCANNING APP CODE',
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Container(
//                                 height: 1,
//                                 width: 132,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(width: 5),
//                               Text('or'),
//                               SizedBox(width: 5),
//                               Container(
//                                 height: 1,
//                                 width: 164,
//                                 color: Colors.black,
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           InkWell(
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return Container(
//                                       child: AlertDialog(
//                                         title: Text('Code'),
//                                         content: TextField(
//                                           focusNode: _nodeAppcode,
//                                           controller: strAppcode,
//                                           cursorColor: Color(0xFFFD5722),
//                                           onChanged: (value) {},
//                                           decoration: InputDecoration(
//                                               hintText: 'Write App Code'),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Text(
//                                                 'Cancel',
//                                                 style: TextStyle(
//                                                     color: Color(0xFFFD5722)),
//                                               )),
//                                           TextButton(
//                                               onPressed: () {
//                                                 customerTkenViewmodel
//                                                     .fetchCustomerTokenApi(
//                                                         context,
//                                                         strAppcode.text
//                                                             .toString());
//                                               },
//                                               child: Text(
//                                                 'OK',
//                                                 style: TextStyle(
//                                                     color: Color(0xFFFD5722)),
//                                               ))
//                                         ],
//                                       ),
//                                     );
//                                   });
//                             },
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 10),
//                                 Container(
//                                   height: 40,
//                                   child: Image(
//                                       image: AssetImage('images/axon.png')),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'WRITING CODE MANUALLY',
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'OR',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   Card(
//                       elevation: 3,
//                       // shape: ,
//                       child: providerList.length != 0
//                           ? ListView.builder(
//                               itemCount: providerList.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return ListTile(
//                                   title: Text('data'
//                                       // providerList[index].toString()
//                                       ),
//                                 );
//                               },
//                             )
//                           : CircularProgressIndicator()),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Res/colors.dart';
import '../../View_Model/News_View_Model/news_view_model.dart';
import '../../view_model/services/SharePreference/SharePreference.dart';

class ChangeProviderScreen extends StatefulWidget {
  const ChangeProviderScreen({Key? key}) : super(key: key);

  @override
  State<ChangeProviderScreen> createState() => _ChangeProviderScreenState();
}

class _ChangeProviderScreenState extends State<ChangeProviderScreen> {
  final FocusNode _nodeAppcode = FocusNode();
  TextEditingController strAppcode = TextEditingController();
  UserPreferences userPreference = UserPreferences();
  late String mobile;
  CustomerTkenViewmodel customerTkenViewmodel = CustomerTkenViewmodel();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<String>> fetchData() async {
    List<String> retrievedList =
        await userPreference.getListFromSharedPreferences();
    return retrievedList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error loading data from SharedPreferences'),
            ),
          );
        } else {
          List<String> providerList = snapshot.data ?? [];

          return Scaffold(
            backgroundColor: BackgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: false,
                elevation: 0,
                backgroundColor: Color(0xffffffff),
                leading: Padding(
                  padding: EdgeInsets.only(top: 20),
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
                    top: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change Provider",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 13.h,
                                  child: Image(
                                      image: AssetImage('images/axon.png')),
                                ),
                                SizedBox(height: 2.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select Hospital by: ',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                InkWell(
                                  onTap: () {
                                    // _qrScanner();
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(width: 2.w),
                                      Container(
                                        height: 5.h,
                                        child: Image(
                                            image:
                                                AssetImage('images/axon.png')),
                                      ),
                                      SizedBox(width: 4.w),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'SCANNING APP CODE',
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    Container(
                                      height: 1,
                                      width: 40.w,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text('or'),
                                    SizedBox(width: 2.w),
                                    Container(
                                      height: 1,
                                      width: 40.w,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            child: AlertDialog(
                                              title: Text('Code'),
                                              content: TextField(
                                                focusNode: _nodeAppcode,
                                                controller: strAppcode,
                                                cursorColor: Color(0xFFFD5722),
                                                onChanged: (value) {},
                                                decoration: InputDecoration(
                                                    hintText: 'Write App Code'),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFFFD5722)),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      customerTkenViewmodel
                                                          .fetchCustomerTokenApi(
                                                              context,
                                                              strAppcode.text
                                                                  .toString());
                                                    },
                                                    child: Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFFFD5722)),
                                                    ))
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(width: 2.w),
                                      Container(
                                        height: 5.h,
                                        child: Image(
                                            image:
                                                AssetImage('images/axon.png')),
                                      ),
                                      SizedBox(width: 4.w),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'WRITING CODE MANUALLY',
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 1.h),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        providerList.length != 0
                            ? Text(
                                'OR',
                                style: TextStyle(fontSize: 12.sp),
                              )
                            : Container(),
                        SizedBox(height: 1.h),
                        SizedBox(
                          height: 34.h,
                          child: providerList.length != 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: providerList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        customerTkenViewmodel
                                            .fetchCustomerTokenApi(context,
                                                providerList[index].toString());
                                      },
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(providerList[index]),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        ),
                        Text(
                          'Contact your provider for App Code',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
