import 'package:equatable/equatable.dart';

import '../../models/item_category_model.dart';

abstract class ItemInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetItemEvent extends ItemInfoEvent {
  final ItemCategoryModel? category;
  final String? url;
  final int? selectedCategoryIndex;
  final String? name;

  SetItemEvent(
      {this.category, this.url, this.selectedCategoryIndex, this.name});
}

class LoadingCategoryEvent extends ItemInfoEvent {}
