import 'package:flutter/material.dart';

import '../../../view/PaymentHistory/payment_history_screen.dart';


class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PaymentHistory()));
      },
      child: Container(
        margin: EdgeInsets.all(0),
        height: 5,
        child: Image.asset('images/rupee.png'),
      ),
    );
  }
}
