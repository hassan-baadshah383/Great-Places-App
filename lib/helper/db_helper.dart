import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Places(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL)');
    }, version: 1);
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await DbHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DbHelper.database();
    return await db.query(table);
  }
}
