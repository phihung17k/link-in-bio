import 'package:link_in_bio/services/i_services/i_splash_service.dart';
import '../repository/i_app_repository.dart';
import 'package:link_in_bio/utils/general_util.dart';

class SplashService with GeneralUtil implements ISplashService {
  final IAppRepository _appRepository;

  SplashService(this._appRepository);

  @override
  Future<bool> initData() async {
    try {
      return await _appRepository.initData();
    } catch (e) {
      throw Exception(e);
    }
  }
}
