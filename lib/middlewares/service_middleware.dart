import 'dart:convert';

import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/env/config.dart';
import 'package:flutter_kickstart/env/prod.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getServiceList = (Store<AppState> store) async {

};