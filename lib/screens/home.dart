import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/taskcard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: Color(0xFFEEEEEE),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 32.0,
                    ),
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  Expanded(
                    child: ListView(children: [
                      TaskCard(
                        title: "Get stated",
                      ),
                      TaskCard(
                        title: "New card",
                        description: "Some description!",
                      ),
                      TaskCard(),
                      TaskCard(),
                      TaskCard(),
                    ]),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      color: Color(0xFF7349FE),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Image(
                    image: AssetImage(
                      "assets/images/add_icon.png",
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
