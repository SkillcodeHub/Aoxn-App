import 'dart:async';
import 'package:axonweb/View_Model/Book_View_Model/Book_view_Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Res/Components/loader.dart';
import '../../Res/colors.dart';
import '../../View_Model/Book_View_Model/bookAppointment_view_model.dart';
import '../../View_Model/Services/SharePreference/SharePreference.dart';
import '../../View_Model/Settings_View_Model/settings_view_model.dart';
import '../../data/response/status.dart';
import '../../res/components/appbar/axonimage_appbar-widget.dart';
import '../../res/components/appbar/screen_name_widget.dart';

class MyProvider2 extends ChangeNotifier {
  String nameValue1 = 'Text 1';
  String idValue2 = '0';

  void updateTextValues(String newValue1, String newValue2) {
    nameValue1 = newValue1;
    idValue2 = newValue2;
    notifyListeners();
  }
}

class BookApointmentScreen extends StatefulWidget {
  const BookApointmentScreen({super.key});

  @override
  State<BookApointmentScreen> createState() => _BookApointmentScreenState();
}

class _BookApointmentScreenState extends State<BookApointmentScreen> {
  UserPreferences userPreference = UserPreferences();
  DoctorListViewmodel doctorListViewmodel = DoctorListViewmodel();
  SettingsViewModel settingsViewModel = SettingsViewModel();
  BookAppointmentViewModel bookAppointmentViewModel =
      BookAppointmentViewModel();
  late String number;
  late String selectedDocotrId = '0';
  late String selectedDoctor = 'text';
  bool isLoading = false;
  var mobile;
  late String token;
  late String deviceId;
  String displaySelectAppointmentDate = 'Select Appointment Date';
  String displayDate = '';
  String appointmentDate = '';
  String? DelayMinute;
  String displayTimeSlot = '';
  String? displaytimingId;
  String displayPatientName = 'Select Patient';
  String? displayBirthDate;
  String? displayGender;
  String CaseNo = "";
  String PatType = "";
  bool isFirstLoad = true; // Flag to track the first API call
  late Future<void> fetchDataFuture;
  @override
  void initState() {
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1;
      });
    });

    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
      });
    });
    userPreference.getDeviceId().then((value) {
      setState(() {
        deviceId = value!;
      });
    });
    super.initState();
    fetchDataFuture = fetchData(); // Call the API only once
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final doctorListViewmodel =
          Provider.of<DoctorListViewmodel>(context, listen: false);

      if (!doctorListViewmodel.loading) {
        doctorListViewmodel.setLoading(true);

        doctorListViewmodel.fetchDoctorListApi(token);
      }
      final settingsViewModel =
          Provider.of<SettingsViewModel>(context, listen: false);

      if (!settingsViewModel.loading) {
        settingsViewModel.setLoading(true);

        settingsViewModel.fetchDoctorDetailsListApi(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ParthParthParth');
    print('aaaaaaa');
    // final myProvider2 = Provider.of<MyProvider2>(context, listen: false);
    final doctorListViewmodel =
        Provider.of<DoctorListViewmodel>(context, listen: false);
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
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
                  title: 'Book Appointment',
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          } else {
            // Render the UI with the fetched data
            return ChangeNotifierProvider<DoctorListViewmodel>.value(
                value: doctorListViewmodel,
                child: Consumer<DoctorListViewmodel>(
                  builder: (context, value, child) {
                    switch (value.doctorList.status!) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return Center(
                            child: Text(value.doctorList.message.toString()));
                      case Status.COMPLETED:
                        print('object');
                        selectedDocotrId =
                            value.doctorList.data!.data![0].doctorId.toString();
                        return Stack(
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: isLoading
                                    ? isLoading
                                        ? Container()
                                        : Container()
                                    : Column(
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  height: 12.h,
                                                  width: 78.w,
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 2.h),
                                                      Consumer<MyProvider2>(
                                                        builder: (context,
                                                            myProvider, _) {
                                                          print('qqqqqqq');
                                                          print(
                                                              'provider ${selectedDoctor}');
                                                          print(
                                                              'provider ${selectedDocotrId}');
                                                          return Container(
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  ButtonTheme(
                                                                alignedDropdown:
                                                                    true,
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                                  isDense: true,
                                                                  // hint: Text(
                                                                  //   " myProvidernameValue1",
                                                                  // ),
                                                                  value:
                                                                      selectedDocotrId,
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    selectedDocotrId =
                                                                        newValue!;
                                                                    selectedDoctor = value
                                                                        .doctorList
                                                                        .data!
                                                                        .data!
                                                                        .firstWhere(
                                                                          (doctor) =>
                                                                              doctor.doctorId.toString() ==
                                                                              newValue,
                                                                        )
                                                                        .doctorName
                                                                        .toString();
                                                                    print(
                                                                        selectedDocotrId);
                                                                    print(
                                                                        selectedDoctor);
                                                                    myProvider
                                                                        .updateTextValues(
                                                                      '${selectedDoctor}',
                                                                      '${selectedDocotrId}',
                                                                    );
                                                                  },
                                                                  items: value
                                                                      .doctorList
                                                                      .data!
                                                                      .data!
                                                                      .map(
                                                                          (map) {
                                                                    return new DropdownMenuItem<
                                                                        String>(
                                                                      value: map
                                                                          .doctorId
                                                                          .toString(),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                              child: Text(
                                                                            map.doctorName.toString(),
                                                                          )),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
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
                ));
          }
        },
      ),
    );
  }
}
