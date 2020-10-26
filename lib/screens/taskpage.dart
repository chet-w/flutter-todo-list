import 'package:flutter/material.dart';
import 'package:flutter_todo/database_helper.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/widgets/todowidget.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({Key key, @required this.task}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String taskTitle = "";
  int taskId = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  FocusNode titleNode;
  FocusNode descriptionNode;
  FocusNode todoNode;

  bool contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      print("task from home page: ${widget.task.toMap()}");
      taskTitle = widget.task.title;
      taskId = widget.task.id;
      contentVisible = true;
    }

    titleNode = FocusNode();
    descriptionNode = FocusNode();
    todoNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    titleNode.dispose();
    descriptionNode.dispose();
    todoNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                            24.0,
                          ),
                          child: Image(
                            image: AssetImage(
                              "assets/images/back_arrow_icon.png",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: titleNode,
                          controller: TextEditingController()..text = taskTitle,
                          decoration: InputDecoration(
                            hintText: "Enter a title",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xFF211552),
                          ),
                          onSubmitted: (value) async {
                            if (value != "") {
                              DatabaseHelper databaseHelper = DatabaseHelper();
                              if (widget.task == null) {
                                Task newTask = Task(
                                  title: value,
                                );
                                taskId = await databaseHelper.insertTask(newTask);
                                setState(() {
                                  contentVisible = true;
                                  taskTitle = value;
                                });
                                print("New task created!");
                              } else {
                                print("Update the task!");
                              }
                              descriptionNode.requestFocus();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 24.0,
                      ),
                      child: TextField(
                        focusNode: descriptionNode,
                        onSubmitted: (value) {
                          todoNode.requestFocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Enter a description",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xFF211552),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: contentVisible,
                    child: Expanded(
                      child: FutureBuilder(
                        initialData: [],
                        future: databaseHelper.getTodos(taskId),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return TodoWidget(
                                text: snapshot.data[index].title,
                                isDone: snapshot.data[index].isDone == 0
                                    ? false
                                    : true,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: contentVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Container(
                            height: 20.0,
                            width: 20.0,
                            margin: EdgeInsets.only(
                              right: 16.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xFF868290),
                                width: 1.5,
                              ),
                            ),
                            child: Image(
                              image: AssetImage(
                                "assets/images/check_icon.png",
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: todoNode,
                              onSubmitted: (value) async {
                                if (value != "") {
                                  DatabaseHelper databaseHelper =
                                      DatabaseHelper();
                                  if (widget.task != null) {
                                    Todo newTodo = Todo(
                                      title: value,
                                      taskId: taskId,
                                      isDone: 0,
                                    );
                                    await databaseHelper.insertTodo(newTodo);
                                    print("New todo created!");
                                    setState(() {});
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add todo to your task",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: contentVisible,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(task: null),
                        ),
                      );
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFE3572),
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Image(
                        image: AssetImage(
                          "assets/images/delete_icon.png",
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
