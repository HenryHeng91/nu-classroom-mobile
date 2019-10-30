import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/api_client/class_api_client.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class PostToClassPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PostToClassPageState();
  }
}

class _PostToClassPageState extends State<PostToClassPage>{
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      rebuildOnChange: false,
      builder: (context, _ViewModel viewModel){
        return Scaffold(
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                            "Recent:"
                        ),
                        padding: EdgeInsets.only(
                          bottom: 15,
                        ),
                      ),
                      FutureBuilder(
                        future: _loadClass(context, viewModel.user, filter.all, 1),
                        builder: (context, AsyncSnapshot<List<Class>> snapshot){
                          if(snapshot.hasData && !snapshot.hasError && snapshot.data !=null){
                            var classes = snapshot.data;
                            return ListView.separated(
                              itemCount: classes.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return InkWell(
                                  child: Container(
                                    child: Text(
                                      classes[index].classTitle,
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                      bottom: 15,
                                      top: 15
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.of(context).pop(classes[index]);
                                  },
                                );
                              },
                              separatorBuilder: (context,index){
                                return Divider(height: 1);
                              },
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Created:",
                          ),
                          padding: EdgeInsets.only(
                            bottom: 15
                          ),
                        ),
                        FutureBuilder(
                          future: _loadClass(context, viewModel.user, filter.created, 1),
                          builder: (context, AsyncSnapshot<List<Class>> snapshot){
                            if(snapshot.hasData && !snapshot.hasError && snapshot.data !=null){
                              var classes = snapshot.data;
                              return ListView.builder(
                                itemCount: classes.length,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                  return InkWell(
                                    child: Container(
                                      child: Text(
                                        classes[index].classTitle,
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          bottom: 15,
                                          top: 15
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.of(context).pop(classes[index]);
                                    },
                                  );
                                },
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      title: new Text(
        "Post to Class",
        style: TextStyle(
            fontSize: 24
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Future<List<Class>> _loadClass(BuildContext context, User user, filter classFilter,int page)async{
    List<Class> classes = await ClassAPIClient.loadClass(context, user, classFilter, page);
    if(classes != null) {
      return classes;
    }
    return List();
  }
}

class _ViewModel {
  final User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.user);
  }
}