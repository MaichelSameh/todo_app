// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_info.dart';
import '../widgets/custom_icons.dart';

class DBHelper {
  static Database? _db;
  static const String _task_icon_table_name = "task_icons";
  static const String _tasks_table_name = "tasks";

  void _echo({
    required String variableName,
    required String functionName,
    required dynamic data,
  }) {
    // ignore: avoid_print
    print("DB_HELPER $functionName $variableName: $data");
  }

  Future<Database> database() async {
    if (_db != null) {
      return _db!;
    } else {
      Directory dir = await path_provider.getApplicationDocumentsDirectory();
      Database db = await openDatabase(
        dir.path + "todo.db",
        version: 1,
        onCreate: (db, _) async {
          await db.execute('''
        CREATE TABLE $_task_icon_table_name (
          name TEXT NOT NULL,
          id INTEGER NOT NULL PRIMARY KEY
        );
        );
        ''');
          await db.execute('''
        CREATE TABLE $_tasks_table_name (
          date TEXT NOT NULL,
          description TEXT NOT NULL,
          icon_type INTEGER NOT NULL,
          status INTEGER NOT NULL,
          title TEXT NOT NULL,
          id INTEGER NOT NULL PRIMARY KEY,
          FOREIGN KEY (icon_type) REFERENCES $_task_icon_table_name(id)
        );''');
          db.insert(_task_icon_table_name, {
            "name": "shopping",
            "id": 1,
          });
          db.insert(_task_icon_table_name, {
            "name": "sports",
            "id": 2,
          });
          db.insert(_task_icon_table_name, {
            "name": "visits",
            "id": 3,
          });
          db.insert(_task_icon_table_name, {
            "name": "parties",
            "id": 4,
          });
          db.insert(_task_icon_table_name, {
            "name": "workout",
            "id": 5,
          });
          db.insert(_task_icon_table_name, {
            "name": "others",
            "id": 6,
          });
          SharedPreferences.getInstance()
              .then((pref) => pref.setInt(_tasks_table_name, 1));
        },
      );
      _db = db;
      return _db!;
    }
  }

  Future<List<TaskInfo>> getAllTasks([
    CustomIconStatus status = CustomIconStatus.none,
  ]) async {
    List<TaskInfo> tasks = [];
    try {
      Database db = await database();
      List<Map<String, dynamic>> res = await db.query(_tasks_table_name,
          where: "status = ${status == CustomIconStatus.done ? 1 : 0}");
      for (Map<String, dynamic> task in res) {
        tasks.add(TaskInfo.fromLocalDB(task));
      }
    } catch (error) {
      _echo(variableName: "error", functionName: "getAllTasks", data: error);
    }
    return tasks;
  }

  Future<List<TaskInfo>> getTasksByDate(DateTime date) async {
    List<TaskInfo> tasks = [];
    try {
      Database db = await database();
      List<Map<String, dynamic>> res = await db.query(_tasks_table_name,
          where:
              "date > '${DateFormat("yyyy-MM-dd").format(date)}' AND date <  '${DateFormat("yyyy-MM-dd").format(date.add(const Duration(days: 1)))}'");
      for (Map<String, dynamic> task in res) {
        tasks.add(TaskInfo.fromLocalDB(task));
      }
    } catch (error) {
      _echo(variableName: "error", functionName: "getTasksByDate", data: error);
    }
    return tasks;
  }

  Future<bool> updateTaskStatus(int id, CustomIconStatus status) async {
    try {
      Database db = await database();
      db.update(_tasks_table_name,
          {"status": status == CustomIconStatus.done ? 1 : 0},
          where: "id = $id");
    } catch (error) {
      _echo(
          variableName: "error", functionName: "updateTaskStatus", data: error);
    }
    return false;
  }

  Future<bool> insertTask(TaskInfo task) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      Database db = await database();
      int id = await db.insert(
          _tasks_table_name,
          task.toMap()
            ..putIfAbsent("id", () => pref.getInt(_tasks_table_name) ?? 1));
      pref.setInt(_tasks_table_name, id + 1);
    } catch (error) {
      _echo(variableName: "error", functionName: "insertTask", data: error);
    }
    return false;
  }

  Future<bool> deleteTask(int id) async {
    try {
      Database db = await database();
      db.delete(_task_icon_table_name, where: "id = $id");
    } catch (error) {
      _echo(variableName: "error", functionName: "deleteTask", data: error);
    }
    return false;
  }
}
