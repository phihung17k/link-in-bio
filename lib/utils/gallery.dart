import 'package:image_picker/image_picker.dart';

class Gallery {
  static Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(
      source: ImageSource.gallery,
    );
  }
}
