import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_kickstart/api_client/class_api_client.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/containers/bottom_sheet_create_class.dart';
import 'package:flutter_kickstart/containers/class_item.dart';
import 'package:flutter_kickstart/custom_widgets/selected_class_filter.dart';
import 'package:flutter_kickstart/custom_widgets/un_selected_class_filter.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/presentations/class_activity_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

enum action{
  join,
  leave
}

class ClassPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClassPageState();
  }
}

class _ClassPageState extends State<ClassPage>{
  int page = 1;
  var classStream = StreamController<List<Class>>();
  List<Class> classes = List();
  bool canload = true;
  filter classFilter = filter.all;
  var filterStream = StreamController<filter>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    classStream.close();
    filterStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      distinct: true,
      onInit: (store){
        _loadClass(context, store.state.user, classFilter, page);
      },
      builder: (context, _ViewModel viewModel){
        return Scaffold(
          appBar: _buildAppBar(viewModel),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  AppBar _buildAppBar(_ViewModel _viewModel){
    return AppBar(
      title: new Text(
        "Classes",
        style: TextStyle(
            fontSize: 24
        ),
      ),
      leading: Icon(Icons.sort),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (context){
                return BottomSheetCreateClass(
                  onChooseCreate: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/createclass");
                  },
                  onChooseJoin: () async {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context){
                        String classId="";
                        return AlertDialog(
                          title: Text("Join Class"),
                          content: TextField(
                            decoration: InputDecoration(
                              hintText: "Input Class ID"
                            ),
                            onChanged: (val){
                              classId = val;
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Join"),
                              onPressed: () async {
                                await _joinClass(context, _viewModel.user, classId, action.join);
                              },
                            )
                          ],
                        ) ;
                      }
                    );
                  },
                );
              }
            );
          },
        )
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildBody(_ViewModel viewModel){
    return Column(
      children: <Widget>[
        Padding(
          child: StreamBuilder(
            stream: filterStream.stream,
            builder: (context,snapshot){
              return Row(
                children: <Widget>[
                  Container(
                    child: InkWell(
                      child: classFilter == filter.all ? SelectedClassFilter(title:"All") : UnSelectedClassFilter(title:"All"),
                      onTap: (){
                        if(canload){
                          classFilter = filter.all;
                          filterStream.add(filter.all);
                          refreshKey.currentState.show();
                        }
                      },
                    ),
                    margin: EdgeInsets.only(
                      right: 10
                    ),
                  ),
                  Container(
                    child: InkWell(
                      child: classFilter == filter.created ? SelectedClassFilter(title:"Created") : UnSelectedClassFilter(title:"Created"),
                      onTap: (){
                        if(canload){
                          classFilter = filter.created;
                          filterStream.add(filter.created);
                          refreshKey.currentState.show();
                        }
                      },
                    ),
                    margin: EdgeInsets.only(
                      right: 10
                    ),
                  ),
                  InkWell(
                    child: classFilter == filter.joined ? SelectedClassFilter(title:"Joined") : UnSelectedClassFilter(title:"Joined"),
                    onTap: (){
                      if(canload){
                        classFilter = filter.joined;
                        filterStream.add(filter.joined);
                        refreshKey.currentState.show();
                      }
                    },
                  ),
                ],
              );
            },
          ),
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: classStream.stream,
            builder: (context, AsyncSnapshot<List<Class>> snapshot){
              if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                print("get feed count ${snapshot.data.length}");
                List<Class> classes = snapshot.data;
                return NotificationListener<ScrollNotification>(
                  child: RefreshIndicator(
                    key: refreshKey,
                    child: ListView.builder(
                      itemCount: classes.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return InkWell(
                          child: ClassItem(
                            classItem: classes[index],
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>ClassActivityPage(myClass: classes[index],)
                              )
                            );
                          },
                        );
                      },
                    ),
                    onRefresh: (){
                      return _loadClass(context, viewModel.user, classFilter,page = 1);
                    },
                  ),
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      if(canload){
                        _loadClass(context, viewModel.user, classFilter,++page);
                      }
                    }
                    return true;
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
  }

  Future<void> _joinClass(BuildContext context, User user, String classId, action action)async{
    var pr = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false
    );
    pr.style(
        progressWidget: Padding(
          child: CircularProgressIndicator(),
          padding: EdgeInsets.all(10),
        ),
        message: "Joining class ..."
    );
    pr.show();
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/classes/${classId}/join";
    var response = await http.get(
        url,
        headers: {
          "access-token": user.accessToken
        }
    );
    pr.dismiss();
    if(response.statusCode == 200){
      Alert(
        context: context,
        type: AlertType.success,
        title: "SUCCESS",
        desc: "You have join class successfully!.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "SORRY",
        desc: "Something went wrong! Please try again later!.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  Future<void> _loadClass(BuildContext context, User user, filter classFilter,int page)async{
    canload =false;

    List<Class> classes = await ClassAPIClient.loadClass(context, user, classFilter, page);
    canload = true;
    if(classes != null) {
      if(page == 1){
        //reload
        this.classes.clear();
      }
      this.classes.addAll(classes);
      this.classStream.add(this.classes);
      print("post page $page");
    }
  }
}

class _ViewModel{
  User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store.state.user
    );
  }
}