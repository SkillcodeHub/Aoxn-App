import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorScreenWidget extends StatefulWidget {
  final Function() onRefresh;
  final String message;

  ErrorScreenWidget({required this.onRefresh, required this.message});

  @override
  State<ErrorScreenWidget> createState() => _ErrorScreenWidgetState();
}

class _ErrorScreenWidgetState extends State<ErrorScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh(),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                height: 74.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.h),
                    SizedBox(height: 20.h),
                    Center(
                      child: Image.asset(
                        'images/loading.png',
                        height: 20,
                      ),
                    ),
                    SizedBox(height: 4),
                    Center(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          fontSize: 14.sp, // You can adjust this as needed
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
