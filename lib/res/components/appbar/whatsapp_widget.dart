import 'package:flutter/material.dart';

class WhatsappWidget extends StatelessWidget {
  const WhatsappWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   whatsapp();
      // },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 27,
        child: Image.asset('images/whatsapp.png'),
      ),
    );
  }
}
