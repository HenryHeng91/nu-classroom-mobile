import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_kickstart/models/app_state.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState,_ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context,viewModel) => new Scaffold(
          appBar: new AppBar(
            title: new Text("Main Page"),
          )
        )
    );
  }
}

class _ViewModel {
  final Store<AppState> store;

  _ViewModel(this.store);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store);
  }
}