import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerState extends Equatable {
  final BarcodeCapture? barcode;
  final String? message;
  final String? previousPage;

  const ScannerState({this.barcode, this.message, this.previousPage});

  ScannerState copyWith(
      {BarcodeCapture? barcode, String? message, String? previousPage}) {
    return ScannerState(
        barcode: barcode ?? this.barcode,
        message: message ?? this.message,
        previousPage: previousPage ?? this.previousPage);
  }

  @override
  List<Object?> get props => [barcode, message, previousPage];
}
