import 'dart:ui';

import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Color(0xFFFD5722),
          ),
        ),
      ),
    );
  }
}
