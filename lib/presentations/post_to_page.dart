import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/api_client/class_api_client.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/containers/action_item.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class PostToPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PostToPageState();
  }
}

class _PostToPageState extends State<PostToPage>{
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      rebuildOnChange: false,
      builder: (context, _ViewModel viewModel){
        return Scaffold(
          appBar: _buildAppBar(),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                ActionItem(
                  icon: ImageIcon(
                      AssetImage("assets/icons/feed.png")
                  ),
                  title: "Your feed",
                  onTap: (){
                    Navigator.of(context).pop("feed");
                  },
                ),
                Divider(),
                ActionItem(
                  icon: ImageIcon(
                      AssetImage("assets/icons/class.png")
                  ),
                  title: "Your classes",
                  onTap: (){
                    Navigator.of(context).pop("class");
                  },
                ),
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