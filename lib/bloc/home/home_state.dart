import 'package:equatable/equatable.dart';

import '../../models/item_model.dart';

class HomeState extends Equatable {
  final List<ItemModel>? itemList;
  final List<ItemModel>? selectedItemList;

  const HomeState({this.itemList, this.selectedItemList});

  HomeState copyWith(
      {List<ItemModel>? itemList, List<ItemModel>? selectedItemList}) {
    return HomeState(
        itemList: itemList ?? this.itemList,
        selectedItemList: selectedItemList ?? this.selectedItemList);
  }

  @override
  List<Object?> get props => [itemList, selectedItemList];
}
