import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.platform.PlatformViewsController
import io.flutter.plugin.common.PluginRegistry.Registrar

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Get the platform views controller
        val platformViewsController = PlatformViewsController(activity, flutterEngine.dartExecutor.binaryMessenger)
        
        // Create the shim plugin registry
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine)

        // Register the QR scanner view factory
        val qrCodeScannerFactory = QRCodeScannerFactory(this, platformViewsController)
        shimPluginRegistry.registrarFor("qr_code_scanner_channel").platformViewRegistry()
            .registerViewFactory("qr_code_scanner_view", qrCodeScannerFactory)
    }
}
