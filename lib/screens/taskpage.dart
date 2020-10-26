import 'package:flutter/material.dart';
import 'package:flutter_todo/database_helper.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/widgets/todo.dart';

class TaskPage extends StatefulWidget {

  final Task task;

  const TaskPage({Key key, @required this.task}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  String taskTitle = "";

  @override
  void initState() {
    if(widget.task != null) {
      taskTitle = widget.task.title;
    }
    super.initState();
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
                            if(value != "") {
                              DatabaseHelper databaseHelper = DatabaseHelper();
                              if(widget.task == null) {
                                Task newTask = Task(
                                  title: value,
                                );
                                await databaseHelper.insertTask(newTask);
                                print("New task created!");
                              } else {
                                print("Update the task!");
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 24.0,
                    ),
                    child: TextField(
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
                  Todo(
                    text: "First",
                    isDone: true,
                  ),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
