import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/models.dart';

enum PostFileSize{
  small,
  big
}

class PostFile extends StatelessWidget{
  final PostFileSize postFileSize;
  final Post post;

  const PostFile({Key key, this.postFileSize=PostFileSize.big, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/pdf.png"),
              width: postFileSize == PostFileSize.big ? 100 : 60,
            ),
            VerticalDivider(
              width: 1,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: postFileSize == PostFileSize.big ? 100 : 60
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
                      post.file.file_name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
//                    Text(
//                      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et",
//                      maxLines: postFileSize == PostFileSize.big ? 3 : 1,
//                      overflow: TextOverflow.ellipsis,
//                    ),
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