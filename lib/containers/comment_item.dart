
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/models.dart';

class CommentItem extends StatelessWidget{
  final Comment comment;

  const CommentItem({Key key, this.comment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: ClipRRect(
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/dummy.png",
                image: comment.user.profilePicture,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(54)),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(comment.commentDetail),
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
                top: 10,
                bottom: 10
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              margin: EdgeInsets.only(
                right: 60
              ),
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10
      ),
    );
  }

}