import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:waiwai_dictionary/models/wordModels.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'dictionay.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
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
    CREATE TABLE IF NOT EXISTS "ReferencesTable"(
      id INTEGER PRIMARY KEY,
      reference TEXT,
      url TEXT
    )
  ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS MeaningsTable(
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

    await db.execute('''
    CREATE TABLE IF NOT EXISTS VersionTable(
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
  }

  Future<int> insertWord(Word word) async {
    Database db = await database;
    return await db.insert('Words', word.toMap());
  }

  Future<int> insertReference(Reference reference) async {
    Database db = await database;
    return await db.insert('ReferencesTable', reference.toMap());
  }

  Future<int> insertMeaning(Meaning meaning) async {
    Database db = await database;
    return await db.insert('MeaningsTable', meaning.toMap());
  }

  Future<List<Map<String, dynamic>>> getWords() async {
    Database db = await database;
    return await db.query('Words');
  }

  Future<int> getWordCount() async {
    Database db = await database;

    var result = await db.rawQuery('SELECT COUNT(1) as total FROM Words');

    var totalResult = result.first;

    return totalResult['total'] as int;
  }

  Future<List<Word>> getWordPage(
      {String q = '', int page = 1, int size = 50}) async {
    int offset = (page - 1) * size;
    int limit = size;

    Database db = await database;
    List<Map<String, dynamic>> maps;
    if (q.isNotEmpty) {
      q = '%$q%';
      maps = await db.query('Words',
          offset: offset, limit: limit, where: 'word like ?', whereArgs: [q]);
    } else {
      maps = await db.query(
        'Words',
        offset: offset,
        limit: limit,
      );
    }
    List<Word> resultados = [];
    for (var e in maps) {
      resultados.add(Word.fromJson(e));
    }
    return resultados;
  }

  Future<Word> getWordById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Words',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Word.fromJson(maps.first);
    }
    throw Exception('Word not found');
  }

  Future<List<Map<String, dynamic>>> getReferences() async {
    Database db = await database;
    return await db.query('ReferencesTable');
  }

  Future<String> getReferenceNameById(int id) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> maps = await db.query(
        'ReferencesTable',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return maps.first['reference'];
      } else {
        return 'Referência Indisponível';
      }
    } catch (e) {
      return 'Erro ao buscar referência: $e';
    }
  }

  Future<List<Map<String, dynamic>>> getMeanings() async {
    Database db = await database;
    return await db.query('MeaningsTable');
  }
}
