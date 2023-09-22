import 'package:equatable/equatable.dart';
import '../../models/item_category_model.dart';
import '../../models/item_model.dart';

class ItemInfoState extends Equatable {
  final List<ItemCategoryModel>? itemCategories;
  final ItemModel? item;
  final int? selectedCategoryId;
  final String? networkEncryption;

  const ItemInfoState(
      {this.itemCategories,
      this.item,
      this.selectedCategoryId,
      this.networkEncryption});

  ItemInfoState copyWith(
      {List<ItemCategoryModel>? itemCategories,
      ItemModel? item,
      int? selectedCategoryId,
      String? networkEncryption}) {
    return ItemInfoState(
        itemCategories: itemCategories ?? this.itemCategories,
        item: item ?? this.item,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        networkEncryption: networkEncryption ?? this.networkEncryption);
  }

  @override
  List<Object?> get props =>
      [itemCategories, item, selectedCategoryId, networkEncryption];
}
