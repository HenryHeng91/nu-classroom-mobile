
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
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(comment.user.profilePicture ?? "")
                    ),
                    shape: BoxShape.circle
                )
            ),
          ),
          Expanded(
            child: Container(
              child: Text(comment.commentDetail),
              padding: EdgeInsets.all(5),
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