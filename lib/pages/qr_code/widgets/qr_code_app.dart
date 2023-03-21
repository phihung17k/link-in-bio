import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeAppWidget extends StatelessWidget {
  const QRCodeAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: QrImage(
          data: "data",
          version: QrVersions.auto,
          embeddedImage: AssetImage("assets/images/default_avatar.png")),
    );
  }
}
