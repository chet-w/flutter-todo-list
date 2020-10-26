import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {

  final String text;
  final bool isDone;

  const TodoWidget({Key key, this.text, @required this.isDone}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
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
              color: isDone ? Color(0xFF7249FF) : Colors.transparent,
              border: isDone ? null : Border.all(
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
          Text(
            text ?? "Untitled task",
            style: TextStyle(
              color: isDone ? Color(0xFF211551) : Color(0xFF868290),
              fontSize: 16.0,
              fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
