import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/services/i_services/i_item_info_service.dart';
import 'package:link_in_bio/utils/general_util.dart';

import '../../models/data_model.dart';
import '../../models/item_category_model.dart';
import '../../models/item_model.dart';
import '../../utils/enums.dart';
import '../base_bloc.dart';
import 'item_info_event.dart';
import 'item_info_state.dart';

class ItemInfoBloc extends BaseBloc<ItemInfoEvent, ItemInfoState>
    with GeneralUtil {
  final IItemInfoService _service;

  ItemInfoBloc(this._service)
      : super(const ItemInfoState(itemCategories: [], selectedCategoryId: 1)) {
    on<InitialDataEvent>(initData);
    on<SelectingCategoryEvent>(selectCategory);
    on<UpdatingCurrentItemEvent>(updateCurrentItem);
    on<SetItemFromQrCodeEvent>(setItemFromQRCode);
    on<SetItemInfoEvent>(setItemInfo);
    on<SetNetworkEncryptionEvent>(setNetworkEncryptionEvent);
  }

  FutureOr<void> initData(
      InitialDataEvent event, Emitter<ItemInfoState> emit) async {
    List<ItemCategoryModel> itemCategories =
        await _service.getAllItemCategory();
    ItemCategoryModel category = itemCategories.first;
    emit.call(state.copyWith(
        itemCategories: itemCategories,
        item:
            state.item ?? ItemModel(name: category.name, category: category)));
  }

  FutureOr<void> selectCategory(
      SelectingCategoryEvent event, Emitter<ItemInfoState> emit) {
    if (event.selectedCategoryId != state.selectedCategoryId) {
      ItemCategoryModel category = state.itemCategories!
          .firstWhere((ic) => ic.id == event.selectedCategoryId!);
      emit.call(state.copyWith(
        selectedCategoryId: category.id,
        item: state.item!.copyWith(
          name: category.name,
          category: category,
        ),
      ));
    }
  }

  FutureOr<void> updateCurrentItem(
      UpdatingCurrentItemEvent event, Emitter<ItemInfoState> emit) {
    emit.call(state.copyWith(
        item: event.item, selectedCategoryId: event.item.category!.id));
  }

  FutureOr<void> setItemFromQRCode(
      SetItemFromQrCodeEvent event, Emitter<ItemInfoState> emit) {
    int selectedCategoryId = state.itemCategories!
            .firstWhere((category) => category.name == "Link")
            .id ??
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
        selectedCategoryId: selectedCategoryId));
  }

  FutureOr<void> setItemInfo(
      SetItemInfoEvent event, Emitter<ItemInfoState> emit) async {
    ItemModel item = state.item!;
    String? name = event.name;
    if (name == null || name.trim().isEmpty) {
      name = item.category!.name;
    }

    item = handleCategorCase(item.category!.name!, params: [item, name, event])
        as ItemModel;

    bool result = false;
    if (item.id == null) {
      result = await _service.addItem(item.toMap());
    } else {
      // update
    }
    addNavigatedEvent(BackingHomePageEvent(result));
  }

  @override
  Object? onSms({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        sms: SmsModel(phoneNumber: event.phoneNumber, message: event.message));
  }

  @override
  Object? onUrl({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name, url: UrlModel(url: event.url));
  }

  @override
  Object? onPhone({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        phone: PhoneModel(phoneNumber: event.phoneNumber));
  }

  @override
  Object? onEmail({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        email: EmailModel(
            address: event.address,
            cc: event.cc,
            bcc: event.bcc,
            subject: event.subject,
            body: event.body));
  }

  @override
  Object? onWifi({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        wifi: WifiModel(
            networkName: event.networkName,
            password: event.password,
            encryption: state.networkEncryption,
            isHidden: false));
  }

  @override
  Object? onLink({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name, url: UrlModel(url: event.url));
  }

  ItemModel _getUpdatedItem(ItemModel item, String? name,
      {UrlModel? url,
      SmsModel? sms,
      PhoneModel? phone,
      EmailModel? email,
      WifiModel? wifi}) {
    return item.copyWith(
        name: name, url: url, sms: sms, phone: phone, email: email, wifi: wifi);
  }

  FutureOr<void> setNetworkEncryptionEvent(
      SetNetworkEncryptionEvent event, Emitter<ItemInfoState> emit) {
    if (event.encryption != state.networkEncryption) {
      emit(state.copyWith(networkEncryption: event.encryption));
    }
  }
}
