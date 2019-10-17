import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ClassActivityPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClassActivityPageState();
  }
}

class _ClassActivityPageState extends State<ClassActivityPage>{
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (context, _ViewModel viewModel){
        return Scaffold(

        );
      },
    );
  }
}

class _ViewModel {
  final User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.user);
  }
}