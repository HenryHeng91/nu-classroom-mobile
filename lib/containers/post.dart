import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/containers/post_assignment.dart';
import 'package:flutter_kickstart/containers/post_exam.dart';
import 'package:flutter_kickstart/containers/post_file.dart';
import 'package:flutter_kickstart/containers/post_header.dart';
import 'package:flutter_kickstart/containers/post_photo.dart';
import 'package:flutter_kickstart/containers/post_question.dart';
import 'package:flutter_kickstart/containers/post_review.dart';
import 'package:flutter_kickstart/containers/post_status.dart';
import 'package:flutter_kickstart/models/models.dart';

class PostWidget extends StatefulWidget{
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PostWidgetState();
  }
}

class _PostWidgetState extends State<PostWidget>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          PostHeader(
            post: widget.post,
          ),
          Divider(
            height: 1,
          ),
          Padding(
            child: Container(
              child: PostStatus(
                widget.post.detail,
                trimLines: 2,
                trimExpandedText: " Show Less",
                trimCollapsedText: "...More",
                colorClickableText: Color(0xFF294B76),
                trimMode: TrimMode.Line,
              ),
              width: double.infinity,
            ),
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
              bottom: 10
            ),
          ),
          Builder(
            builder: (context){
              switch(widget.post.postType){
                case "QUESTION":
                  return PostQuestion(
                    postQuestionSize: PostQuestionSize.big,
                    post: widget.post,
                  );
                case "FILE":
                  return PostFile(
                    postFileSize: PostFileSize.big,
                    post: widget.post,
                  );
                case "ASSIGNMENT":
                  return PostAssignment(
                    post: widget.post,
                  );
                case "EXAM":
                  return PostExam(
                    post: widget.post,
                  );
                default:
//                  return PostPhoto(
//                    post: widget.post,
//                  );
                  return SizedBox.shrink();
              }
            },
          ),
          PostReview(
            post: widget.post,
          )
        ],
      ),
      color: Colors.white,
    );
  }
}