import 'package:flutter/material.dart';

import '../../../View/PaymentHistory/payment_history_screen.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => PaymentHistory()));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 27,
        child: Image.asset('images/rupee.png'),
      ),
    );
  }
}
