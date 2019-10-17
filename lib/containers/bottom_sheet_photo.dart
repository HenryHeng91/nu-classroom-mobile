import 'package:flutter/material.dart';

class BottomSheetPhoto extends StatelessWidget{
  final Function onChooseGallery;
  final Function onChooseCamera;

  const BottomSheetPhoto({Key key, this.onChooseGallery, this.onChooseCamera}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Choose Source',
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
                              "GALLERY",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor
                              ),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.all(10),
                            width: double.infinity
                        ),
                        onTap: onChooseGallery,
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
                            "CAMERA",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor
                            ),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(10),
                          width: double.infinity
                      ),
                      onTap: onChooseCamera,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        padding: EdgeInsets.all(10),
      ),
      heightFactor: 0.3,
    );
  }
}