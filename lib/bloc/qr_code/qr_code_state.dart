import 'package:equatable/equatable.dart';
import '../../models/item_model.dart';

class QRCodeState extends Equatable {
  final String? internetInfo;
  final List<ItemModel>? items; // for review
  final String? qrData;

  const QRCodeState({this.internetInfo, this.items, this.qrData});

  QRCodeState copyWith(
      {String? internetInfo, List<ItemModel>? items, String? qrData}) {
    return QRCodeState(
        internetInfo: internetInfo ?? this.internetInfo,
        items: items ?? this.items,
        qrData: qrData ?? this.qrData);
  }

  @override
  List<Object?> get props => [internetInfo, items, qrData];
}
