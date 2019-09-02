import 'dart:convert';

import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/utils/constant.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getServiceList = (Store<AppState> store) async {
  var response = await http.get(baseApiUrl+"service");
  final json = jsonDecode(response.body);
  ServiceResponse serviceResponse = ServiceResponse.fromJson(json);
  if(serviceResponse.success){
    List<Service> services = serviceResponse.result;
    print(services);
    store.dispatch(ReceiveServiceList(services));
  }
};