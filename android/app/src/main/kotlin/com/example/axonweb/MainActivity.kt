package com.axon.axonweb

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.platform.PlatformViewsController

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Get the platform views controller
        val platformViewsController = PlatformViewsController()
        
        // Register the QR scanner view factory
        // Replace `QRCodeScannerFactory` with the correct implementation or import
        // val qrCodeScannerFactory = QRCodeScannerFactory()
        // flutterEngine.platformViewsController.registry.registerViewFactory(
        //    "qr_code_scanner_view", qrCodeScannerFactory
        // )
    }
}
