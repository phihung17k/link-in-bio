import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String _databaseName = "link_in_bio.db";
  final int _databaseVersion = 1;
  static const String itemCategory = "item_category";
  static const String item = "item";

  Database? _database;

  Future<Database> getDatabase() async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await _initDatabaseLocation();
    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _database!;
  }

  Future<String> _initDatabaseLocation() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String databasePath = await getDatabasesPath();

    // Make sure the directory exists
    await Directory(databasePath).create(recursive: true);

    return join(databasePath, _databaseName);
  }

  Future _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('''CREATE TABLE $itemCategory (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              topic TEXT,
              name TEXT,
              image TEXT
              )''');
      await txn.execute('''CREATE TABLE $item (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              name TEXT,
              phone_number TEXT,
              message TEXT,
              url TEXT,
              address TEXT,
              cc TEXT,
              bcc TEXT,
              subject TEXT,
              body TEXT,
              network_name TEXT,
              password TEXT,
              encryption TEXT,
              is_hidden BOOLEAN NOT NULL CHECK (is_hidden IN (0, 1)),
              item_category_id INTEGER NOT NULL,
              FOREIGN KEY (item_category_id) REFERENCES item_category (id) ON DELETE NO ACTION
              )''');
    });
  }
}
