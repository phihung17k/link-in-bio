import 'package:flutter/widgets.dart';
import 'package:link_in_bio/repository/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'base_migration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  M202308301427 migration = M202308301427();
  migration.upgrade();
  await migration.execute();
}

class M202308301427 extends BaseMigration {
  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.transaction((txn) async {
      var batch = txn.batch();
      batch.execute(
          "ALTER TABLE ${DatabaseHelper.itemCategory} ADD app_url TEXT");
      batch.execute(
          "ALTER TABLE ${DatabaseHelper.itemCategory} ADD web_url TEXT");
      await batch.commit();
    });
  }

  @override
  Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async {}
}
