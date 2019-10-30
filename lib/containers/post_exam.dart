import 'package:flutter/material.dart';
import 'package:flutter_kickstart/containers/post_file.dart';
import 'package:flutter_kickstart/containers/post_question.dart';
import 'package:flutter_kickstart/containers/post_status.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/presentations/take_exam.dart';

class PostExam extends StatelessWidget{
  final Post post;

  const PostExam({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                post.classwork.title,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              width: double.infinity,
            ),
            Padding(
              child: PostStatus(
                post.classwork.description,
                trimMode: TrimMode.Line,
                trimLines: 2,
                textAlign: TextAlign.center,
                trimCollapsedText: "...More",
                trimExpandedText: " Show Less",
                colorClickableText: Color(0xFF294B76),
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  top: 5
              ),
            ),
            PostQuestion(
              postQuestionSize: PostQuestionSize.small,
              post: post,
            ),
            Padding(
              child: Text(
                "Duration: ${post.classwork.examDuration}",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10
              ),
            ),
            Padding(
              child: Text(
                "Deadline: ${post.classwork.endDate}",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              padding: EdgeInsets.only(
                  left: 10,
                  right: 10
              ),
            ),
//            Padding(
//              child: Text(
//                "Submitted: 19/20 people",
//                style: TextStyle(
//                    fontWeight: FontWeight.bold
//                ),
//              ),
//              padding: EdgeInsets.only(
//                  left: 10,
//                  right: 10,
//                  bottom: 10
//              ),
//            ),
            Padding(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        child: Material(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          child: Container(
                            child: Text(
                              "Take exam",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            padding: EdgeInsets.all(5),
                          ),
                        ),
                        margin: EdgeInsets.only(
                            right: 10
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>TakeExam(createClasswork: post.classwork,)
                        ));
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Material(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1
                            )
                        ),
                        child: Container(
                          child: Text(
                            "View questions",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor
                            ),
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                      margin: EdgeInsets.only(
                          left: 10
                      ),
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.only(
                  left: 10,
                  right: 10
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
        padding: EdgeInsets.only(
            top: 10,
            bottom: 10
        ),
      ),
      padding: EdgeInsets.only(
          left: 10,
          right: 10
      ),
    );
  }
}