import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:http/http.dart' as http;

class PostAPIClient{
  static Future<bool> submitPost(BuildContext context, CreatePost post, User user) async {
    var url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/posts";
    try{
      var temp = post.toJson();

      var response = await http.post(
          url,
          headers: {
            "Content-Type":"application/json",
            "access-token": user.accessToken
          },
          body: jsonEncode(temp)
      );
      print("code ${response.statusCode}");
      debugPrint(response.body);
      if(response.statusCode == 201){
        return true;
      }
      return false;
    }catch(error){
      print("error $error");
      return false;
    }
  }

  static Future<List<Post>> loadFeed(BuildContext context, User user, int page)async{
    String url = ConfigWrapper.of(context).baseUrl;
    var response = await http.get(
        "$url/api/v1/posts?page=$page",
        headers: {
          "access-token": user.accessToken
        }
    );
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body)['data'] as List;
      return json.map((post){
        print("post $post");
        return Post.fromJson(post);
      }).toList();
    }
    return List();
  }

  static Future<List<Post>> loadFeedClass(BuildContext context, User user, String classId, int page)async{
    String url = ConfigWrapper.of(context).baseUrl;
    var response = await http.get(
        "$url/api/v1/posts/class/$classId?page=$page",
        headers: {
          "access-token": user.accessToken
        }
    );
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body)['data'] as List;
      return json.map((post){
        return Post.fromJson(post);
      }).toList();
    }
    return List();
  }

  static Future<List<Comment>> loadComment(BuildContext context, User user, String postId)async{
    String url = ConfigWrapper.of(context).baseUrl;
    var response = await http.get(
        "$url/api/v1/posts/$postId/comments",
        headers: {
          "access-token": user.accessToken
        }
    );
    print("post ${response.body}");
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body)['data'] as List;
      return json.map((comment){
        return Comment.fromJson(comment);
      }).toList();
    }
    return List();
  }

  static Future<bool> createComment(BuildContext context, User user, String postId, String commentDetail)async{
    String url = ConfigWrapper.of(context).baseUrl;
    var response = await http.post(
        "$url/api/v1/posts/$postId/addcomment",
        headers: {
          "access-token": user.accessToken,
          "Content-Type":"application/json"
        },
      body: jsonEncode({
        "commentDetail":commentDetail
      })
    );
    print("post ${response.body}");
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}