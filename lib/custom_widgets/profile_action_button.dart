import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget{
  final String name;
  final Widget icon;
  final Function onTap;

  const ProfileActionButton({Key key, this.name, this.icon, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: icon,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2,
                      color: Colors.black
                  )
              ),
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(
                  bottom: 5
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}