import 'package:flutter/services.dart';

class NativeAPI {
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
