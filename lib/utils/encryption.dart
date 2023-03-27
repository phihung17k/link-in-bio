import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

class Encryption {
  String encode(Object? object, {Object? Function(Object?)? toEncodable}) {
    String result = "";
    try {
      String jsonString = jsonEncode(object);
      List<int> bytes = utf8.encode(jsonString);
      result = base64Encode(bytes);
    } catch (e) {
      log("Encryption: Cannot encode $object");
    }
    return result;
  }

  Object? decode(String value) {
    Object? result;
    try {
      Uint8List bytes = base64Decode(value);
      String jsonString = utf8.decode(bytes);
      result = jsonDecode(jsonString);
    } catch (e) {
      log("Encryption: Cannot decode $value");
    }
    return result;
  }
}
