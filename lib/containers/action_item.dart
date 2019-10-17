import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionItem extends StatelessWidget{
  final Widget icon;
  final String title;
  final Function onTap;

  const ActionItem({Key key, this.icon, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          icon,
          Container(
            child: Text(title),
            margin: EdgeInsets.only(
              left: 10
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

}