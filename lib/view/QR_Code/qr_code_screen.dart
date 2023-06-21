import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../View_Model/ChangeProvider_View_Model/provider_view_model.dart';

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
  bool isFlashOn = false;

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              top: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Scan QR Code",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 0,
              borderLength: 30,
              borderWidth: 5,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () {
                if (controller != null) {
                  if (isFlashOn) {
                    controller!.toggleFlash();
                  } else {
                    controller!.toggleFlash();
                  }
                  setState(() {
                    isFlashOn = !isFlashOn;
                  });
                }
              },
              icon: Icon(
                isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool isResultHandled = false;

    controller.scannedDataStream.listen((scanData) {
      if (!isResultHandled) {
        setState(() {
          result = scanData;
        });

        // Process the result
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        String decoded = stringToBase64.decode(result!.code.toString());
        print(decoded);
        Map<String, dynamic> jsonMap = jsonDecode(decoded.toString());
        String customerName = jsonMap['CustomerName'];
        String appCode = jsonMap['AppCode'];

        print('CustomerName: $customerName');
        print('AppCode: $appCode');

        // Call your method or perform any necessary operations with the result
        // Navigator.pop(context, [customerName, appCode, true]);
        customerTokenByQRViewmodel.fetchCustomerTokenByQR(
          context,
          appCode.toString(),
        );

        isResultHandled = true;
        controller.stopCamera(); // Stop scanning after the first result
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
