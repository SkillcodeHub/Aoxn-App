import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/routes/routes_name.dart';
import '../../../demo2.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.settings);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => Appbarrwidget()));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(6, 8, 0, 8),
        height: 3.h,
        // width: 7.w,
        child: Image.asset('images/settings.png'),
      ),
    );
  }
}
