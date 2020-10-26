import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {

  final String title;
  final String description;

  const TaskCard({Key key, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        bottom: 24.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title ?? "Untitled task",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Color(0xFF211551),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              description ?? "No description yet",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF868290),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );;
  }
}