import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseMigration {
  String databaseName = "link_in_bio.db";

  String path = "";

  bool _isUpgrade = false;
  bool _isDowngrade = false;

  void upgrade() {
    _isUpgrade = true;
  }

  void downgrade() {
    _isDowngrade = true;
  }

  Future<void> execute() async {
    if (path.isEmpty) {
      String databasePath = await getDatabasesPath();
      await Directory(databasePath).create(recursive: true);
      path = join(databasePath, databaseName);
    }

    var tempDb = await openReadOnlyDatabase(path);
    int version = await tempDb.getVersion();
    await tempDb.close();

    if (_isUpgrade) {
      version++;
    }
    if (_isDowngrade) {
      version--;
    }

    var db = await openDatabase(
      path,
      version: version,
      onConfigure: (db) {
        debugPrint(" print Configure ");
      },
      onCreate: (db, version) {
        debugPrint(" print Create: $version ");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        debugPrint(
            " print Upgrade: oldVersion $oldVersion --- newVersion $newVersion ");
        await onUpgrade(db, oldVersion, newVersion);
      },
      onDowngrade: (db, oldVersion, newVersion) async {
        debugPrint(
            " print Downgrade: oldVersion $oldVersion --- newVersion $newVersion ");
        await onDowngrade(db, oldVersion, newVersion);
      },
      onOpen: (db) {
        debugPrint(" print Open ");
      },
    );

    await db.close();
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async {}
}
