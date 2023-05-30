// ignore_for_file: library_prefixes, file_names
import 'dart:ui';
import 'package:flutter/material.dart';

// Multicolor progress => https://stackoverflow.com/questions/49952048/how-to-change-color-of-circularprogressindicator/50075652#50075652
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
