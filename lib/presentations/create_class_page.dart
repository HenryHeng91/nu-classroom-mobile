import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_kickstart/api_client/class_api_client.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';

class CreateClassPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CreateClassPageState();
  }
}

class _CreateClassPageState extends State<CreateClassPage>{
  var descriptionController = TextEditingController();
  var titleController = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  var startTime = TextEditingController();
  var endTime = TextEditingController();
  var createClass = CreateClass();
  String categoryName = "";
  var dayMap = {
    "Monday":1,
    "Tuesday":2,
    "Wednesday":3,
    "Thursday":4,
    "Friday":5,
    "Saturday":6,
    "Sunday":7,
  };

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    startDate.dispose();
    endDate.dispose();
    startTime.dispose();
    endTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (context, _ViewModel viewModel){
        return Scaffold(
          appBar: _buildAppBar(viewModel),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  AppBar _buildAppBar(_ViewModel viewModel){
    return AppBar(
      title: new Text(
        "Create Class",
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
            createClass.classTitle = titleController.text;
            createClass.description = descriptionController.text;
            createClass.startDate = startDate.text;
            createClass.endDate = endDate.text;
            createClass.classStartTime = startTime.text;
            createClass.classEndTime = endTime.text;
            _createClass(context, viewModel.user, createClass);
          },
        )
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildBody(_ViewModel viewModel){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: Card(
                        elevation: 4,
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          viewModel.user.profilePicture,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${viewModel.user.firstName} ${viewModel.user.lastName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                              margin: EdgeInsets.only(
                                  bottom: 10
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(createClass.categoryId != null ? categoryName : "Choose Category"),
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
                                  ),
                                  onTap: () async {
                                    dynamic postto = await Navigator.of(context).pushNamed("/category");
                                    if(postto != null){
                                      categoryName = postto["name"];
                                      createClass.categoryId = postto["id"];
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(
                            left: 10
                        ),
                      ),
                    )
                  ],
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Add your class title"
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: "Write your description..."
                  ),
                  maxLines: 10,
                ),
                TextFormField(
                  controller: startDate,
                  decoration: InputDecoration(
                    labelText: "Start Date",
                  ),
                  onTap: (){
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1930, 1, 1),
                        maxTime: DateTime(2020, 1, 1), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          startDate.text = "${date.year}-${date.month}-${date.day}";
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
                TextFormField(
                  controller: endDate,
                  decoration: InputDecoration(
                    labelText: "End Date",
                  ),
                  onTap: (){
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1930, 1, 1),
                        maxTime: DateTime(2020, 1, 1), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          endDate.text = "${date.year}-${date.month}-${date.day}";
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
                TextFormField(
                  controller: startTime,
                  decoration: InputDecoration(
                    labelText: "Class Start Time",
                  ),
                  onTap: (){
                    DatePicker.showTimePicker(context,
                        showTitleActions: true,
                        onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          startTime.text = "${date.hour}:${date.minute}:${date.second}";
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
                TextFormField(
                  controller: endTime,
                  decoration: InputDecoration(
                    labelText: "Class End Time",
                  ),
                  onTap: (){
                    DatePicker.showTimePicker(context,
                        showTitleActions: true,
                        onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          endTime.text = "${date.hour}:${date.minute}:${date.second}";
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Class Days"
                  ),
                  margin: EdgeInsets.only(
                    top: 10
                  ),
                ),
                CheckboxGroup(
                    labels: <String>[
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                      "Saturday",
                      "Sunday",
                    ],
                    onSelected: (List<String> checked){
                      var classDays ="";
                      checked.forEach((day){
                        classDays+="${dayMap[day]},";
                      });
                      if(classDays != ""){
                        classDays = classDays.substring(0,classDays.lastIndexOf(","));
                      }
                      print("class day $classDays");
                      createClass.classDays = classDays;
                    }
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _createClass(BuildContext context, User user, CreateClass createClass)async{
    var pr = ProgressDialog(
        context,
        type: ProgressDialogType.Download,
        isDismissible: false,
        showLogs: false
    );
    pr.style(
        progressWidget: Padding(
          child: CircularProgressIndicator(),
          padding: EdgeInsets.all(10),
        ),
        message: "Creating ..."
    );
    pr.show();
    bool success = await ClassAPIClient.createClass(context, user, createClass);
    pr.dismiss();
    if(success){
      Navigator.of(context).pop();
    }
  }
}

class _ViewModel {
  final User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.user);
  }
}