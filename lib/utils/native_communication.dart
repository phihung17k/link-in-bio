import 'dart:developer';
import 'package:flutter/services.dart';

class NativeCommunication {
  static const _platform = MethodChannel("link_in_bio/android_id");

  static Future<String> getAndroidId() async {
    String androidId = "";
    try {
      androidId = await _platform.invokeMethod("getAndroidId");
    } on PlatformException catch (e) {
      log("NativeCommunication: MESSAGE: ${e.message}");
      log("NativeCommunication: CODE: ${e.code}");
    }
    return androidId;
  }
}
