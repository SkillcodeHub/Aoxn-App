import 'package:axonweb/Utils/utils.dart';
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
    return SizerUtil.deviceType == DeviceType.mobile
        ? Container(
            width: 55.w,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: headerFontSize,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Container(
            width: 60.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: headerFontSize),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
  }
}
