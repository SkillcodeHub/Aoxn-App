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
    return Container(
      width: 60.w,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 21,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
