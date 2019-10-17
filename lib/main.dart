import 'package:flutter/material.dart';
import 'package:flutter_kickstart/presentations/category_page.dart';
import 'package:flutter_kickstart/presentations/create_class_page.dart';
import 'package:flutter_kickstart/presentations/create_post_page.dart';
import 'package:flutter_kickstart/presentations/edit_profile_page.dart';
import 'package:flutter_kickstart/presentations/main_page.dart';
import 'package:flutter_kickstart/presentations/post_to_class_page.dart';
import 'package:flutter_kickstart/presentations/post_to_page.dart';
import 'package:flutter_kickstart/presentations/profile_page.dart';
import 'package:flutter_kickstart/presentations/sign_in_page.dart';
import 'package:flutter_kickstart/presentations/sign_up_page.dart';
import 'package:flutter_kickstart/presentations/splash_screen.dart';
import 'package:flutter_kickstart/presentations/verify_code_page.dart';
import 'package:flutter_kickstart/presentations/visibility_page.dart';
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
      initialState: AppState(
          null
      ), middleware: [thunkMiddleware]);

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
          primarySwatch: Colors.yellow,
          primaryColor: Color(0xFFF9A825),
          primaryColorLight: Color(0xFFFFBF10)
        ),
        routes: {
          "/":(context)=>SplashScreen(),
          "/home":(context)=>MainPage(),
          "/me":(context)=>ProfilePage(),
          "/signin":(context)=>SignInPage(),
          "/signup":(context)=>SignUpPage(),
          "/verify": (context)=>VerifyCodePage(),
          "/createpost": (context)=>CreatePostPage(),
          "/posttoclass": (context)=>PostToClassPage(),
          "/visibility": (context)=>VisibilityPage(),
          "/postto": (context)=>PostToPage(),
          "/editprofile":(context)=>EditProfilePage(),
          "/createclass":(context)=>CreateClassPage(),
          "/category":(context)=>CategoryPage()
        },
      ),
    );
  }
}
