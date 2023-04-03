import 'package:mobile_scanner/mobile_scanner.dart';

abstract class ScannerEvent {}

class SaveDetectedQRCodeEvent extends ScannerEvent {
  final BarcodeCapture barcode;

  SaveDetectedQRCodeEvent(this.barcode);
}
