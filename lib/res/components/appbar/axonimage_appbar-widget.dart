import 'package:flutter/material.dart';

class AxonIconForAppBarrWidget extends StatelessWidget {
  const AxonIconForAppBarrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      width: MediaQuery.of(context).size.width * 0.10,
      child: Image.asset('images/axon-icon.png'),
    );
  }
}
