import 'package:link_in_bio/repository/database_helper.dart';
import 'package:link_in_bio/repository/i_app_repository.dart';
import 'package:sqflite/sqflite.dart';

class AppRepository implements IAppRepository {
  final DatabaseHelper _databaseHelper;

  AppRepository(this._databaseHelper);

  @override
  Future queryAll() async {
    Database db = await _databaseHelper.getDatabase();
  }
}
