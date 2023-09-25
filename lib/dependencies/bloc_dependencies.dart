import 'package:get_it/get_it.dart';
import 'package:link_in_bio/bloc/scanner/scanner_bloc.dart';
import 'package:link_in_bio/bloc/splash/splash_bloc.dart';
import '../bloc/bio_preview/bio_preview_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/item_info/item_info_bloc.dart';
import '../bloc/qr_code/qr_code_bloc.dart';

class BlocDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory(() => SplashBloc(injector()));
    injector.registerFactory(() => HomeBloc(injector()));
    injector.registerFactory(() => ItemInfoBloc(injector()));
    injector.registerFactory(() => QRCodeBloc());
    injector.registerFactory(() => BioPreviewBloc());
    injector.registerFactory(() => ScannerBloc(injector()));
  }
}
