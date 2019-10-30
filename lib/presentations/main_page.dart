import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/presentations/class_page.dart';
import 'package:flutter_kickstart/presentations/home_page.dart';
import 'package:flutter_kickstart/presentations/notification_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import '../config_wrapper.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage>{
  static const platform = const MethodChannel('app.channel.shared.data');
  var bottomNavController = BehaviorSubject<int>();
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ClassPage(),
    NotificationPage(),
  ];

  @override
  void initState() {
    super.initState();

    _init();
  }

  _init() async {
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg.contains('resumed')) {
        var shareData = await platform.invokeMethod('getSharedData');
        if(shareData != null){
          print("sharedata $shareData ${(shareData as Map<dynamic,dynamic>).containsKey("classId")}");
          if(shareData['classId'] != null){
            showDialog(
              context: context,
              builder: (context){
                String classId = shareData['classId'];
                return AlertDialog(
                  title: Text("Join Class"),
                  content: Text("Would you like to join this class?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: (){
                        _joinClass(context, StoreProvider.of<AppState>(context).state.user, classId);
                      },
                    ),
                    FlatButton(
                      child: Text("No"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
            );
          }
        }
      }
      return;
    });

    var shareData = await platform.invokeMethod('getSharedData');
    if(shareData != null){
      print("sharedata $shareData ${(shareData as Map<dynamic,dynamic>).containsKey("classId")}");
      if(shareData['classId'] != null){
        showDialog(
            context: context,
            builder: (context){
              String classId = shareData['classId'];
              return AlertDialog(
                title: Text("Join Class"),
                content: Text("Would you like to join this class?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: (){
                      _joinClass(context, StoreProvider.of<AppState>(context).state.user, classId);
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
    }
  }
  @override
  void dispose() {
    bottomNavController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState,_ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context,viewModel) => new Scaffold(
          bottomNavigationBar: StreamBuilder(
            stream: bottomNavController.stream,
            builder: (context, AsyncSnapshot<int> snapshot){
              var index = 0;
              if(snapshot.hasData && !snapshot.hasError && snapshot.data!=null){
                index = snapshot.data;
              }
              return BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                          AssetImage("assets/icons/home.png")
                      ),
                      activeIcon: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/home.png"),
                            color: Colors.black,
                          ),
                          Container(
                            height: 4,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(4))
                            ),
                          )
                        ],
                      ),
                      title: Text("Home")
                  ),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                          AssetImage("assets/icons/class.png")
                      ),
                      activeIcon: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/class.png"),
                            color: Colors.black,
                          ),
                          Container(
                            height: 4,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(4))
                            ),
                          )
                        ],
                      ),
                      title: Text("Class")
                  ),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                          AssetImage("assets/icons/notification.png")
                      ),
                      activeIcon: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/notification.png"),
                            color: Colors.black,
                          ),
                          Container(
                            height: 4,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(4))
                            ),
                          )
                        ],
                      ),
                      title: Text("Notification")
                  )
                ],
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.white,
                currentIndex: index,
                onTap: (index){
                  bottomNavController.add(index);
                },
              );
            },
          ),
          body: StreamBuilder(
            stream: bottomNavController.stream,
            builder: (context, AsyncSnapshot<int> snapshot){
              var index = 0;
              if(snapshot.hasData && !snapshot.hasError && snapshot.data!=null){
                index = snapshot.data;
              }
              return IndexedStack(
                children: _widgetOptions,
                index: index,
              );
            }
          ),
        )
    );
  }

  Future<void> _joinClass(BuildContext context, User user, String classId)async{
    var pr = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false
    );
    pr.style(
        progressWidget: Padding(
          child: CircularProgressIndicator(),
          padding: EdgeInsets.all(10),
        ),
        message: "Joining class ..."
    );
    pr.show();
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/classes/${classId}/join";
    print("url $url");
    var response = await http.get(
        url,
        headers: {
          "access-token": user.accessToken
        }
    );
    pr.dismiss();
    if(response.statusCode == 200){
      Alert(
        context: context,
        type: AlertType.success,
        title: "SUCCESS",
        desc: "You have join class successfully!.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "SORRY",
        desc: "Something went wrong! Please try again later!.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }
}

class _ViewModel {
  final Store<AppState> store;

  _ViewModel(this.store);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store);
  }
}