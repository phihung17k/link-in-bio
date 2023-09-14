import 'package:link_in_bio/repository/database_helper.dart';
import 'package:link_in_bio/repository/i_app_repository.dart';
import 'package:sqflite/sqflite.dart';

class AppRepository implements IAppRepository {
  final DatabaseHelper _databaseHelper;

  AppRepository(this._databaseHelper);

  @override
  Future<bool> initData() async {
    bool result;
    Database? db;
    try {
      db = await _databaseHelper.getDatabase();
      result = db != null;
    } catch (e) {
      throw Exception(e);
    } finally {
      await db?.close();
    }
    return result;
  }

  @override
  Future<List<Map<String, Object?>>> queryAll(String table) async {
    List<Map<String, Object?>> result;
    Database? db;
    try {
      db = await _databaseHelper.getDatabase();
      result = await db!.query(table);
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
      id = await db!
          .insert(table, values, conflictAlgorithm: ConflictAlgorithm.rollback);
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
      await db!.transaction((txn) async {
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

  @override
  Future<Map<String, Object?>> queryFromId(String table, int id) async {
    Database? db;
    try {
      db = await _databaseHelper.getDatabase();
      var queryResult =
          await db!.query(table, where: 'id = ?', whereArgs: [id]);
      if (queryResult.isNotEmpty) {
        return queryResult.first;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      await db?.close();
    }
    return {};
  }

  @override
  Future<bool> delete(String table, int id) async {
    Database? db;
    try {
      db = await _databaseHelper.getDatabase();
      int count = await db!.delete(table, where: 'id = ?', whereArgs: [id]);
      return count > 0;
    } catch (e) {
      throw Exception(e);
    } finally {
      await db?.close();
    }
  }

  @override
  Future<int> update(String table, Map<String, Object?> values) async {
    Database? db;
    try {
      db = await _databaseHelper.getDatabase();
      int count = await db!.update(table, values,
          where: 'id = ?',
          whereArgs: [values['id']],
          conflictAlgorithm: ConflictAlgorithm.rollback);
      return count;
    } catch (e) {
      throw Exception(e);
    } finally {
      await db?.close();
    }
  }
}
