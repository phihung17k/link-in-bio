import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/item_model.dart';

class ItemInfoState extends Equatable {
  final ItemModel? item;
  final int? categoryIndex;

  const ItemInfoState({this.item, this.categoryIndex});

  ItemInfoState copyWith({ItemModel? item, int? categoryIndex}) {
    return ItemInfoState(
        item: item ?? this.item,
        categoryIndex: categoryIndex ?? this.categoryIndex);
  }

  @override
  List<Object?> get props => [item, categoryIndex];
}
