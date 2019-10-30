
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/presentations/create_question.dart';

class CreateExam extends StatefulWidget{
  final CreateClasswork createClasswork;

  const CreateExam({Key key, this.createClasswork}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CreateExamState();
  }
}

class _CreateExamState extends State<CreateExam>{
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();
  CreateClasswork classwork = CreateClasswork(
    title: "",
    description: "",
    startDate: "",
    endDate: "",
    examDuration: 60,
    isAutoGrade: 1,
    showResultAt: "IMMEDIATE",
    questions: List()
  );

  @override
  void dispose() {
    startDate.dispose();
    endDate.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(widget.createClasswork != null){
      classwork = widget.createClasswork;
      startDate.text = classwork.startDate;
      endDate.text = classwork.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Exam",
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
                              hintText: "Input your quetion title"
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
              Row(
                children: <Widget>[
                  Text(
                    "Start Date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: TextFormField(
                          controller: startDate,
                          decoration: InputDecoration(
                              hintText: "Start Date"
                          ),
                          onTap: (){
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  startDate.text = "${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')} ${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}";
                                  classwork.startDate = startDate.text;
                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },
                        ),
                        margin: EdgeInsets.only(
                            left: 10
                        ),
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "End Date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: TextFormField(
                          controller: endDate,
                          decoration: InputDecoration(
                              hintText: "End Date"
                          ),
                          onTap: (){
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  endDate.text = "${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')} ${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}";
                                  classwork.endDate = endDate.text;
                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },
                        ),
                        margin: EdgeInsets.only(
                            left: 10
                        ),
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Exam Duration",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: TextFormField(
                          initialValue: classwork.examDuration.toString(),
                          decoration: InputDecoration(
                              hintText: "Duration"
                          ),
                          onChanged: (String val){
                            classwork.examDuration = int.parse(val);
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
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Questions:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    ListView.builder(
                      itemCount: classwork.questions.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,index){
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  child: Text(classwork.questions[index].title),
                                  onTap: () async {
                                    var question = await Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=>CreateQuestion(createClasswork: classwork.questions[index],)
                                    ));
                                    if(question != null){
                                      setState(() {
                                        classwork.questions[index] = question;
                                      });
                                    }
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                onPressed: (){
                                  setState(() {
                                    classwork.questions.removeAt(index);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        var question = await Navigator.of(context).pushNamed("/createquestion");
                        setState(() {
                          classwork.questions.add(question);
                        });
                      },
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                width: double.infinity,
              )
            ],
          ),
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}