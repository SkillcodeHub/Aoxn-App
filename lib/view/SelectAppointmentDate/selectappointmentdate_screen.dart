import 'package:flutter/material.dart';

import '../../Res/Components/Appbar/screen_name_widget.dart';
import '../../Res/colors.dart';

class SelectAppointmentDateScreen extends StatefulWidget {
  const SelectAppointmentDateScreen({super.key});

  @override
  State<SelectAppointmentDateScreen> createState() =>
      _SelectAppointmentDateScreenState();
}

class _SelectAppointmentDateScreenState
    extends State<SelectAppointmentDateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenNameWidget(
                  title: 'Choose Time',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
