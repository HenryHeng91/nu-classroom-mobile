import 'package:flutter/material.dart';
import 'package:flutter_kickstart/containers/class_item.dart';

class NotificationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Notifications",
          style: TextStyle(
              fontSize: 24
          ),
        ),
        leading: Icon(Icons.sort),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){

            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Builder(
        builder: (context){
          return Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "No new notifications",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  Image.asset(
                      "assets/images/no_notification.png"
                  )
                ],
              ),
            ),
            padding: EdgeInsets.all(20),
          );
        },
      ),
    );
  }
}