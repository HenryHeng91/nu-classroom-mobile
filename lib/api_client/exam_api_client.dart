import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:http/http.dart' as http;

class ExamAPIClient{
  static Future<bool> submitAnswer(BuildContext context, User user, CreateClasswork classwork)async{
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/questions/submit";

    var answer = CreateClasswork(
      questionId: classwork.questionId,
      questionType: classwork.questionType,
      answer: classwork.answer
    );
    answer.answer.items=null;
    print(jsonEncode(answer.toJson()));
    var response = await http.post(
        url,
        headers: {
          "access-token": user.accessToken
        },
        body: jsonEncode(answer.toJson())
    );
    debugPrint("response ${response.body}");
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}