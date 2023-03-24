import 'package:equatable/equatable.dart';
import '../../models/item_model.dart';

abstract class ItemInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetItemNameEvent extends ItemInfoEvent {
  final String? name;

  SetItemNameEvent({this.name});
}

class SetCategoryIndexEvent extends ItemInfoEvent {
  final int? selectedCategoryIndex;

  SetCategoryIndexEvent({this.selectedCategoryIndex});
}

class SetItemURLEvent extends ItemInfoEvent {
  final String? url;

  SetItemURLEvent({this.url});
}

class InitialDataEvent extends ItemInfoEvent {}

class BackingHomePageEvent extends ItemInfoEvent {}

class UpdatingCurrentItemEvent extends ItemInfoEvent {
  final ItemModel item;

  UpdatingCurrentItemEvent(this.item);
}
