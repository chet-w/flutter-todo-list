import 'package:flutter/material.dart';

class Todos extends StatelessWidget {
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
              color: Color(0xFF7249FF),
            ),
            child: Image(
              image: AssetImage(
                "assets/images/check_icon.png",
              ),
            ),
          ),
          Text("yuo"),
        ],
      ),
    );
  }
}
