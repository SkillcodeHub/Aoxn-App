import 'dart:async';

import 'package:axonweb/Repository/Book_Repository/confirmPaidAppointment_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/utils.dart';
import '../../View/NevigationBar/my_navigationbar.dart';

class ConfirmPaidAppointmentViewModel with ChangeNotifier {
  final _myRepo = ConfirmPaidAppointmentRepository();

  bool _UpLoading = false;
  bool get UpLoading => _UpLoading;

  setLoading(bool value) {
    _UpLoading = value;
    notifyListeners();
  }

  Future<void> confirmPaidAppointmentApi(
      dynamic data, BuildContext context) async {
    setLoading(true);
    print('datadatadatadatadatadatadatadatadatadata');
    print(data);
    print('datadatadatadatadatadatadatadatadatadatadatadata');
    _myRepo.confirmPaidAppointmentApi(data).then((value) {
      // Utils.flushBarErrorMessage(
      //     'Otp is Valid'.toString(), Duration(seconds: 5), context);

      if (value['status'] == true) {
        setLoading(false);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: Image.asset(
                'images/congratulations.png',
                height: 15.h,
              ),
              title: Text(
                'Congratulations!',
                style: TextStyle(fontSize: SizerUtil.deviceType == DeviceType.mobile ?  15.sp : 12.sp, fontWeight: FontWeight.bold),
              ),
              content: Center(
                child: Text(
                  'Appointment Booked Successfully.',
                  style: TextStyle(
                      // fontWeight:
                      //     FontWeight
                      //         .bold,
                      fontSize:SizerUtil.deviceType == DeviceType.mobile ?  12.sp : 8.sp),
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: 80.w,
                  child: ElevatedButton(
                    child: Text(
                      'CONTINUE',
                      style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.mobile ?  14.sp : 8.sp, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Timer(
                          Duration(seconds: 1),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyNavigationBar(
                                        indexNumber: 2,
                                      ))));
                    },
                  ),
                ),
              ],
            );
          },
        );
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Alert!',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Appointment booking failed. Please try to contact in Clinic.',
              style: TextStyle(
                  // fontWeight:
                  //     FontWeight
                  //         .bold,
                  fontSize: 12.sp),
            ),
            actions: <Widget>[
              SizedBox(
                width: 80.w,
                child: ElevatedButton(
                  child: Text(
                    'CONTINUE',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Timer(
                        Duration(seconds: 1),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyNavigationBar(
                                      indexNumber: 1,
                                    ))));
                  },
                ),
              ),
            ],
          );
        },
      );

      if (kDebugMode) {
        Utils.flushBarErrorMessage(
            error.toString(), Duration(seconds: 3), context);
        print(error.toString());
      }
    });
  }
}
