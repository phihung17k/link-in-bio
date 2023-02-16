import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_event.dart';
import 'package:link_in_bio/bloc/item_info/item_info_state.dart';
import 'package:link_in_bio/models/item_model.dart';

class ItemInfoBloc extends Bloc<ItemInfoEvent, ItemInfoState> {
  ItemInfoBloc() : super(const ItemInfoState(categoryIndex: 0)) {
    on<SetItemEvent>(setItemCategory);
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
