import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
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
                      decoration: InputDecoration(
                        hintText: "Enter a title",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xFF211552),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 6.0,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
