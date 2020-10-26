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

  Future<List<Task>> getTasks() async {
    Database db = await database();
    List<Map<String, dynamic>> tasks = await db.query('tasks');
    return List.generate(tasks.length, (index) {
      return Task(id: tasks[index]["id"], title: tasks[index]["title"], description: tasks[index]["description"]);
    });    
  }
}