import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/item_model.dart';

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

class UpdatingBottomStatusEvent extends HomeEvent {
  final bool bottomStatus;

  UpdatingBottomStatusEvent(this.bottomStatus);
}

class AddingItemTestEvent extends HomeEvent {}

class AddingItemEvent extends HomeEvent {
  final ItemModel item;

  AddingItemEvent(this.item);
}
