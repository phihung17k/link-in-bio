import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/item_model.dart';
import '../base_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(itemList: [], selectedItemList: [])) {
    // on<AddingItemTestEvent>(_onDumpData);
    on<AddingItemEvent>(_addItem);
    on<UpdatingItemEvent>(_updateItem);
    on<DeletingItemEvent>(_deleteItem);
    on<ReorderItemEvent>(_reorderItem);

    on<AddingSelectedItemEvent>(_addSelectedItem);
    on<DeletingSelectedItemEvent>(_deleteSelectedItem);
  }

  // FutureOr<void> _onDumpData(
  //     AddingItemTestEvent event, Emitter<HomeState> emit) {
  //   emit.call(state.copyWith(itemList: [
  //     ItemModel(name: "Test", category: "assets/images/default_avatar.png")
  //   ]));
  // }

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

  FutureOr<void> _deleteItem(DeletingItemEvent event, Emitter<HomeState> emit) {
    List<ItemModel> tempList = state.itemList!.toList();
    tempList.removeAt(event.index);
    emit.call(state.copyWith(itemList: tempList));
  }

  FutureOr<void> _reorderItem(ReorderItemEvent event, Emitter<HomeState> emit) {
    int oldIndex = event.oldIndex!;
    int newIndex = event.newIndex!;

    if (oldIndex < newIndex) newIndex -= 1;
    List<ItemModel> items = state.itemList!.toList();
    ItemModel item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit.call(state.copyWith(itemList: items));
  }

  FutureOr<void> _addSelectedItem(
      AddingSelectedItemEvent event, Emitter<HomeState> emit) {
    List<ItemModel> selectedItems = state.selectedItemList!.toList();
    selectedItems.add(event.item!);
    emit.call(state.copyWith(selectedItemList: selectedItems));
  }

  FutureOr<void> _deleteSelectedItem(
      DeletingSelectedItemEvent event, Emitter<HomeState> emit) {
    List<ItemModel> selectedItems = state.selectedItemList!.toList();
    selectedItems.remove(event.item!);
    emit.call(state.copyWith(selectedItemList: selectedItems));
  }
}
