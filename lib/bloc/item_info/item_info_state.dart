import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/item_model.dart';

class ItemInfoState extends Equatable {
  final ItemModel? item;

  const ItemInfoState({this.item});

  ItemInfoState copyWith({ItemModel? item}) {
    return ItemInfoState(item: item ?? this.item);
  }

  @override
  List<Object?> get props => [];
}
