import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';

class ItemInfoState extends Equatable {
  final List<ItemCategoryModel>? itemCategories;
  final ItemModel? item;
  final int? categoryIndex;

  const ItemInfoState({this.itemCategories, this.item, this.categoryIndex});

  ItemInfoState copyWith({ItemModel? item, int? categoryIndex}) {
    return ItemInfoState(
        item: item ?? this.item,
        categoryIndex: categoryIndex ?? this.categoryIndex);
  }

  @override
  List<Object?> get props => [itemCategories, item, categoryIndex];
}
