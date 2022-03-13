import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class Utils {
  Future<String?> getId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static Map<String, dynamic> parseJwt(String token) {
    final List<String> parts = token.split('.');
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp) as Map<String, dynamic>;
    return payloadMap;
  }
}
