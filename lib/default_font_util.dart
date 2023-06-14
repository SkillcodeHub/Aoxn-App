import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('default_font_channel');

Future<String> getDefaultFontFamily() async {
  return await _channel.invokeMethod('getDefaultFontFamily');
}
