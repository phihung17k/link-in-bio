import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/qr_code/qr_code_bloc.dart';
import 'widgets/qr_code_app.dart';
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

class _QRCodeSharingPageState extends State<QRCodeSharingPage> {
  QRCodeBloc get bloc => widget.bloc;

  final NetworkConnectivity _connectivity = NetworkConnectivity();

  @override
  void initState() {
    super.initState();

    _connectivity.initialize();
    _connectivity.connectionStream.listen((event) {
      if (!bloc.isClosed) {
        bloc.add(SetInternetInfoEvent(event));
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
      bloc.add(SetQRData(items));
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
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          color: Colors.green,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: const [Tab(text: "App"), Tab(text: "Web")]),
                  ),
                  const Expanded(
                    child: TabBarView(
                        children: [QRCodeAppWidget(), QRCodeWebWidget()]),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
