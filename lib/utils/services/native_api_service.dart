import 'package:flutter/services.dart';

class DeviceApi {
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
