import 'package:flutter/material.dart';

class Filter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "Post filter",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
            width: double.infinity,
          ),
          Container(
            color: Colors.black,
            height: 2,
            margin: EdgeInsets.only(
                top: 10,
                bottom: 10
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "From:",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                Container(
                  child: Text(
                    "Recents",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(
                bottom: 10
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Recents",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                ),
                Container(
                  child: Text(
                    "Yesterday",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                ),
                Container(
                  child: Text(
                    "Last month",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                ),
                Container(
                  child: Text(
                    "This year",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Class:",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                Container(
                  child: Text(
                    "Recents",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(
                bottom: 10,
                top: 20
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Recents",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                ),
                Container(
                  child: Text(
                    "Yesterday",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                ),
                Container(
                  child: Text(
                    "Last month",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                ),
                Container(
                  child: Text(
                    "This year",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  margin: EdgeInsets.only(
                      right: 5
                  ),
                )
              ],
            ),
          )
        ],
      ),
      padding: EdgeInsets.all(10),
    );
  }
}