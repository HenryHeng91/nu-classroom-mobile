import 'package:flutter/material.dart';

class BottomSheetCreateClass extends StatelessWidget{
  final Function onChooseCreate;
  final Function onChooseJoin;

  const BottomSheetCreateClass({Key key, this.onChooseCreate, this.onChooseJoin, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Create or Share Class',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              margin: EdgeInsets.only(
                  bottom: 10
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1
                          )
                      ),
                      color: Colors.transparent,
                      child: InkWell(
                        child: Container(
                            child: Text(
                              "Create",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor
                              ),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.all(10),
                            width: double.infinity
                        ),
                        onTap: onChooseCreate,
                      ),
                    ),
                    margin: EdgeInsets.only(
                        bottom: 10
                    ),
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1
                        )
                    ),
                    color: Colors.transparent,
                    child: InkWell(
                      child: Container(
                          child: Text(
                            "Join",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor
                            ),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(10),
                          width: double.infinity
                      ),
                      onTap: onChooseJoin,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        padding: EdgeInsets.all(10),
      ),
      heightFactor: 0.5,
    );
  }
}