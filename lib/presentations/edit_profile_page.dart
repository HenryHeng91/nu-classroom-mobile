import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/api_client/user_api_client.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/utils/kh_number_formatter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

class EditProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage>{
  var loading = BehaviorSubject<bool>();
  final _formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final Gender = TextEditingController();
  final DateofBirth = TextEditingController();
  final Education = TextEditingController();
  final About = TextEditingController();

  @override
  void dispose() {
    loading.close();
    firstName.dispose();
    lastName.dispose();
    Gender.dispose();
    DateofBirth.dispose();
    Education.dispose();
    About.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      onInitialBuild: (_ViewModel viewModel){
        firstName.text = viewModel.user.firstName;
        lastName.text = viewModel.user.lastName;
        Gender.text = viewModel.user.gender;
        DateofBirth.text = viewModel.user.birthDate;
        Education.text = viewModel.user.educationLevel;
        About.text = viewModel.user.selfDescription;
      },
      converter: _ViewModel.fromStore,
      onDidChange: (_ViewModel viewModel){
        print(viewModel.user.firstName);
      },
      builder: (context, _ViewModel viewModle){
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 55,
                            color: Colors.white,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: 60,
                      )
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: firstName,
                          decoration: InputDecoration(
                            labelText: "First Name",
                            labelStyle: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: lastName,
                          decoration: InputDecoration(
                            labelText: "Last Name",
                            labelStyle: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: Gender,
                            decoration: InputDecoration(
                              labelText: "Gender",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width/2-20,
                  ),
                  TextFormField(
                    controller: DateofBirth,
                    style: TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onTap: (){
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1930, 1, 1),
                          maxTime: DateTime(2020, 1, 1), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            DateofBirth.text = "${date.year}-${date.month}-${date.day}";
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                  ),
                  TextFormField(
                    controller: Education,
                    style: TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: "Education",
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "About you",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 5
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: About,
                      maxLines: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10
                    ),
                    margin: EdgeInsets.only(
                      bottom: 20
                    ),
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(
                            color: Colors.white,
                            width: 1
                        )
                    ),
                    color: Colors.transparent,
                    child: StreamBuilder(
                      stream: loading.stream,
                      builder: (context, AsyncSnapshot<bool> snapshot){
                        if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                          if(snapshot.data){
                            return Center(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    CircularProgressIndicator()
                                  ],
                                ),
                                padding: EdgeInsets.all(10),
                                width: 200,
                              ),
                            );
                          }
                        }
                        return InkWell(
                          child: Center(
                            child: Container(
                              child: Text(
                                "UPDATE",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                              ),
                              padding: EdgeInsets.all(10),
                              width: 200,
                            ),
                          ),
                          onTap: (){
                            update(
                              context,
                              viewModle,
                                {
                                  "username": null,
                                  "firstName": firstName.text,
                                  "lastName": lastName.text,
                                  "gender": Gender.text,
                                  "birthDate": DateofBirth.text,
                                  "email": null,
                                  "address": null,
                                  "city": null,
                                  "selfDescription": About.text,
                                  "educationLevel": Education.text
                                }
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> update(BuildContext context,_ViewModel _viewModel,Map<dynamic,dynamic> user) async{
    loading.add(true);
    var updateUser = await UserAPIClient.update(context, user, _viewModel.user.accessToken);
    loading.add(false);
    if(updateUser != null) {
      _viewModel.setGlobalUser(updateUser);
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }
}

class _ViewModel{
  User user;
  Function setGlobalUser;

  _ViewModel(this.user,this.setGlobalUser);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store.state.user,
      (User user){
        store.dispatch(SetGlobalUser(user));
      }
    );
  }
}