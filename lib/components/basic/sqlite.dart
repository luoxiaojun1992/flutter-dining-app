import 'package:sqflite/sqflite.dart';

class Sqlite {
  static Database database;

  static init() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'dining.db';

    // open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE IF NOT EXISTS credential (id INTEGER PRIMARY KEY AUTOINCREMENT, token TEXT)');
    });
  }

  static insert(String sql, List<dynamic> arguments) async {
    if (database != null) {
      return await database.rawInsert(sql, arguments);
    }
  }

  static update(String sql, List<dynamic> arguments) async {
    if (database != null) {
      return await database.rawUpdate(sql, arguments);
    }
  }

  static query(String sql, List<dynamic> arguments) async {
    if (database != null) {
      return await database.rawQuery(sql, arguments);
    }
  }
}
