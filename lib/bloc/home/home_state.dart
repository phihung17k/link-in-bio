import 'package:equatable/equatable.dart';

import '../../models/item_model.dart';

class HomeState extends Equatable {
  final List<ItemModel>? itemList;

  const HomeState({this.itemList});

  HomeState copyWith({List<ItemModel>? itemList}) {
    return HomeState(itemList: itemList ?? this.itemList);
  }

  @override
  List<Object?> get props => [itemList];
}
