import 'package:equatable/equatable.dart';

import '../../models/item_model.dart';

class HomeState extends Equatable {
  final List<ItemModel>? itemList;
  final List<int>? selectedIndexList;
  final bool? isSelectAll;

  const HomeState({this.itemList, this.selectedIndexList, this.isSelectAll});

  HomeState copyWith(
      {List<ItemModel>? itemList,
      List<int>? selectedIndexList,
      bool? isSelectAll}) {
    return HomeState(
        itemList: itemList ?? this.itemList,
        selectedIndexList: selectedIndexList ?? this.selectedIndexList,
        isSelectAll: isSelectAll ?? this.isSelectAll);
  }

  @override
  List<Object?> get props => [itemList, selectedIndexList, isSelectAll];
}
