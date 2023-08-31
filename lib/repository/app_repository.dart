import 'package:link_in_bio/repository/database_helper.dart';
import 'package:link_in_bio/repository/i_app_repository.dart';
import 'package:sqflite/sqflite.dart';

class AppRepository implements IAppRepository {
  final DatabaseHelper _databaseHelper;

  AppRepository(this._databaseHelper);

  @override
  Future<List<Map<String, Object?>>> queryAll(String table) async {
    List<Map<String, Object?>> result;
    Database? db;
    try {
      db = await _databaseHelper.getDatabase();
      result = await db.query(table);
    } catch (e) {
      throw Exception(e);
    } finally {
      await db?.close();
    }
    return result;
  }

  @override
  Future<int> insert(String table, Map<String, Object?> values) async {
    if (values.isEmpty) {
      return 0;
    }
    Database? db;
    int id = 0;
    try {
      db = await _databaseHelper.getDatabase();
      id = await db.insert(table, values,
          conflictAlgorithm: ConflictAlgorithm.rollback);
    } catch (e) {
      throw Exception(e);
    } finally {
      await db?.close();
    }
    return id;
  }

  @override
  Future<bool> insertBatch(
      String table, List<Map<String, Object?>> valueList) async {
    if (valueList.isEmpty) {
      return false;
    }
    Database? db;
    try {
      db = await _databaseHelper.getDatabase();
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        for (var values in valueList) {
          batch.insert(table, values,
              conflictAlgorithm: ConflictAlgorithm.rollback);
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      throw Exception(e);
    } finally {
      await db?.close();
    }
    return true;
  }
}
