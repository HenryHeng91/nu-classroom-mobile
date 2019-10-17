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

class CategoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage>{
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
                            "Category:"
                        ),
                        padding: EdgeInsets.only(
                          bottom: 15,
                        ),
                      ),
                      FutureBuilder(
                        future: _loadCategory(context, viewModel.user, filter.all, 1),
                        builder: (context, AsyncSnapshot<List<Category>> snapshot){
                          if(snapshot.hasData && !snapshot.hasError && snapshot.data !=null){
                            var categories = snapshot.data;
                            return ListView.separated(
                              itemCount: categories.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return InkWell(
                                  child: Container(
                                    child: Text(
                                      categories[index].name,
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
                                    Navigator.of(context).pop({
                                      "name":categories[index].name,
                                      "id":categories[index].guid
                                    });
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
        "Choose Category",
        style: TextStyle(
            fontSize: 24
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Future<List<Category>> _loadCategory(BuildContext context, User user, filter classFilter,int page)async{
    List<Category> categories = await ClassAPIClient.loadCategory(context, user);
    if(categories != null) {
      return categories;
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