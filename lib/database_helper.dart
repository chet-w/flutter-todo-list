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
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
        await db.execute(
            "CREATE TABLE todos(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)");
        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database db = await database();
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> updateTaskTitle(int taskId, String newTitle) async {
    Database db = await database();
    await db.rawUpdate("UPDATE tasks SET title = '$newTitle' WHERE id = '$taskId'");
  }

  Future<void> updateTaskDescription(int taskId, String newDescription) async {
    Database db = await database();
    print(taskId);
    await db.rawUpdate("UPDATE tasks SET description = '$newDescription' WHERE id = '$taskId'");
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

  Future<List<Todo>> getTodos(int taskId) async {
    Database db = await database();
    List<Map<String, dynamic>> todos = await db.rawQuery("SELECT * FROM todos WHERE taskId = $taskId");
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

  Future<void> updateTodoDone(int todoId, int newIsDone) async {
    Database db = await database();
    await db.rawUpdate("UPDATE todos SET isDone = '$newIsDone' WHERE id = '$todoId'");
  }

  Future<void> deleteTask(int taskId) async {
    Database db = await database();
    await db.rawDelete("DELETE FROM tasks WHERE id = '$taskId'");
    await db.rawDelete("DELETE FROM todos WHERE taskId = '$taskId'");
  }
}
