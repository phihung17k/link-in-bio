import 'package:mobile_scanner/mobile_scanner.dart';

abstract class ScannerEvent {}

class DetectingQRCodeEvent extends ScannerEvent {
  final BarcodeCapture barcode;

  DetectingQRCodeEvent(this.barcode);
}

class SavePreviousPageEvent extends ScannerEvent {
  final String previousPage;

  SavePreviousPageEvent(this.previousPage);
}
