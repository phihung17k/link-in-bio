import 'package:equatable/equatable.dart';

import '../../models/item_model.dart';

class HomeState extends Equatable {
  final List<ItemModel>? itemList;
  final List<ItemModel>? selectedItemList;
  final bool? isSelectAll;

  const HomeState({this.itemList, this.selectedItemList, this.isSelectAll});

  HomeState copyWith(
      {List<ItemModel>? itemList,
      List<ItemModel>? selectedItemList,
      bool? isSelectAll}) {
    return HomeState(
        itemList: itemList ?? this.itemList,
        selectedItemList: selectedItemList ?? this.selectedItemList,
        isSelectAll: isSelectAll ?? this.isSelectAll);
  }

  @override
  List<Object?> get props => [itemList, selectedItemList, isSelectAll];
}
