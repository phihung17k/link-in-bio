import 'package:get_it/get_it.dart';
import 'package:link_in_bio/dependencies/bloc_dependencies.dart';
import 'package:link_in_bio/dependencies/page_dependencies.dart';

class AppDependencies {
  static GetIt get _injector => GetIt.instance;
  static Future setUp() async {
    await BlocDependencies.setUp(_injector);
    await PageDependencies.setUp(_injector);
  }
}
