import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/file_util.dart';
import 'item_info_event.dart';
import 'item_info_state.dart';
import '../../models/item_category_model.dart';
import '../../models/item_model.dart';
import '../../repository/item_category_repository.dart';
import '../base_bloc.dart';

class ItemInfoBloc extends BaseBloc<ItemInfoEvent, ItemInfoState> {
  ItemInfoBloc()
      : super(
            const ItemInfoState(itemCategories: [], selectedCategoryIndex: 0)) {
    on<InitialDataEvent>(initData);
    on<SetItemNameEvent>(setItemName);
    on<SetCategoryIndexEvent>(setCategoryIndex);
    on<SetItemURLEvent>(setItemURL);
    on<UpdatingCurrentItemEvent>(updateCurrentItem);
    on<SetItemFromQrCode>(setItemFromQRCode);
    on<SetSms>(setSms);
  }

  FutureOr<void> initData(
      InitialDataEvent event, Emitter<ItemInfoState> emit) async {
    ItemCategoryRepository categoryRepo = ItemCategoryRepository.instance;
    if (categoryRepo.itemCategories.isEmpty) {
      categoryRepo.itemCategories = await FileUtil.loadCategoriesJson();
    }
    ItemCategoryModel category = categoryRepo.itemCategories.first;
    emit.call(state.copyWith(
        itemCategories: categoryRepo.itemCategories,
        item: ItemModel(name: category.name, category: category, url: "")));
  }

  //for create
  FutureOr<void> setItemName(
      SetItemNameEvent event, Emitter<ItemInfoState> emit) {
    ItemModel item = state.item ?? const ItemModel();
    emit.call(state.copyWith(
        item: item.copyWith(
            name:
                event.name ?? state.item?.name ?? state.item?.category!.name)));
  }

  FutureOr<void> setCategoryIndex(
      SetCategoryIndexEvent event, Emitter<ItemInfoState> emit) {
    if (event.selectedCategoryIndex != state.selectedCategoryIndex) {
      ItemCategoryModel category =
          state.itemCategories![event.selectedCategoryIndex!];
      emit.call(state.copyWith(
          selectedCategoryIndex: event.selectedCategoryIndex,
          item: state.item!.copyWith(
              name: category.name,
              category: state.itemCategories![event.selectedCategoryIndex!],
              url: "")));
    }
  }

  FutureOr<void> setItemURL(
      SetItemURLEvent event, Emitter<ItemInfoState> emit) {
    emit.call(state.copyWith(item: state.item?.copyWith(url: event.url)));
  }

  FutureOr<void> updateCurrentItem(
      UpdatingCurrentItemEvent event, Emitter<ItemInfoState> emit) {
    ItemModel item = event.item;
    int? categoryIndex = state.itemCategories
        ?.indexWhere((category) => category.name == item.category?.name);
    emit.call(
        state.copyWith(item: event.item, selectedCategoryIndex: categoryIndex));
  }

  FutureOr<void> setItemFromQRCode(
      SetItemFromQrCode event, Emitter<ItemInfoState> emit) {
    int selectedIndex = state.itemCategories
            ?.indexWhere((category) => category.name == "Link") ??
        0;
    emit.call(state.copyWith(
        item: ItemModel(
            name: "Link",
            category: const ItemCategoryModel(
                topic: "Others",
                name: "Link",
                image: "assets/images/network.png",
                webUrl: ""),
            url: event.barcode.rawValue),
        selectedCategoryIndex: selectedIndex));
  }

  FutureOr<void> setSms(SetSms event, Emitter<ItemInfoState> emit) {
    ItemModel item = state.item!;
    String? name = item.name;
    if (name == null || name.trim().isEmpty) {
      name = item.category!.name;
    }

    try {
      Uri uri =
          Uri.parse("sms:${event.phoneNumber ?? ""}?${event.message ?? ""}");
      emit.call(state.copyWith(item: item.copyWith(name: name, uri: uri)));
    } on FormatException catch (e) {
      log("FormatException: ${e.message}");
    } finally {
      addNavigatedEvent(BackingHomePageEvent());
    }
  }
}
