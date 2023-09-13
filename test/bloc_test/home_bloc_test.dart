import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/bloc/home/home_event.dart';
import 'package:link_in_bio/bloc/home/home_state.dart';
import 'package:link_in_bio/models/data_model.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';

void main() {
  // expect data

  group("HomeBloc", () {
    late HomeBloc homeBloc;
    late ItemModel defaultItem;
    late ItemModel updatedItem;

    setUp(() {
      homeBloc = GetIt.I.get<HomeBloc>();
      defaultItem = ItemModel(
          name: "name_test",
          category: const ItemCategoryModel(
              webUrl: "baseURL_test",
              image: "image_test",
              name: "category_name_test"),
          url: UrlModel(url: "url_test"));
      updatedItem = defaultItem.copyWith(name: 'update');
    });

    test("Initial Test", () {
      expect(
          homeBloc.state,
          const HomeState(
              itemList: [], selectedIndexList: [], isSelectAll: false));
    });

    blocTest<HomeBloc, HomeState>(
      "AddingItemEvent",
      build: () => homeBloc,
      act: (bloc) => bloc.add(AddingItemEvent(defaultItem)),
      expect: () => [
        HomeState(
            itemList: [defaultItem],
            isSelectAll: false,
            selectedIndexList: const [])
      ],
    );

    blocTest<HomeBloc, HomeState>(
      "UpdatingItemEvent",
      build: () => homeBloc,
      seed: () => HomeState(
          itemList: [defaultItem],
          isSelectAll: false,
          selectedIndexList: const []),
      act: (bloc) => bloc.add(UpdatingItemEvent(0, updatedItem)),
      expect: () => [
        HomeState(
            itemList: [updatedItem],
            isSelectAll: false,
            selectedIndexList: const [])
      ],
    );
  });
}
