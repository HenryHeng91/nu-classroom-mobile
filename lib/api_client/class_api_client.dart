import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:http/http.dart' as http;


enum filter {
  all,
  created,
  joined
}

class ClassAPIClient{
  static Future<List<Class>> loadClass(BuildContext context, User user, filter classFilter,int page)async{
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/classes";
    if(classFilter == filter.created){
      url = "$url/created";
    }else if(classFilter == filter.joined){
      url = "$url/joined";
    }

    var response = await http.get(
        url,
        headers: {
          "access-token": user.accessToken
        }
    );
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body)['data'] as List;
      return json.map((classJson){
        return Class.fromJson(classJson);
      }).toList();
    }
    return List();
  }

  static Future<List<Category>> loadCategory(BuildContext context, User user)async{
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/categories";


    var response = await http.get(
        url,
        headers: {
          "access-token": user.accessToken
        }
    );
    print(response.body);
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      return json.map((categoryJson){
        return Category.fromJson(categoryJson);
      }).toList();
    }
    return List();
  }

  static Future<bool> createClass(BuildContext context, User user, CreateClass createClass)async{
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/classes";

    print(jsonEncode(createClass.toJson()));
    var response = await http.post(
      url,
      headers: {
        "access-token": user.accessToken,
        "Content-Type":"application/json"
      },
      body: jsonEncode(createClass.toJson())
    );
    debugPrint(response.body);
    if(response.statusCode == 201) {
      return true;
    }
    return false;
  }
}