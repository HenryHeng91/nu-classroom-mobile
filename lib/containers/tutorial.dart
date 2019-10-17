import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget{
  final String imagePath;
  final String title;
  final String description;

  const Tutorial({Key key, this.imagePath, this.title, this.description}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TutorialState();
  }
}

class _TutorialState extends State<Tutorial>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(widget.imagePath),
          Container(
            child: Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
            margin: EdgeInsets.only(
              bottom: 24,
              left: 22,
              right: 22
            ),
          ),
          Container(
            child: Text(
              widget.description,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            margin: EdgeInsets.only(
              right: 22,
              left: 22
            ),
          )
        ],
      ),
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(
        top: 22,
        bottom: 22
      ),
    );
  }
}