import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Settings()));
      // },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
        height: 27,
        child: Image.asset('images/settings.png'),
      ),
    );
  }
}
