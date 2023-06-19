import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'View_Model/ChangeProvider_View_Model/provider_view_model.dart';

class QRScannerWidget extends StatefulWidget {
  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  CustomerTokenByQRViewmodel customerTokenByQRViewmodel =
      CustomerTokenByQRViewmodel();
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String decoded =
          stringToBase64.decode(result!.code.toString()); // username:password
      print(decoded);
      Map<String, dynamic> jsonMap = jsonDecode(decoded.toString());

      String customerName = jsonMap['CustomerName'];
      String appCode = jsonMap['AppCode'];

      print('CustomerName: $customerName');
      print('AppCode: $appCode');
      print('cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
      print(appCode);
      customerTokenByQRViewmodel.fetchCustomerTokenByQR(
          context, appCode.toString());
      print(
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

      print('-------------------------------------------------------------');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
