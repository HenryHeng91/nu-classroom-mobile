import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/models.dart';

enum PostQuestionSize{
  small,
  big
}

class PostQuestion extends StatelessWidget{
  final PostQuestionSize postQuestionSize;
  final Post post;

  const PostQuestion({Key key, this.postQuestionSize=PostQuestionSize.big, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/question.png"),
              width: postQuestionSize == PostQuestionSize.big ? 100 : 60,
            ),
            VerticalDivider(
              width: 1,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: postQuestionSize == PostQuestionSize.big ? 100 : 60
                ),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 1,
                      color: Colors.black
                    )
                  )
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.classwork.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      post.classwork.description,
                      maxLines: postQuestionSize == PostQuestionSize.big ? 3 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Size: 4.3MB",
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: Colors.black,
            width: 1
          )
        ),
      ),
      padding: EdgeInsets.only(
        left: 10,
        right: 10
      ),
    );
  }
}