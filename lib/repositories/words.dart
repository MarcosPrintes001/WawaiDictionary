import 'package:waiwai_dictionary/db/connection.dart';
import 'package:waiwai_dictionary/models/word.dart';
import 'package:waiwai_dictionary/models/reference.dart';
import 'package:waiwai_dictionary/models/meaning.dart';
import 'package:waiwai_dictionary/models/user.dart';
import 'package:sqflite/sqflite.dart';

class Words {
  static final Words _taskDb = Words._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  Words._internal(this._appDatabase);

  //static TaskDB get taskDb => _taskDb;

  static Words get() {
    return _taskDb;
  }

  //Future<List<Word>>
  void getWords({String? q, int page = 1, pageSize = 100}) async {
    var db = await _appDatabase.getDb();

    var offset = (page - 1) * pageSize;
    var limit = pageSize;

    var whereClause = q != null ? "WHERE ${Word.wordColumn} LIKE '%$q%'" : "";

    var result = await db.rawQuery(
        'SELECT * FROM ${Word.tableName} $whereClause ORDER BY ${Word.idColumn} DESC LIMIT $limit OFFSET $offset;');
    _bindWords(result);

    // return _bindWords(result);
  }

  // List<Word>
  void _bindWords(List<Map<String, dynamic>> result) {
    List<Word> tasks = [];
    for (Map<String, dynamic> item in result) {
      print(item);
      // var myTask = Word(item);
      // myTask.projectName = item[Project.dbName];
      // myTask.projectColor = item[Project.dbColorCode];
      // var labelComma = item["labelNames"];
      // if (labelComma != null) {
      //   myTask.labelList = labelComma.toString().split(",");
      // }
      // tasks.add(myTask);
    }
    // return tasks;
  }

  // Future<List<Tasks>> getTasksByProject(int projectId,
  //     {TaskStatus? status}) async {
  //   var db = await _appDatabase.getDb();
  //   String whereStatus = status != null
  //       ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${status.index}"
  //       : "";
  //   var result = await db.rawQuery(
  //       'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
  //       'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
  //       'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
  //       'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=$projectId $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

  //   return _bindData(result);
  // }

  // Future<List<Tasks>> getTasksByLabel(String labelName,
  //     {TaskStatus? status}) async {
  //   var db = await _appDatabase.getDb();
  //   String whereStatus = status != null
  //       ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${TaskStatus.PENDING.index}"
  //       : "";
  //   var result = await db.rawQuery(
  //       'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
  //       'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
  //       'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=${Project.tblProject}.${Project.dbId} $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} having labelNames LIKE "%$labelName%" ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

  //   return _bindData(result);
  // }

  // Future deleteTask(int taskID) async {
  //   var db = await _appDatabase.getDb();
  //   await db.transaction((Transaction txn) async {
  //     await txn.rawDelete(
  //         'DELETE FROM ${Tasks.tblTask} WHERE ${Tasks.dbId}=$taskID;');
  //   });
  // }

  // Future updateTaskStatus(int taskID, TaskStatus status) async {
  //   var db = await _appDatabase.getDb();
  //   await db.transaction((Transaction txn) async {
  //     await txn.rawQuery(
  //         "UPDATE ${Tasks.tblTask} SET ${Tasks.dbStatus} = '${status.index}' WHERE ${Tasks.dbId} = '$taskID'");
  //   });
  // }

  // /// Inserts or replaces the task.
  // Future updateTask(Tasks task, {List<int>? labelIDs}) async {
  //   var db = await _appDatabase.getDb();
  //   await db.transaction((Transaction txn) async {
  //     int id = await txn.rawInsert('INSERT OR REPLACE INTO '
  //         '${Tasks.tblTask}(${Tasks.dbId},${Tasks.dbTitle},${Tasks.dbProjectID},${Tasks.dbComment},${Tasks.dbDueDate},${Tasks.dbPriority},${Tasks.dbStatus})'
  //         ' VALUES(${task.id}, "${task.title}", ${task.projectId},"${task.comment}", ${task.dueDate},${task.priority.index},${task.tasksStatus!.index})');
  //     if (id > 0 && labelIDs != null && labelIDs.length > 0) {
  //       labelIDs.forEach((labelId) {
  //         txn.rawInsert('INSERT OR REPLACE INTO '
  //             '${TaskLabels.tblTaskLabel}(${TaskLabels.dbId},${TaskLabels.dbTaskId},${TaskLabels.dbLabelId})'
  //             ' VALUES(null, $id, $labelId)');
  //       });
  //     }
  //   });
  // }
}
