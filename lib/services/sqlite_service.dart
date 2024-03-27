import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static const _databaseName = 'dictionary.db';
  static const _databaseVersion = 1;


  Future<Database> openMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE IF NOT EXISTS Words(
      id INTEGER PRIMARY KEY,
      word TEXT,
      phonemic TEXT,
      created_at TEXT,
      update_at TEXT,
      user_id INTEGER
    )
  ''');

        await db.execute('''
    CREATE TABLE IF NOT EXISTS "References"(
      id INTEGER PRIMARY KEY,
      reference TEXT,
      url TEXT
    )
  ''');

        await db.execute('''
  CREATE TABLE IF NOT EXISTS Meanings(
    id INTEGER PRIMARY KEY,
    meaning TEXT,
    comment TEXT,
    word_id INTEGER,
    reference_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY (word_id) REFERENCES Words(id),
    FOREIGN KEY (reference_id) REFERENCES "References"(id)
  )
''');
      },
    );
    return database;
  }
}
