import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

enum filter {
  all,
  created,
  joined
}

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
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text("Recent"),
                      FutureBuilder(
                        future: _loadClass(context, viewModel.user, filter.all, 1),
                        builder: (context, AsyncSnapshot<List<Class>> snapshot){
                          if(snapshot.hasData && !snapshot.hasError && snapshot.data !=null){
                            var classes = snapshot.data;
                            return ListView.builder(
                              itemCount: classes.length,
                              itemBuilder: (context,index){
                                return ListTile(
                                  title: Text(classes[index].classTitle),
                                  onTap: (){
                                    Navigator.of(context).pop(classes[index].id);
                                  },
                                );
                              },
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  )
                ),
                Container(
                    child: Column(
                      children: <Widget>[
                        Text("Created"),
                        FutureBuilder(
                          future: _loadClass(context, viewModel.user, filter.created, 1),
                          builder: (context, AsyncSnapshot<List<Class>> snapshot){
                            if(snapshot.hasData && !snapshot.hasError && snapshot.data !=null){
                              var classes = snapshot.data;
                              return ListView.builder(
                                itemCount: classes.length,
                                itemBuilder: (context,index){
                                  return ListTile(
                                    title: Text(classes[index].classTitle),
                                    onTap: (){
                                      Navigator.of(context).pop([classes[index].id]);
                                    },
                                  );
                                },
                              );
                            }
                            return SizedBox.shrink();
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
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/classes";
    if(classFilter == filter.created){
      url = "$url/created";
    }else if(classFilter == filter.joined){
      url = "$url/joined";
    }

    var response = await http.get(
        url,
        headers: {
          "access-token": user.accessToken
        }
    );
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body)['data'] as List;
      List<Class> classes = json.map((classJson){
        return Class.fromJson(classJson);
      }).toList();
      return classes;
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