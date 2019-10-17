import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedClassFilter extends StatelessWidget{
  final String title;

  const SelectedClassFilter({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            color: Colors.black
        ),
      ),
      padding: EdgeInsets.all(5),
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: Theme.of(context).primaryColor
          ),
          color: Theme.of(context).primaryColor
      ),
    );
  }

}