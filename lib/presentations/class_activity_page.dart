import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/api_client/post_api_client.dart';
import 'package:flutter_kickstart/containers/post.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import '../config_wrapper.dart';

class ClassActivityPage extends StatefulWidget{
  final String classId;

  const ClassActivityPage({Key key, this.classId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ClassActivityPageState();
  }
}

class _ClassActivityPageState extends State<ClassActivityPage>{
  int page = 1;
  var postStream = StreamController<List<Post>>();
  List<Post> posts = List();
  bool canload = true;

  @override
  void dispose() {
    postStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      distinct: true,
      onInit: (store){
        _loadFeed(context, store.state.user, page);
      },
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
        "Feeds",
        style: TextStyle(
            fontSize: 24
        ),
      ),
      leading: Icon(Icons.sort),
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
                        image: NetworkImage(viewModel.user.profilePicture)
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.black,
                        width: 1
                    )
                ),
              ),
            ),
          ),
          onTap: (){
            Navigator.of(context).pushNamed("/me");
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
        InkWell(
          child: Container(
            child: Container(
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(viewModel.user.profilePicture ?? "")
                          ),
                          shape: BoxShape.circle
                      )
                  ),
                  Container(
                    child: Text(
                        "Talk to your classmates..."
                    ),
                    margin: EdgeInsets.only(
                        left: 10
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                      color: Colors.black,
                      width: 1
                  )
              ),
            ),
            padding: EdgeInsets.all(10),
            color: Colors.white,
          ),
          onTap: (){
            Navigator.of(context).pushNamed("/createpost");
          },
        ),
        Expanded(
          child: StreamBuilder(
            stream: postStream.stream,
            builder: (context, AsyncSnapshot<List<Post>> snapshot){
              if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                print("get feed count ${snapshot.data.length}");
                List<Post> posts = snapshot.data;
                return NotificationListener<ScrollNotification>(
                  child: RefreshIndicator(
                    child: ListView.builder(
                      itemCount: posts.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return PostWidget(
                          post: posts[index],
                        );
                      },
                    ),
                    onRefresh: (){
                      return _loadFeed(context, viewModel.user, page = 1);
                    },
                  ),
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      if(canload){
                        _loadFeed(context, viewModel.user, ++page);
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

  Future<void> _loadFeed(BuildContext context, User user, int page)async{
    canload =false;
    List<Post> posts = await PostAPIClient.loadFeedClass(context, user,widget.classId, page);
    canload = true;
    if(posts!=null) {
      if(page == 1){
        //reload
        this.posts.clear();
      }
      this.posts.addAll(posts);
      this.postStream.add(this.posts);
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