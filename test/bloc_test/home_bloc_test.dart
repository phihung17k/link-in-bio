import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/bloc/home/home_event.dart';
import 'package:link_in_bio/bloc/home/home_state.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';

void main() {
  // expect data

  group("HomeBloc", () {
    late HomeBloc homeBloc;
    late ItemModel defaultItem;
    late ItemModel updatedItem;

    setUp(() {
      homeBloc = HomeBloc();
      defaultItem = const ItemModel(
          name: "name_test",
          category: ItemCategoryModel(
              baseURL: "baseURL_test",
              imageURL: "image_test",
              name: "category_name_test"),
          url: "url_test");
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