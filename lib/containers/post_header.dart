import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/utils/date_util.dart';

class PostHeader extends StatelessWidget{
  final Post post;

  const PostHeader({Key key, this.post}) : super(key: key);

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
                        image: NetworkImage(post.user.profilePicture ?? "")
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
                  "${post.user.firstName} ${post.user.lastName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  DateUtil.diff(post.createDate),
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