import 'package:equatable/equatable.dart';

class QRCodeState extends Equatable {
  final String? internetInfo;

  const QRCodeState({this.internetInfo});

  QRCodeState copyWith({String? internetInfo}) {
    return QRCodeState(internetInfo: internetInfo ?? this.internetInfo);
  }

  @override
  List<Object?> get props => [internetInfo];
}
