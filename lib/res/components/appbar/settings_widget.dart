import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/routes/routes_name.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.settings);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(6, 8, 0, 8),
        height: 3.h,
        child: Image.asset('images/settings.png'),
      ),
    );
  }
}
