import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/reducers/service_reducer.dart';

AppState appStateReducer(AppState state,dynamic action){
  return AppState(
    serviceReducer(state.services,action)
  );
}