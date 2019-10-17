import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 1
                ),
                shape: BoxShape.circle,
                color: Colors.white
            ),
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(
              right: 10
            ),
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/plan.png")
                    ),
                    shape: BoxShape.circle
                )
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Luy Mithona",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "10 minutes ago",
                  style: TextStyle(
                    fontSize: 12
                  ),
                )
              ],
            )
          ),
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            )
          )
        ],
      ),
      padding: EdgeInsets.all(10),
    );
  }
}