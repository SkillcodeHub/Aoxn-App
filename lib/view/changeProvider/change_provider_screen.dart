import 'package:axonweb/view/Login/login_screen.dart';
import 'package:axonweb/view/NevigationBar/my_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Res/colors.dart';

import '../../View_Model/ChangeProvider_View_Model/provider_view_model.dart';
import '../../View_Model/News_View_Model/news_view_model.dart';
import '../../view_model/services/SharePreference/SharePreference.dart';

class ChangeProviderScreen extends StatefulWidget {
  const ChangeProviderScreen({super.key});

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
  Widget build(BuildContext context) {
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1!;
      });
    });
    // final authViewModel = Provider.of<GetProviderTokenViewModel>(context);
    final userPrefernce = Provider.of<GetProviderTokenViewModel>(context);
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
                    elevation: 3,
                    // color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            child: Image(image: AssetImage('images/axon.jpg')),
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Hospital by: ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // _qrScanner();
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  height: 40,
                                  child: Image(
                                      image: AssetImage('images/axon.jpg')),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'SCANNING APP CODE',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                height: 1,
                                width: 132,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text('or'),
                              SizedBox(width: 5),
                              Container(
                                height: 1,
                                width: 164,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
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
                                                    color: Color(0xFFFD5722)),
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
                                                    color: Color(0xFFFD5722)),
                                              ))
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  height: 40,
                                  child: Image(
                                      image: AssetImage('images/axon.jpg')),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'WRITING CODE MANUALLY',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'OR',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 3,
                      // shape: ,
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 50,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 16, bottom: 10, top: 14, right: 16),
                            child: Text(
                              'Amate Hospital',
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      userPrefernce.remove().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      });
                    },
                    child: Text('Logout'),
                  ),
                  Text(mobile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
