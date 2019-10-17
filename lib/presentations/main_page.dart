import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/presentations/class_page.dart';
import 'package:flutter_kickstart/presentations/home_page.dart';
import 'package:flutter_kickstart/presentations/notification_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:rxdart/rxdart.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage>{
  var bottomNavController = BehaviorSubject<int>();
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ClassPage(),
    NotificationPage(),
  ];

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
}

class _ViewModel {
  final Store<AppState> store;

  _ViewModel(this.store);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store);
  }
}