import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _id;

  // This function will be called when the floating button is pressed
  void _getInfo() async {
    // Get device id
    String? result = await PlatformDeviceId.getDeviceId;

    // Update the UI
    setState(() {
      _id = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KindaCode.com')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Text(
          _id ?? 'Press the button',
          style: TextStyle(fontSize: 20, color: Colors.red.shade900),
        )),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _getInfo, child: const Icon(Icons.play_arrow)),
    );
  }
}
