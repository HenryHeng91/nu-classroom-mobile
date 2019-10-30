import 'package:flutter/material.dart';
import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/api_client/user_api_client.dart';
import 'package:flutter_kickstart/containers/tutorial.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';

class TutorialScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TutorialScreenState();
  }

}

class _TutorialScreenState extends State<TutorialScreen>{

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (context,_ViewModel viewModel){
        return Scaffold(
          body: Stack(
            children: <Widget>[
              PageIndicatorContainer(
                child: PageView(
                  children: <Widget>[
                    Tutorial(
                      imagePath: "assets/images/logo.png",
                      title: "Welcome to Norton Classroom",
                      description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                    ),
                    Tutorial(
                      imagePath: "assets/images/virtual_classroom.png",
                      title: "Virtual classroom",
                      description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                    ),
                    Tutorial(
                      imagePath: "assets/images/access.png",
                      title: "Access material everywhere",
                      description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                    ),
                    Tutorial(
                      imagePath: "assets/images/plan.png",
                      title: "Plan ahead",
                      description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                    ),
                    Tutorial(
                      imagePath: "assets/images/start.png",
                      title: "Let's get started!",
                      description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                    )
                  ],
                ),
                align: IndicatorAlign.bottom,
                length: 5,
                padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 120
                ),
                indicatorColor: Color.fromRGBO(4, 4, 3, 0.5),
                indicatorSelectorColor: Colors.white,
                shape: IndicatorShape.circle(size: 10),
              ),
              Align(
                child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: InkWell(
                      child: Container(
                        child: Text(
                          "START",
                          style: TextStyle(
                              fontSize: 28,
                              color: Theme.of(context).primaryColor
                          ),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.all(10),
                        constraints: BoxConstraints(
                            minWidth: 300
                        ),
                      ),
                      onTap: ()=>_gotoHomeScreen(viewModel),
                    )
                ),
                alignment: Alignment(0,0.9),
              )
            ],
          ),
        );
      },
    );
  }

  _gotoHomeScreen(_ViewModel _viewModel) async {
    FlutterAccountKit akt = new FlutterAccountKit();
    Config cfg = Config(
        facebookNotificationsEnabled: true,
        responseType: ResponseType.token,
        readPhoneStateEnabled: false,
        initialPhoneNumber: PhoneNumber(
            countryCode: '+855'
        )
    );
    await akt.configure(cfg);
    var isLogin = await akt.isLoggedIn;
    if(isLogin){
      var accessToken = (await akt.currentAccessToken).token;
      await login(context, _viewModel, accessToken);
      return;
    }
    LoginResult result = await akt.logInWithPhone();
    if(result.status == LoginStatus.loggedIn){
      await login(context, _viewModel, result.accessToken.token);
    }
  }

  Future<void> login(BuildContext context,_ViewModel _viewModel, String accessToken) async{
    var pr = ProgressDialog(
        context,
        type: ProgressDialogType.Download,
        isDismissible: false,
        showLogs: false
    );
    pr.style(
        progressWidget: Padding(
          child: CircularProgressIndicator(),
          padding: EdgeInsets.all(10),
        ),
        message: "Loggin In ..."
    );
    pr.show();
    var user = await UserAPIClient.login(context, accessToken);
    pr.dismiss();
    if(user != null) {
      user.accessToken = accessToken;
      _viewModel.setGlobalUser(user);
      if(user.firstName == null){
        Navigator.of(context).pushReplacementNamed("/signup");
      }else {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
  }
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