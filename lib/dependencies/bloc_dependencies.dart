import 'package:get_it/get_it.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_bloc.dart';

class BlocDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory(() => HomeBloc());
    injector.registerFactory(() => ItemInfoBloc());
  }
}
