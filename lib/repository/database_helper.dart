import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static const String dbName = "link_in_bio.db";
  static const String itemCategoryTable = "ItemCategory";
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE ItemCategory (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
              name TEXT,
              imageURL TEXT,
              baseURL INTEGER, 
              url REAL
              )''');
      },
    );
  }
}
