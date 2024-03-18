import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:waiwai_dictionary/models/wordModels.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static late Database _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'waiwaiData.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE words(
        id INTEGER PRIMARY KEY,
        word TEXT,
        phonemic TEXT,
        created_at TEXT,
        update_at TEXT,
        user_id INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE references(
        id INTEGER PRIMARY KEY,
        reference TEXT,
        url TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE meanings(
        id INTEGER PRIMARY KEY,
        meaning TEXT,
        comment TEXT,
        word_id INTEGER,
        reference_id INTEGER,
        user_id INTEGER
      )
    ''');
  }

  Future<void> insertWord(Word word) async {
    final db = await database;
    await db.insert('words', word.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertReference(Reference reference) async {
    final db = await database;
    await db.insert('references', reference.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertMeaning(Meaning meaning) async {
    final db = await database;
    await db.insert('meanings', meaning.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Word>> getWords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('words');
    return List.generate(maps.length, (i) {
      return Word(
        id: maps[i]['id'],
        word: maps[i]['word'],
        phonemic: maps[i]['phonemic'],
        createdAt: DateTime.parse(maps[i]['created_at']),
        updatedAt: DateTime.parse(maps[i]['update_at']),
        userId: maps[i]['user_id'],
      );
    });
  }
}
