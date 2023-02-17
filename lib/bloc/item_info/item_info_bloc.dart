import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_event.dart';
import 'package:link_in_bio/bloc/item_info/item_info_state.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';

class ItemInfoBloc extends Bloc<ItemInfoEvent, ItemInfoState> {
  ItemInfoBloc()
      : super(const ItemInfoState(itemCategories: [], categoryIndex: 0)) {
    on<LoadingCategoryEvent>(loadCategories);
    on<SetItemEvent>(setItemCategory);
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/text/item_category.txt');
  }

  FutureOr<void> loadCategories(
      LoadingCategoryEvent event, Emitter<ItemInfoState> emit) async {
    String temp = await loadAsset();
    List<ItemCategoryModel> itemCategories = [];
    emit.call(state);
  }

  FutureOr<void> setItemCategory(
      SetItemEvent event, Emitter<ItemInfoState> emit) {
    ItemModel item = state.item ?? const ItemModel();
    emit.call(state.copyWith(
        item: item.copyWith(
            name: event.name, category: event.category, url: event.url),
        categoryIndex: event.categoryIndex));
  }
}
