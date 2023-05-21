import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../models/item_model.dart';

abstract class ItemInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetCategoryIndexEvent extends ItemInfoEvent {
  final int? selectedCategoryIndex;

  SetCategoryIndexEvent({this.selectedCategoryIndex});
}

class InitialDataEvent extends ItemInfoEvent {}

class BackingHomePageEvent extends ItemInfoEvent {
  final ItemModel? item;

  BackingHomePageEvent(this.item);
}

class UpdatingCurrentItemEvent extends ItemInfoEvent {
  final ItemModel item;

  UpdatingCurrentItemEvent(this.item);
}

class NavigatorScannerPageEvent extends ItemInfoEvent {}

class SetItemFromQrCode extends ItemInfoEvent {
  final Barcode barcode;

  SetItemFromQrCode(this.barcode);
}

class SetItemInfo extends ItemInfoEvent {
  final String? name;
  final String? phoneNumber;
  final String? message;
  final String? url;

  final String? address;
  final String? cc;
  final String? bcc;
  final String? subject;
  final String? body;

  final String? networkName;
  final String? password;

  SetItemInfo(
      {this.name,
      this.phoneNumber,
      this.message,
      this.url,
      this.address,
      this.cc,
      this.bcc,
      this.subject,
      this.body,
      this.networkName,
      this.password});
}
