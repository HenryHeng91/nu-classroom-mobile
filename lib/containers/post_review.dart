import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/containers/bottom_sheet_comment.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class PostReview extends StatefulWidget{
  final Post post;

  const PostReview({Key key, this.post}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostReviewState();
  }

}

class _PostReviewState extends State<PostReview>{
  Post post;
  var loading = StreamController<bool>();
  @override
  void dispose() {
    // TODO: implement dispose
    loading.close();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    this.post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      distinct: true,
      rebuildOnChange: false,
      builder: (context, _ViewModel viewModel){
        return Padding(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: StreamBuilder(
                        stream: loading.stream,
                        builder: (context,snapshot){
                          if(snapshot.data != null){
                            if(snapshot.data){
                              return CircularProgressIndicator();
                            }
                          }
                          return ImageIcon(
                            AssetImage("assets/icons/like.png"),
                            color: post.isAlreadyLike?Colors.blue:Colors.black,
                          );
                        },
                      ),
                      onPressed: (){
                        _like(context, viewModel.user, post);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: Colors.black,
                      ),
                      onPressed: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context){
                            return BottomSheetComment(postId: post.id,);
                          }
                        );
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        "${post.likeCount} likes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10
                      ),
                    ),
                    Icon(
                      Icons.brightness_1,
                      size: 5,
                    ),
                    Padding(
                      child: Text(
                        "${post.commentCount} comments",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10
                      ),
                    )
                  ],
                )
              ],
            ),
            height: 70,
          ),
          padding: EdgeInsets.all(10),
        );
      },
    );
  }

  Future<void> _like(BuildContext context, User user, Post post)async{
    loading.add(true);
    String url = ConfigWrapper.of(context).baseUrl;
    var response = await http.get(
        "$url/api/v1/posts/${post.id}/like",
        headers: {
          "access-token": user.accessToken
        }
    );
    loading.add(false);
    print(response.body);
    if(response.statusCode == 200) {
      setState(() {
        this.post.likeCount++;
        this.post.isAlreadyLike = true;
      });
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