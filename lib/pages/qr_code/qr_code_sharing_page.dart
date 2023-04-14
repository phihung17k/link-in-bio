import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/qr_code/qr_code_bloc.dart';
import 'widgets/qr_code_app.dart';
import 'widgets/qr_code_items.dart';
import 'widgets/qr_code_web.dart';
import '../../routes.dart';
import '../../utils/network_connectivity.dart';
import '../../bloc/qr_code/qr_code_event.dart';
import '../../models/item_model.dart';

class QRCodeSharingPage extends StatefulWidget {
  final QRCodeBloc bloc;

  const QRCodeSharingPage(this.bloc, {super.key});

  @override
  State<QRCodeSharingPage> createState() => _QRCodeSharingPageState();
}

class _QRCodeSharingPageState extends State<QRCodeSharingPage>
    with SingleTickerProviderStateMixin {
  QRCodeBloc get bloc => widget.bloc;

  final NetworkConnectivity _connectivity = NetworkConnectivity();
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    _connectivity.initialize();
    _connectivity.connectionStream.listen((event) {
      if (!bloc.isClosed) {
        bloc.add(SetInternetInfoEvent(event));
        if (bloc.state.appQR!.isNotEmpty && bloc.state.webQR!.isEmpty) {
          bloc.add(SetWebQREvent());
        }
      }
    });

    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (tabController.index == 1 && bloc.state.webQR!.isEmpty) {
        bloc.add(SetWebQREvent());
      }
    });

    bloc.listenerStream.listen((event) {
      if (event is NavigatorBioPreviewPageEvent) {
        Navigator.pushNamed(context, Routes.bioPreview,
            arguments: bloc.state.items);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null && setting.arguments is List<ItemModel>) {
      List<ItemModel> items = setting.arguments as List<ItemModel>;
      bloc.add(SetAppQREvent(items));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        // backgroundColor: Colors.cyan.shade100,
        appBar: AppBar(
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    textStyle: Theme.of(context).textTheme.titleMedium),
                onPressed: () {
                  bloc.addNavigatedEvent(NavigatorBioPreviewPageEvent());
                },
                child: const Text("Preview"))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.green,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: "App"),
                    Tab(text: "Web"),
                    Tab(text: "Items")
                  ]),
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                QRCodeAppWidget(),
                QRCodeWebWidget(),
                QRCodeItemsWidget()
              ]),
            )
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    tabController.dispose();
    super.dispose();
  }
}
