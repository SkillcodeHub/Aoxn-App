import 'package:flutter/material.dart';

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
        //     MaterialPageRoute(builder: (context) => BookApointmentScreen()));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
        height: 27,
        child: Image.asset('images/settings.png'),
      ),
    );
  }
}
