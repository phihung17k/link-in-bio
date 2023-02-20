import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';

class ItemInfoState extends Equatable {
  final List<ItemCategoryModel>? itemCategories;
  final ItemModel? item;
  final int? selectedCategoryIndex;

  const ItemInfoState(
      {this.itemCategories, this.item, this.selectedCategoryIndex});

  ItemInfoState copyWith(
      {List<ItemCategoryModel>? itemCategories,
      ItemModel? item,
      int? selectedCategoryIndex}) {
    return ItemInfoState(
        itemCategories: itemCategories ?? this.itemCategories,
        item: item ?? this.item,
        selectedCategoryIndex:
            selectedCategoryIndex ?? this.selectedCategoryIndex);
  }

  @override
  List<Object?> get props => [itemCategories, item, selectedCategoryIndex];
}
