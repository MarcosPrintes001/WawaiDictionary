import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:waiwai_dictionary/models/word.dart';
import 'package:waiwai_dictionary/models/reference.dart';
import 'package:waiwai_dictionary/models/meaning.dart';
import 'package:waiwai_dictionary/models/user.dart';

class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  AppDatabase._internal();

  late Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  Future<Database> getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "localWaiwai.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await _createUserTable(db);
      await _createWordTable(db);
      await _createReferenceTable(db);
      await _createMeaningTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE IF EXISTS ${Meaning.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${Reference.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${Word.tableName}");
      await db.execute("DROP TABLE IF EXISTS ${User.tableName}");

      await _createUserTable(db);
      await _createWordTable(db);
      await _createReferenceTable(db);
      await _createMeaningTable(db);
    });
    didInit = true;
  }

  Future _createUserTable(Database db) {
    return db.transaction((Transaction txn) async {
      await txn.execute("CREATE TABLE ${User.tableName} ("
          "${User.idColumn} INTEGER PRIMARY KEY,"
          "${User.fullnameColumn} TEXT;");
    });
  }

  Future _createWordTable(Database db) {
    return db.transaction((Transaction txn) async {
      await txn.execute("CREATE TABLE ${Word.tableName} ("
          "${Word.idColumn} INTEGER PRIMARY KEY,"
          "${Word.wordColumn} TEXT,"
          "${Word.phonemicColumn} TEXT,"
          "${Word.createdAtColumn} TEXT,"
          "${Word.updateAtColumn} TEXT,"
          "${Word.userIdColumn} INTEGER,"
          "FOREIGN KEY(${Word.userIdColumn}) REFERENCES ${User.tableName}(${User.idColumn}) ON DELETE CASCADE);");
    });
  }

  Future _createReferenceTable(Database db) {
    return db.transaction((Transaction txn) async {
      await txn.execute("CREATE TABLE ${Reference.tableName} ("
          "${Reference.idColumn} INTEGER PRIMARY KEY,"
          "${Reference.referenceColumn} TEXT,"
          "${Reference.urlColumn} TEXT;");
    });
  }

  Future _createMeaningTable(Database db) {
    return db.transaction((Transaction txn) async {
      await txn.execute("CREATE TABLE ${Meaning.tableName} ("
          "${Meaning.idColumn} INTEGER PRIMARY KEY,"
          "${Meaning.meaningColumn} TEXT,"
          "${Meaning.commentColumn} TEXT,"
          "${Meaning.chapterIdColumn} INTEGER,"
          "${Meaning.entryIdColumn} INTEGER,"
          "${Meaning.wordIdColumn} INTEGER,"
          "${Meaning.referenceIdColumn} INTEGER,"
          "${Meaning.userIdColumn} INTEGER,"
          "FOREIGN KEY(${Meaning.referenceIdColumn}) REFERENCES ${Reference.tableName}(${Reference.idColumn}) ON DELETE CASCADE,"
          "FOREIGN KEY(${Meaning.userIdColumn}) REFERENCES ${User.tableName}(${User.idColumn}) ON DELETE CASCADE);");
    });
  }
}
