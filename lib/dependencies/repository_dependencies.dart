import 'package:get_it/get_it.dart';
import 'package:link_in_bio/repository/i_app_repository.dart';

import '../repository/app_repository.dart';

class RepositoryDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory<IAppRepository>(() => AppRepository(injector()));
  }
}
