import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/item_info/item_info_bloc.dart';
import '../../bloc/item_info/item_info_event.dart';
import '../../models/item_model.dart';
import 'item_category_sub_page.dart';
import 'item_content_sub_page.dart';

class ItemInfoPage extends StatefulWidget {
  final ItemInfoBloc bloc;
  const ItemInfoPage(this.bloc, {super.key});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  ItemInfoBloc get bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    bloc.add(InitialDataEvent());

    bloc.listenerStream.listen((event) {
      if (event is BackingHomePageEvent) {
        ItemModel item = bloc.state.item!;
        if (item.name == null || item.name!.trim().isEmpty) {
          item = item.copyWith(name: item.category!.name);
        }
        Navigator.pop(context, item);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null && setting.arguments is ItemModel) {
      ItemModel item = setting.arguments as ItemModel;
      bloc.add(UpdatingCurrentItemEvent(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: BlocProvider.value(
        value: bloc,
        child: Scaffold(
            backgroundColor: Colors.cyan[50],
            appBar: AppBar(
              title: const Text('Settings'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Container(
                  margin:
                      const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[300]),
                  child: TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blue),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                              Icon(Icons.category),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Category")
                            ])),
                        Tab(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                              Icon(Icons.info_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Detail")
                            ]))
                      ]),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [ItemCategorySubPage(), ItemContentSubPage()],
                  ),
                )
              ]),
            )),
      ),
    );
  }
}
