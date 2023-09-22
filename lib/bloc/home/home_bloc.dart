import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/services/i_services/i_home_service.dart';

import '../../models/item_model.dart';
import '../base_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final IHomeService _service;

  HomeBloc(this._service)
      : super(const HomeState(
            itemList: [], selectedIndexList: [], isSelectAll: false)) {
    on<RefreshItemsFromSplashPageEvent>(_refreshItemsFromSplashPage);
    on<AddingItemEvent>(_addItem);
    on<ReloadAllItemEvent>(_reloadAllItem);
    on<UpdatingItemEvent>(_updateItem);
    on<DeletingItemEvent>(_deleteItem);
    on<ReorderItemEvent>(_reorderItem);

    on<AddingSelectedItemEvent>(_addSelectedItem);
    on<DeletingSelectedItemEvent>(_deleteSelectedItem);
    on<ResetSelectedItemsEvent>(_resetSelectedItems);
    on<SelectingAllItemEvent>(_selectAllItem);
  }

  FutureOr<void> _refreshItemsFromSplashPage(
      RefreshItemsFromSplashPageEvent event, Emitter<HomeState> emit) {
    emit.call(state.copyWith(itemList: event.items));
  }

  FutureOr<void> _updateItem(UpdatingItemEvent event, Emitter<HomeState> emit) {
    if (event.index < state.itemList!.length) {
      List<ItemModel> tempList = state.itemList!.toList();
      tempList[event.index] = event.item;
      emit.call(state.copyWith(itemList: tempList));
    }
  }

  FutureOr<void> _addItem(AddingItemEvent event, Emitter<HomeState> emit) {
    List<ItemModel> tempList = state.itemList!.toList();
    tempList.add(event.item);
    emit.call(state.copyWith(itemList: tempList));
  }

  FutureOr<void> _reloadAllItem(
      ReloadAllItemEvent event, Emitter<HomeState> emit) async {
    // call items from db
    List<ItemModel> items = await _service.getAllItem();
    emit.call(state.copyWith(itemList: items));
  }

  FutureOr<void> _deleteItem(
      DeletingItemEvent event, Emitter<HomeState> emit) async {
    bool isSuccess = await _service.deleteItem(event.id);
    if (isSuccess) {
      await _reloadAllItem(ReloadAllItemEvent(), emit);
    }
  }

  FutureOr<void> _reorderItem(
      ReorderItemEvent event, Emitter<HomeState> emit) async {
    int oldIndex = event.oldIndex!;
    int newIndex = event.newIndex!;

    List<ItemModel> items = state.itemList!.toList();
    Map<int, int> idOrdinalMap = {};
    // update old item with new ordinal
    items[oldIndex] =
        items[oldIndex].copyWith(ordinal: items[newIndex].ordinal);
    idOrdinalMap[items[oldIndex].id!] = items[oldIndex].ordinal!;
    bool isPullDown = oldIndex < newIndex;
    // update ordinal of items with index from oldIndex to newIndex
    do {
      // 0 1 [2] 3 4 5 6
      // 0 1 [5] 2 3 4 6
      // o: 2; n: 5 pull down
      if (isPullDown) {
        oldIndex++;
        var nextItem = items[oldIndex];
        items[oldIndex] = nextItem.copyWith(ordinal: nextItem.ordinal! - 1);
        idOrdinalMap[nextItem.id!] = items[oldIndex].ordinal!;
      } else {
        // 0 1 2 3 4 [5] 6
        // 0 1 3 4 5 [2] 6
        // o: 5; n: 2 push up
        oldIndex--;
        var previousItem = items[oldIndex];
        items[oldIndex] =
            previousItem.copyWith(ordinal: previousItem.ordinal! + 1);
        idOrdinalMap[previousItem.id!] = items[oldIndex].ordinal!;
      }
    } while (isPullDown ? oldIndex < newIndex : oldIndex > newIndex);

    ItemModel item = items.removeAt(event.oldIndex!);
    items.insert(event.newIndex!, item);

    emit(state.copyWith(itemList: items));

    _service.reorderItem(idOrdinalMap).then(
        (value) => debugPrint("REORDER: $value"),
        onError: (e) => debugPrint("REORDER: FAIL"));
  }

  FutureOr<void> _addSelectedItem(
      AddingSelectedItemEvent event, Emitter<HomeState> emit) {
    List<int> selectedIndexList = state.selectedIndexList!.toList();
    selectedIndexList.add(event.index!);
    emit.call(state.copyWith(
        selectedIndexList: selectedIndexList,
        isSelectAll: selectedIndexList.length == state.itemList!.length));
  }

  FutureOr<void> _deleteSelectedItem(
      DeletingSelectedItemEvent event, Emitter<HomeState> emit) {
    List<int> selectedIndexList = state.selectedIndexList!.toList();
    selectedIndexList.remove(event.index!);
    emit.call(state.copyWith(
        selectedIndexList: selectedIndexList,
        isSelectAll: selectedIndexList.length == state.itemList!.length));
  }

  FutureOr<void> _resetSelectedItems(
      ResetSelectedItemsEvent event, Emitter<HomeState> emit) {
    emit.call(state.copyWith(selectedIndexList: [], isSelectAll: false));
  }

  FutureOr<void> _selectAllItem(
      SelectingAllItemEvent event, Emitter<HomeState> emit) {
    emit.call(state.copyWith(
        selectedIndexList: List<int>.generate(
            state.itemList!.length, (int index) => index,
            growable: true),
        isSelectAll: true));
  }
}
