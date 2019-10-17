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

class VisibilityPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _VisibilityPageState();
  }
}

class _VisibilityPageState extends State<VisibilityPage>{
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
                      AssetImage("assets/icons/public.png")
                  ),
                  title: "Public",
                  onTap: (){
                    Navigator.of(context).pop("PUBLIC");
                  },
                ),
                Divider(),
                ActionItem(
                  icon: ImageIcon(
                      AssetImage("assets/icons/group.png")
                  ),
                  title: "Classmate",
                  onTap: (){
                    Navigator.of(context).pop("TEAM");
                  },
                ),
                Divider(),
                ActionItem(
                  icon: ImageIcon(
                      AssetImage("assets/icons/user.png")
                  ),
                  title: "Only me",
                  onTap: (){
                    Navigator.of(context).pop("PRIVATE");
                  },
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
        "Visibility",
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
    return await ClassAPIClient.loadClass(context, user, classFilter, page);
  }
}

class _ViewModel {
  final User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.user);
  }
}