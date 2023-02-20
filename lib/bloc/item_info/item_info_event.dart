import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/item_model.dart';

import '../../models/item_category_model.dart';

abstract class ItemInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetItemEvent extends ItemInfoEvent {
  final ItemCategoryModel? category;
  final String? url;
  final int? selectedCategoryIndex;
  final String? name;

  SetItemEvent(
      {this.category, this.url, this.selectedCategoryIndex, this.name});
}

class LoadingCategoryEvent extends ItemInfoEvent {}

class BackingHomePageEvent extends ItemInfoEvent {}

class UpdatingCurrentItemEvent extends ItemInfoEvent {
  final ItemModel item;

  UpdatingCurrentItemEvent(this.item);
}
