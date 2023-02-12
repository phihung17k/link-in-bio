import 'package:equatable/equatable.dart';

import '../../models/item_model.dart';

class HomeState extends Equatable {
  final bool? isDragUpBottom;
  final List<ItemModel>? itemList;

  const HomeState({this.isDragUpBottom, this.itemList});

  HomeState copyWith({bool? isDragUpBottom, List<ItemModel>? itemList}) {
    return HomeState(
        isDragUpBottom: isDragUpBottom ?? this.isDragUpBottom,
        itemList: itemList ?? this.itemList);
  }

  @override
  List<Object?> get props => [isDragUpBottom, itemList];
}
