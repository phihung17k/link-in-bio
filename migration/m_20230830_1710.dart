import 'package:flutter/widgets.dart';
import 'package:link_in_bio/repository/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'base_migration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  M202308301710 migration = M202308301710();
  migration.upgrade();
  await migration.execute();
}

class M202308301710 extends BaseMigration {
  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.transaction((txn) async {
      var batch = txn.batch();
      batch.delete(DatabaseHelper.itemCategory);
      await batch.commit();
    });
  }

  @override
  Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async {}
}
