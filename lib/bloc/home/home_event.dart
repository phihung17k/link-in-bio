import 'package:equatable/equatable.dart';
import '../../models/item_model.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatingItemEvent extends HomeEvent {
  final int index;
  final ItemModel item;

  UpdatingItemEvent(this.index, this.item);

  @override
  List<Object?> get props => [index, item];
}

class AddingItemEvent extends HomeEvent {
  final ItemModel item;

  AddingItemEvent(this.item);
}

class DeletingItemEvent extends HomeEvent {
  final int index;

  DeletingItemEvent(this.index);
}

class NavigatorItemInfoPageForCreatingEvent extends HomeEvent {}

class NavigatorItemInfoPageForUpdatingEvent extends HomeEvent {
  final int index;
  final ItemModel item;

  NavigatorItemInfoPageForUpdatingEvent(this.index, this.item);
}

class ReorderItemEvent extends HomeEvent {
  final int? oldIndex;
  final int? newIndex;

  ReorderItemEvent({required this.oldIndex, required this.newIndex});
}

//sharing
class AddingSelectedItemEvent extends HomeEvent {
  final int? index;

  AddingSelectedItemEvent(this.index);
}

class DeletingSelectedItemEvent extends HomeEvent {
  final int? index;

  DeletingSelectedItemEvent(this.index);
}

class ResetSelectedItemsEvent extends HomeEvent {}

class SelectingAllItemEvent extends HomeEvent {}

class NavigatorQRSharingPageEvent extends HomeEvent {}

class NavigatorScannerPageEvent extends HomeEvent {}

class NavigatorSettingPageEvent extends HomeEvent {}
