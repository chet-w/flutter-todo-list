import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';
import 'models/todo.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE tasks(id INTERGER PRIMARY KEY, title TEXT, description TEXT)");
        await db.execute(
            "CREATE TABLE todos(id INTERGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)");
        return db;
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    Database db = await database();
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTodo(Todo todo) async {
    Database db = await database();
    await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    Database db = await database();
    List<Map<String, dynamic>> tasks = await db.query('tasks');
    return List.generate(tasks.length, (index) {
      return Task(
          id: tasks[index]["id"],
          title: tasks[index]["title"],
          description: tasks[index]["description"]);
    });
  }

  Future<List<Todo>> getTodos() async {
    Database db = await database();
    List<Map<String, dynamic>> todos = await db.query('todos');
    return List.generate(
      todos.length,
      (index) {
        return Todo(
            id: todos[index]["id"],
            taskId: todos[index]["taskId"],
            title: todos[index]["title"],
            isDone: todos[index]["isDone"]);
      },
    );
  }
}
