import 'package:get_it/get_it.dart';
import 'package:link_in_bio/dependencies/repository_dependencies.dart';
import 'package:link_in_bio/dependencies/service_dependencies.dart';
import 'package:link_in_bio/repository/database_helper.dart';
import 'bloc_dependencies.dart';
import 'page_dependencies.dart';
import '../utils/network_connectivity.dart';

class AppDependencies {
  static GetIt get _injector => GetIt.instance;
  static Future setUp() async {
    _injector.registerLazySingleton(() => NetworkConnectivity());
    _injector.registerFactory(() => DatabaseHelper());
    await RepositoryDependencies.setUp(_injector);
    await ServiceDependencies.setUp(_injector);
    await BlocDependencies.setUp(_injector);
    await PageDependencies.setUp(_injector);
  }
}
