import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/models/data_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
    on<SetCategoryIndexEvent>(setCategoryIndex);
    on<UpdatingCurrentItemEvent>(updateCurrentItem);
    on<SetItemFromQrCode>(setItemFromQRCode);
    on<SetItemInfo>(setItemInfo);
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
        item: ItemModel(name: category.name, category: category)));
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
              category: state.itemCategories![event.selectedCategoryIndex!])));
    }
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
            url: UrlModel(url: event.barcode.rawValue)),
        selectedCategoryIndex: selectedIndex));
  }

  FutureOr<void> setItemInfo(SetItemInfo event, Emitter<ItemInfoState> emit) {
    ItemModel item = state.item!;
    String? name = event.name;
    if (name == null || name.trim().isEmpty) {
      name = item.category!.name;
    }

    switch (item.category!.name!.toLowerCase()) {
      case "sms":
        emit.call(state.copyWith(
            item: item.copyWith(
                name: name,
                sms: SmsModel(
                    phoneNumber: event.phoneNumber, message: event.message),
                url: null,
                phone: null)));
        break;
      case "facebook":
      case "twitter":
      case "youtube":
      case "tiktok":
      case "twitch":
        emit.call(state.copyWith(
            item: item.copyWith(
                name: name,
                url: UrlModel(url: event.url),
                phone: null,
                sms: null)));
        break;
      case "phone":
        emit.call(state.copyWith(
            item: item.copyWith(
                name: name,
                phone: PhoneModel(phoneNumber: event.phoneNumber),
                url: null,
                sms: null)));
        break;
    }
    addNavigatedEvent(BackingHomePageEvent(state.item));
  }
}
