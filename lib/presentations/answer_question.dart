
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/api_client/exam_api_client.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AnswerQuestion extends StatefulWidget{
  final CreateClasswork createClasswork;

  const AnswerQuestion({Key key, this.createClasswork}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnswerQuestionState();
  }
}

class _AnswerQuestionState extends State<AnswerQuestion>{
  CreateClasswork classwork = CreateClasswork(
    title: "",
    description: "",
    questionType: "WRITE"
  );

  @override
  void initState() {
    super.initState();
    if(widget.createClasswork != null){
      classwork = widget.createClasswork;
      if(classwork.questionType == "TRUE_FALSE"){
        classwork.answer = CreateAnswer(
            correctAnswerIndex: 0,
            items: [
              CreateAnswerItem(
                  answerDetail: "True"
              ),
              CreateAnswerItem(
                  answerDetail: "False"
              )
            ]
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Answer Question",
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
              bool success = await ExamAPIClient.submitAnswer(context, StoreProvider.of<AppState>(context).state.user, classwork);
              if(success){
                Navigator.of(context).pop();
              }
            },
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
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
                      child: Text(classwork.questionType),
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
                              classwork.title
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
                  classwork.description,
                ),
                width: double.infinity,
                margin: EdgeInsets.only(
                  bottom: 20
                ),
              ),
              Builder(
                builder: (context){
                  if(classwork.questionType != "WRITE"){
                    if(classwork.answer == null){
                      classwork.answer = CreateAnswer(
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
                            itemCount: classwork.answers != null ? classwork.answers.length : 0,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context,index){
                              return RadioListTile(
                                groupValue: classwork.answer.correctAnswerIndex,
                                value: index,
                                title: Text(classwork.answers[index].answerDetail),
                                onChanged: (val){
                                  setState(() {
                                    classwork.answer.correctAnswerIndex = index;
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
                    if(classwork.answer == null){
                      classwork.answer = CreateAnswer(
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
                              classwork.answer.answerDetail = val;
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
        padding: EdgeInsets.all(10),
      ),
    );
  }
}