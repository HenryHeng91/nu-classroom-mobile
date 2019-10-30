
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/api_client/exam_api_client.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TakeExam extends StatefulWidget{
  final CreateClasswork createClasswork;

  const TakeExam({Key key, this.createClasswork}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TakeExamState();
  }
}

class _TakeExamState extends State<TakeExam>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Take Exam",
          style: TextStyle(
            fontSize: 24
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              width: 54,
              child: Center(
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/submit.png")
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            onTap: () async {
            },
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            CreateClasswork question = widget.createClasswork.questions[index];
            return Card(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Question Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            Container(
                              child: Text(question.questionType),
                              margin: EdgeInsets.only(
                                  left: 10
                              ),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(
                            bottom: 10
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Question Title",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  child: Text(
                                      question.title
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 10
                                  ),
                                )
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(
                            bottom: 10
                        ),
                      ),
                      Container(
                        child: Text(
                          question.description,
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            bottom: 20
                        ),
                      ),
                      Builder(
                        builder: (context){
                          if(question.questionType != "WRITE"){
                            if(question.answer == null){
                              question.answer = CreateAnswer(
                                  correctAnswerIndex: 0
                              );
                            }
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Answer:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                  ListView.builder(
                                    itemCount: question.answers != null ? question.answers.length : 0,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return RadioListTile(
                                        groupValue: question.answer.correctAnswerIndex,
                                        value: index,
                                        title: Text(question.answers[index].answerDetail),
                                        onChanged: (val){
                                          setState(() {
                                            question.answer.correctAnswerIndex = index;
                                          });
                                        },
                                      );
                                    },
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              width: double.infinity,
                            );
                          }else{
                            if(question.answer == null){
                              question.answer = CreateAnswer(
                                  answerDetail: ""
                              );
                            }
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Answer:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Input your answer"
                                    ),
                                    maxLines: 10,
                                    onChanged: (val){
                                      question.answer.answerDetail = val;
                                    },
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              width: double.infinity,
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
            );
          },
          loop: false,
          itemCount: widget.createClasswork.questions.length,
          viewportFraction: 0.9,
          scale: 0.9,
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}