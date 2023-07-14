import 'package:equatable/equatable.dart';
import '../../utils/enums.dart';
import '../../models/item_model.dart';

class QRCodeState extends Equatable {
  final InternetStatusEnum? internetInfo;
  final List<ItemModel>? items; // for review
  final String? appQR;
  final String? webQR;

  const QRCodeState({this.internetInfo, this.items, this.appQR, this.webQR});

  QRCodeState copyWith(
      {InternetStatusEnum? internetInfo,
      List<ItemModel>? items,
      String? appQR,
      String? webQR}) {
    return QRCodeState(
        internetInfo: internetInfo ?? this.internetInfo,
        items: items ?? this.items,
        appQR: appQR ?? this.appQR,
        webQR: webQR ?? this.webQR);
  }

  @override
  List<Object?> get props => [internetInfo, items, appQR, webQR];
}
