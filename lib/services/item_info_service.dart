import 'package:link_in_bio/repository/i_app_repository.dart';

import 'i_services/i_item_info_service.dart';

class ItemInfoService implements IItemInfoService {
  final IAppRepository _appRepository;

  ItemInfoService(this._appRepository);

  @override
  Future getAll() async {
    await _appRepository.queryAll();
  }
}
