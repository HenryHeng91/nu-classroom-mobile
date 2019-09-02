import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:redux/redux.dart';

final serviceReducer = combineReducers<List<Service>>([
  TypedReducer<List<Service>,ReceiveServiceList>(_receiveServiceList)
]);

List<Service>_receiveServiceList(List<Service> services, ReceiveServiceList action){
  return action.services;
}

