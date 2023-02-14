import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/item_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(isDragUpBottom: true, itemList: [])) {
    on<AddingItemTestEvent>(_onDumpData);
    on<UpdatingBottomStatusEvent>(_updateBottomStatus);
    on<AddingItemEvent>(_addItem);
    on<UpdatingItemEvent>(_updateItem);
    on<DeletingItemEvent>(_deleteItem);
  }

  FutureOr<void> _onDumpData(
      AddingItemTestEvent event, Emitter<HomeState> emit) {
    emit.call(state.copyWith(itemList: [
      ItemModel(name: "Test", symbolPath: "assets/images/default_avatar.png")
    ]));
  }

  FutureOr<void> _updateItem(UpdatingItemEvent event, Emitter<HomeState> emit) {
    if (event.index < state.itemList!.length) {
      List<ItemModel> tempList = state.itemList!.toList();
      tempList[event.index] = event.item;
      emit.call(state.copyWith(itemList: tempList));
    }
  }

  FutureOr<void> _updateBottomStatus(
      UpdatingBottomStatusEvent event, Emitter<HomeState> emit) {
    emit.call(state.copyWith(isDragUpBottom: event.bottomStatus));
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
}
