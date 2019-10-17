import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/api_client/user_api_client.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/utils/kh_number_formatter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class VerifyCodePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _VerifyCodePageState();
  }
}

class _VerifyCodePageState extends State<VerifyCodePage>{
  var loading = StreamController<bool>();

  @override
  void dispose() {
    loading.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.fromStore,
      onDidChange: (_ViewModel viewModel){
        print(viewModel.user.firstName);
      },
      builder: (context, _ViewModel viewModle){
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 55,
                            color: Colors.white,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: 60,
                          bottom: 120
                      )
                  ),
                  Padding(
                    child: Text(
                      "Input PIN code from SMS",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    padding: EdgeInsets.only(
                        bottom: 12
                    ),
                  ),
                  Padding(
                    child: PinCodeTextField(
                      autofocus: false,
                      highlight: true,
                      highlightColor: Colors.white,
                      defaultBorderColor: Colors.white,
                      hasTextBorderColor: Colors.white,
                      maxLength: 6,
                      onDone: (text){
//                        login(context,viewModle);
                      },
                      pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                      pinBoxWidth: MediaQuery.of(context).size.width/5-20,
                      pinBoxHeight: MediaQuery.of(context).size.width/5-20,
                      wrapAlignment: WrapAlignment.start,
                      pinBoxDecoration: (color){
                        return BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        );
                      },
                      pinTextStyle: TextStyle(fontSize: 30.0),
                      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                    ),
                    padding: EdgeInsets.only(
                        bottom: 15
                    ),
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide(
                            color: Colors.white,
                            width: 1
                        )
                    ),
                    color: Colors.transparent,
                    child: StreamBuilder(
                      stream: loading.stream,
                      builder: (context, AsyncSnapshot<bool> snapshot){
                        if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                          if(snapshot.data){
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  CircularProgressIndicator()
                                ],
                              ),
                              padding: EdgeInsets.all(10),
                              width: 200,
                            );
                          }
                        }
                        return InkWell(
                          child: Container(
                            child: Text(
                              "CONTINUE",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.all(10),
                            width: 200,
                          ),
                          onTap: (){
//                            login(context,viewModle);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: "SMS not received? ",
                                style: TextStyle(
                                  color: Colors.white,
                                )
                            ),
                            TextSpan(
                                text: "Resend it!",
                                style: TextStyle(
                                    decoration: TextDecoration.combine(
                                        [
                                          TextDecoration.underline
                                        ]
                                    )
                                )
                            )
                          ]
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: 5
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//  Future<void> login(BuildContext context,_ViewModel _viewModel) async{
//    loading.add(true);
//    var user = await UserAPIClient.login(context, _viewModel.user);
//    loading.add(false);
//    if(user != null) {
//      _viewModel.setGlobalUser(user);
//      Navigator.of(context).pushReplacementNamed("/home");
//    }
//  }
}

class _ViewModel{
  User user;
  Function setGlobalUser;

  _ViewModel(this.user,this.setGlobalUser);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      store.state.user,
      (User user){
        store.dispatch(SetGlobalUser(user));
      }
    );
  }
}