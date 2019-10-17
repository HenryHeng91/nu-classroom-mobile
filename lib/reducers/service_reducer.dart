import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User,SetGlobalUser>(_setGlobalUser)
]);

User _setGlobalUser(User user, SetGlobalUser action){
  return action.user;
}

