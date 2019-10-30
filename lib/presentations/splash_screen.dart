import 'package:flutter/material.dart';
import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/api_client/user_api_client.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),() async {
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
        await login(context, accessToken);
        return;
      }
      else{
        Navigator.of(context).pushNamed("/tutorial");
      }
    });
  }

  Future<void> login(BuildContext context, String accessToken) async{
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
      StoreProvider.of<AppState>(context).dispatch(SetGlobalUser(user));
      if(user.firstName == null){
        Navigator.of(context).pushReplacementNamed("/signup");
      }else {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

}