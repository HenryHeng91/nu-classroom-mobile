import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:http/http.dart' as http;

class UserAPIClient{
  static Future<List<Classmate>> getClassmate(BuildContext context, User user) async {
    var url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/me/classmates";
    var response = await http.get(
        url,
        headers: {
          "access-token": user.accessToken
        }
    );
    if(response.statusCode == 200){
      return (jsonDecode(response.body)['data'] as List).map((classmate){
        return Classmate.fromJson(classmate);
      }).toList();
    }
    return List();
  }

  static Future<User> login(BuildContext context,String accessToken) async{
    String url = ConfigWrapper.of(context).baseUrl;
    var response = await http.get(
        "$url/api/v1/me",
        headers: {
          "access-token": accessToken
        }
    );
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var user = User.fromJson(json['data']);
      return user;
    }
    return null;
  }

  static Future<User> update(BuildContext context,Map<dynamic,dynamic> user,String accessToken) async{
    try{
      print(jsonEncode(user));
      String url = ConfigWrapper.of(context).baseUrl;
      var response = await http.put(
          "$url/api/v1/me",
          headers: {
            "access-token": accessToken
          },
          body: jsonEncode(
              user
          )
      );
      if(response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var user = User.fromJson(json['data']);
        return user;
      }
      return null;
    }catch(error){
      print("error $error");
    }
  }
}