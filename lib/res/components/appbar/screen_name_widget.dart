import 'package:axonweb/Res/Components/Appbar/payment_widget.dart';
import 'package:axonweb/Res/Components/Appbar/settings_widget.dart';
import 'package:axonweb/Res/Components/Appbar/whatsapp_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScreenNameWidget extends StatelessWidget {
  final String title;

  const ScreenNameWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizerUtil.deviceType == DeviceType.mobile ?  Container(
      // width: 48.w,
      width: 55.w,
      child: Text(
        title,
        style:TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 17.sp,
        ) ,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    )  : Container(
      // height: 6.h,
      width: 75.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style:  TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
