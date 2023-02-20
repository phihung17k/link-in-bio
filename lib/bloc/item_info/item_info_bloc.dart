import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_event.dart';
import 'package:link_in_bio/bloc/item_info/item_info_state.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/repository/item_category_repository.dart';

import '../base_bloc.dart';

class ItemInfoBloc extends BaseBloc<ItemInfoEvent, ItemInfoState> {
  ItemInfoBloc()
      : super(
            const ItemInfoState(itemCategories: [], selectedCategoryIndex: 0)) {
    on<LoadingCategoryEvent>(loadCategories);
    on<SetItemEvent>(setItem);
    on<UpdatingCurrentItemEvent>(updateCurrentItem);
  }

  Future<List<ItemCategoryModel>> loadAsset() async {
    return await rootBundle.loadStructuredData(
      'assets/text/item_category.txt',
      (value) {
        LineSplitter ls = const LineSplitter();
        List<ItemCategoryModel> categories =
            ls.convert(value).map<ItemCategoryModel>((line) {
          List<String> sectors = line.split("[space]");
          String baseURL = sectors[2].trim();
          return ItemCategoryModel(
              name: sectors[0].trim(),
              imageURL: sectors[1].trim(),
              baseURL: baseURL == "empty" ? "" : baseURL);
        }).toList();
        return Future.value(categories);
      },
    );
  }

  FutureOr<void> loadCategories(
      LoadingCategoryEvent event, Emitter<ItemInfoState> emit) async {
    ItemCategoryRepository categoryRepo = ItemCategoryRepository.instance;
    if (categoryRepo.itemCategories.isEmpty) {
      categoryRepo.itemCategories = await loadAsset();
    }
    emit.call(state.copyWith(itemCategories: categoryRepo.itemCategories));
  }

  //for create
  FutureOr<void> setItem(SetItemEvent event, Emitter<ItemInfoState> emit) {
    ItemModel item = state.item ?? const ItemModel();
    emit.call(state.copyWith(
        item: item.copyWith(
            name: event.name ?? event.category?.name,
            category: event.category,
            url: event.url),
        selectedCategoryIndex: event.selectedCategoryIndex));
  }

  FutureOr<void> updateCurrentItem(
      UpdatingCurrentItemEvent event, Emitter<ItemInfoState> emit) {
    ItemModel item = event.item;
    int? categoryIndex = state.itemCategories
        ?.indexWhere((category) => category.name == item.category?.name);
    emit.call(
        state.copyWith(item: event.item, selectedCategoryIndex: categoryIndex));
  }
}
