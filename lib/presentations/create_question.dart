
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/models.dart';

class CreateQuestion extends StatefulWidget{
  final CreateClasswork createClasswork;

  const CreateQuestion({Key key, this.createClasswork}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreateQuestionState();
  }
}

class _CreateQuestionState extends State<CreateQuestion>{
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
            correctAnswerIndex: classwork.answer.correctAnswerIndex,
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
          "Ask Question",
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
            onTap: (){
              if(classwork.questionType == "TRUE_FALSE"){
                classwork.answer.items = null;
              }
              Navigator.of(context).pop(classwork);
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
              Row(
                children: <Widget>[
                  Text(
                    "Question Type",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  PopupMenuButton(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(classwork.questionType),
                          ),
                          ImageIcon(
                              AssetImage("assets/icons/dropdown.png")
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      padding: EdgeInsets.only(
                          left: 5
                      ),
                      margin: EdgeInsets.only(
                          left: 10
                      ),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        child: Text("WRITE"),
                        value: "WRITE",
                      ),
                      PopupMenuItem<String>(
                        child: Text("TRUE/FALSE"),
                        value: "TRUE_FALSE",
                      ),
                      PopupMenuItem<String>(
                        child: Text("MULTI CHOICE"),
                        value: "MULTI_CHOICE",
                      )
                    ],
                    onSelected: (val){
                      setState(() {
                        classwork.questionType=val;
                        if(val == "TRUE_FALSE"){
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
                        }else if(val == "MULTI_CHOICE"){
                          classwork.answer = null;
                        }
                      });
                    },
                  )
                ],
              ),
              Row(
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
                        child: TextFormField(
                          initialValue: classwork.title,
                          decoration: InputDecoration(
                              hintText: "Input your quetion title",
                          ),
                          onChanged: (val){
                            classwork.title = val;
                          },
                        ),
                        margin: EdgeInsets.only(
                            left: 10
                        ),
                      )
                  )
                ],
              ),
              TextFormField(
                initialValue: classwork.description,
                decoration: InputDecoration(
                    hintText: "Input your question description"
                ),
                onChanged: (val){
                  classwork.description = val;
                },
                maxLines: 3,
              ),
              Builder(
                builder: (context){
                  if(classwork.questionType != "WRITE"){
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
                            itemCount: classwork.answer != null ? classwork.answer.items.length : 0,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context,index){
                              return RadioListTile(
                                groupValue: classwork.answer.correctAnswerIndex,
                                value: index,
                                title: Text(classwork.answer.items[index].answerDetail),
                                onChanged: (val){
                                  setState(() {
                                    classwork.answer.correctAnswerIndex = index;
                                  });
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (context){
                                  String answer = "";
                                  return AlertDialog(
                                    title: Text("Add Answer"),
                                    content: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Input your answer"
                                      ),
                                      onChanged: (val){
                                        answer = val;
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Add"),
                                        onPressed: (){
                                          setState(() {
                                            print("answer $answer");
                                            if(classwork.answer == null){
                                              classwork.answer = CreateAnswer(
                                                  correctAnswerIndex: 0,
                                                  items: List()
                                              );
                                            }
                                            classwork.answer.items.add(CreateAnswerItem(
                                                answerDetail: answer
                                            ));
                                            print("answer length ${classwork.answer.items.length}");
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                }
                              );
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