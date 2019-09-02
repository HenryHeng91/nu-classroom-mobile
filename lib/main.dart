import 'package:flutter/material.dart';
import 'package:flutter_kickstart/presentations/main_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'config_wrapper.dart';
import 'env/config.dart';
import 'env/dev.dart';
import 'models/app_state.dart';
import 'reducers/app_state_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appStateReducer,
      initialState: AppState(List()), middleware: [thunkMiddleware]);

  runApp(ConfigWrapper(
    config: Config.fromJson(config),
    child: new MyApp(
      store: store,
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Flutter KickStart',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage(),
      ),
    );
  }
}
