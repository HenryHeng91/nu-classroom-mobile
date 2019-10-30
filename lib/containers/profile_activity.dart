import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/containers/post.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class ProfileActivity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileActivityState();
  }
}

class _ProfileActivityState extends State<ProfileActivity>{
  var postStream = StreamController<List<Post>>();
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      onInit: (store){
        _loadFeed(context, store.state.user, 1);
      },
      builder: (context,_ViewModel _viewModel){
        return StreamBuilder(
          stream: postStream.stream,
          builder: (context,AsyncSnapshot<List<Post>> snapshot){
            if(snapshot.hasData && !snapshot.hasError && snapshot.data!=null){
              var posts = snapshot.data;
              return ListView.builder(
                itemCount: posts.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index){
                  return PostWidget(
                    post: posts[index],
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        );
      },
    );
  }

  Future<void> _loadFeed(BuildContext context, User user, int page)async{
    String url = ConfigWrapper.of(context).baseUrl;
    print("$url/api/v1/posts?page=$page");
    var response = await http.get(
        "$url/api/v1/posts?page=$page",
        headers: {
          "access-token": user.accessToken
        }
    );
    debugPrint("response ${response.body}");
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body)['data'] as List;
      List<Post> posts = json.map((post){
        return Post.fromJson(post);
      }).toList();
      this.postStream.add(posts);
      print("post page $page");
    }
    this.postStream.add(List());
  }
}


class _ViewModel {
  final Store<AppState> store;

  _ViewModel(this.store);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store);
  }
}