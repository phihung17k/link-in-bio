import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/main.dart';
import 'package:link_in_bio/utils/network_connectivity.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../models/item_model.dart';
import '../../routes.dart';
import 'widgets/floating_button_menu.dart';
import 'widgets/reorder_list_widget.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;

  const HomePage(this.bloc, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, RouteAware {
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
        Navigator.pushNamed(context, Routes.itemInfo);
        // .then((isSuccess) {
        //   if (isSuccess is bool && isSuccess) {
        //     bloc.add(ReloadAllItemEvent());
        //   }
        // });
      } else if (event is NavigatorItemInfoPageForUpdatingEvent) {
        Navigator.pushNamed(context, Routes.itemInfo, arguments: event.item);
        //     .then((isSuccess) {
        //   if (isSuccess is bool && isSuccess) {
        //     bloc.add(ReloadAllItemEvent());
        //   }
        // });
      } else if (event is NavigatorQRSharingPageEvent) {
        List<ItemModel> items = bloc.state.selectedIndexList!
            .map((index) => bloc.state.itemList![index])
            .toList();
        Navigator.pushNamed(context, Routes.qrCodeSharing, arguments: items)
            .then((value) => bloc.add(ResetSelectedItemsEvent()));
      } else if (event is NavigatorScannerPageEvent) {
        Navigator.pushNamed(context, Routes.scanner, arguments: Routes.home);
      } else if (event is NavigatorSettingPageEvent) {
        Navigator.pushNamed(context, Routes.setting);
      }
    });

    bloc.add(ReloadAllItemEvent());
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/default_avatar.png'),
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
                    child: ReorderListWidget(deleteController),
                  ),
                ],
              ),
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
  void didPopNext() {
    // home -> scanner -> (pushReplace) -> itemInfo -> pop -> home
    // => previous: home
    // => current: itemInfo
    if (routeObserver.previousRouteName == Routes.home &&
        routeObserver.currentRouteName == Routes.itemInfo) {
      bloc.add(ReloadAllItemEvent());
    }
  }

  @override
  void dispose() {
    deleteController!.dispose();
    floatingButtonController!.dispose();
    bloc.close();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
