import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerState extends Equatable {
  final BarcodeCapture? barcode;
  final String? message;

  const ScannerState({this.barcode, this.message});

  ScannerState copyWith({BarcodeCapture? barcode, String? message}) {
    return ScannerState(
        barcode: barcode ?? this.barcode, message: message ?? this.message);
  }

  @override
  List<Object?> get props => [barcode, message];
}
