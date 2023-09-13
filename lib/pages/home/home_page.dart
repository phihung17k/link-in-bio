import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_state.dart';
import '../../models/item_model.dart';
import '../../utils/network_connectivity.dart';
import '../../bloc/home/home_event.dart';
import '../../routes.dart';
import 'widgets/floating_button_menu.dart';
import 'widgets/item_widget.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;
  const HomePage(this.bloc, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomeBloc get bloc => widget.bloc;

  AnimationController? deleteController;
  AnimationController? floatingButtonController;

  final NetworkConnectivity _networkConnectivity = NetworkConnectivity();

  @override
  void initState() {
    super.initState();

    _networkConnectivity.initialize();

    deleteController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    floatingButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    bloc.listenerStream.listen((event) {
      if (event is NavigatorItemInfoPageForCreatingEvent) {
        Navigator.pushNamed(context, Routes.itemInfo).then((item) {
          // if (item is ItemModel) {
          //   bloc.add(AddingItemEvent(item));
          // }

          if (item is bool && item) {
            bloc.add(ReloadAllItemEvent());
          }
        });
      } else if (event is NavigatorItemInfoPageForUpdatingEvent) {
        Navigator.pushNamed(context, Routes.itemInfo, arguments: event.item)
            .then((value) {
          if (value is ItemModel) {
            bloc.add(UpdatingItemEvent(event.index, value));
          }
        });
      } else if (event is NavigatorQRSharingPageEvent) {
        List<ItemModel> items = bloc.state.selectedIndexList!
            .map((index) => bloc.state.itemList![index])
            .toList();
        Navigator.pushNamed(context, Routes.qrCodeSharing, arguments: items)
            .then((value) => bloc.add(ResetSelectedItemsEvent()));
      } else if (event is NavigatorScannerPageEvent) {
        Navigator.pushNamed(context, Routes.scanner, arguments: Routes.home)
            .then((item) {
          if (item is ItemModel) {
            bloc.add(AddingItemEvent(item));
          }
        });
      } else if (event is NavigatorSettingPageEvent) {
        Navigator.pushNamed(context, Routes.setting);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null && setting.arguments is List<ItemModel>) {
      var items = setting.arguments as List<ItemModel>;
      bloc.add(RefreshItemsFromSplashPageEvent(items));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Stack(children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: BlocBuilder<HomeBloc, HomeState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/images/default_avatar.png'),
                            ),
                            const SizedBox(height: 10),
                            Text("Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text("Personal information",
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 10),
                            Flexible(
                              child: ReorderableListView(
                                onReorder: (oldIndex, newIndex) {
                                  bloc.add(ReorderItemEvent(
                                      oldIndex: oldIndex, newIndex: newIndex));
                                },
                                proxyDecorator: (child, index, animation) {
                                  return AnimatedBuilder(
                                    animation: animation,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      // animation's effect for reorder item
                                      // final double animValue = Curves.easeInOut
                                      //     .transform(animation.value);
                                      // final double elevation =
                                      //     lerpDouble(0, 5, animValue)!;
                                      return Material(
                                          elevation: 5,
                                          color: Colors.transparent,
                                          shadowColor: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: child);
                                    },
                                    child: child,
                                  );
                                },
                                children: state.itemList!.isNotEmpty
                                    ? [
                                        for (int i = 0;
                                            i < state.itemList!.length;
                                            i++)
                                          ItemWidget(
                                            key: UniqueKey(),
                                            index: i,
                                            item: state.itemList![i],
                                            deleteController: deleteController,
                                          )
                                      ]
                                    : [],
                              ),
                            ),
                          ],
                        );
                      })),
              FloatingButtonMenu(
                key: UniqueKey(),
                deleteController: deleteController,
                floatingButtonController: floatingButtonController,
              )
            ]),
          )),
    );
  }

  @override
  void dispose() {
    deleteController!.dispose();
    floatingButtonController!.dispose();
    bloc.close();
    super.dispose();
  }
}
