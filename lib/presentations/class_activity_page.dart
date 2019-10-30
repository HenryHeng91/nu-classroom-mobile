import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/api_client/post_api_client.dart';
import 'package:flutter_kickstart/containers/post.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/presentations/create_post_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../config_wrapper.dart';

enum action{
  join,
  leave,
  share
}

class ClassActivityPage extends StatefulWidget{
  final Class myClass;

  const ClassActivityPage({Key key, this.myClass}) : super(key: key);
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
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Material(
              color: hexToColor(widget.myClass.color),
              child: Container(
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 20
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.myClass.classTitle,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                            ),
                          ),
                          Text(
                            widget.myClass.organization!=null ? widget.myClass.organization.name : "",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Text(
                            "${widget.myClass.membersCount} students",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            widget.myClass.instructor != null ? "${widget.myClass.instructor.first_name} ${widget.myClass.instructor.last_name}" : "",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/classes/leadership.png"),
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: ImageIcon(
                              AssetImage("assets/icons/notification.png"),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            child: PopupMenuButton(
                              child: ImageIcon(
                                AssetImage("assets/icons/more.png"),
                                color: Colors.white,
                              ),
                              itemBuilder: (context) => [
//                              PopupMenuItem<action>(
//                                child: Text("Join Class"),
//                                value: action.join,
//                              ),
                                PopupMenuItem<action>(
                                  child: Text("Leave Class"),
                                  value: action.leave,
                                ),
                                PopupMenuItem<action>(
                                  child: Text("Share Class"),
                                  value: action.share,
                                )
                              ],
                              onSelected: (val) async {
                                if(val == action.join){
                                  _joinClass(context, viewModel.user, widget.myClass, val);
                                }else if(val == action.leave){
                                  _leaveClass(context, viewModel.user, widget.myClass, val);
                                }else if(val == action.share){
                                  var response = await FlutterShareMe().shareToSystem(msg: widget.myClass.url);
                                  if (response == 'success') {
                                    print('navigate success');
                                  }
                                }
                              },
                            ),
                            padding: EdgeInsets.all(10),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                height: 150,
              ),
            ),
          ),
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>CreatePostPage(myClass: widget.myClass,)
              ));
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
      ),
      color: Colors.white,
    );
  }

  Future<void> _loadFeed(BuildContext context, User user, int page)async{
    canload =false;
    List<Post> posts = await PostAPIClient.loadFeedClass(context, user,widget.myClass.id, page);
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

  Future<void> _joinClass(BuildContext context, User user, Class classItem, action action)async{
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
    url = "$url/api/v1/classes/${classItem.id}/join";
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
            onPressed: () => Navigator.pop(context),
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
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
  Future<void> _leaveClass(BuildContext context, User user, Class classItem, action action)async{
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
        message: "Leaving class ..."
    );
    pr.show();
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/classes/${classItem.id}/left";
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
        desc: "You have left class successfully!.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
            onPressed: () => Navigator.pop(context),
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
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  Color hexToColor(String code) {
    if(!code.contains("#")){
      return new Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
    }
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
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