import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';

class DatabaseHelper {


  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTERGER PRIMARY KEY, title TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    Database db = await database();
    await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);


  }
}