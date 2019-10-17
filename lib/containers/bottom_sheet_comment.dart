import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_kickstart/api_client/post_api_client.dart';
import 'package:flutter_kickstart/containers/comment_item.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class BottomSheetComment extends StatefulWidget{
  final String postId;
  const BottomSheetComment({Key key, this.postId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BottomSheetCommentState();
  }

}

class _BottomSheetCommentState extends State<BottomSheetComment>{
  var commentStream = StreamController<List<Comment>>();
  var commentDetailController = TextEditingController();
  var loading = StreamController<bool>();

  @override
  void dispose() {
    // TODO: implement dispose
    commentStream.close();
    loading.close();
    commentDetailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      onInit: (store){
        loadComment(context, store.state.user, widget.postId);
      },
      builder: (context,viewModel){
        return FractionallySizedBox(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    'Comments',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  margin: EdgeInsets.only(
                      bottom: 10
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: commentStream.stream,
                    builder: (context, AsyncSnapshot<List<Comment>> snapshot){
                      if(snapshot.hasData && !snapshot.hasError && snapshot.data!=null){
                        List<Comment> comments = snapshot.data;
                        return ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context,index){
                            return CommentItem(comment: comments[index],);
                          },
                        );
                      }
                      return Column(
                        children: <Widget>[
                          CircularProgressIndicator()
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Add your comment"
                        ),
                        controller: commentDetailController,
                      ),
                    ),
                    IconButton(
                      icon: StreamBuilder(
                        stream: loading.stream,
                        builder: (context,snapshot){
                            if(snapshot.hasData && !snapshot.hasError && snapshot.data!=null){
                              if(snapshot.data){
                                return CircularProgressIndicator();
                              }
                            }
                            return Icon(Icons.send);
                        },
                      ),
                      onPressed: () async {
                        loading.add(true);
                        bool successs = await PostAPIClient.createComment(context, viewModel.user, widget.postId, commentDetailController.text);
                        loading.add(false);
                        if(successs){
                          commentDetailController.text = "";
                          loadComment(context, viewModel.user, widget.postId);
                        }
                      },
                    )
                  ],
                )
              ],
            ),
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
            ),
          ),
          heightFactor: 0.85,
          alignment: Alignment.bottomCenter,
        );
      },
    );
  }

  Future<void> loadComment(BuildContext context, User user, String postId)async{
    List<Comment> comments = await PostAPIClient.loadComment(context, user, postId);
    commentStream.add(comments);
  }
}

class _ViewModel {
  final User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.user);
  }
}