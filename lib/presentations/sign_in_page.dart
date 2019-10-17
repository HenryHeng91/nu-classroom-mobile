import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter_kickstart/utils/kh_number_formatter.dart';

class SignInPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Input your phone number",
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
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "012 345 678",
                        prefixIcon: Container(
                          child: Text(
                            "+855",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                          padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 12,
                              right: 12
                          ),
                          margin: EdgeInsets.only(
                              right: 12
                          ),
                          color: Color(0xFFC2C2C2),
                        ),
                        border: InputBorder.none,
                        isDense: true
                    ),
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                      WhitelistingTextInputFormatter.digitsOnly,
                      KhNumberFormatter()
                    ],
                    keyboardType: TextInputType.number,
                    onSubmitted: (num){
                      Navigator.of(context).pushNamed("/verify");
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                child: Text(
                  "Term and Condition Applied",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                padding: EdgeInsets.only(
                    bottom: 10
                ),
              ),
              Padding(
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "By tapping Sign In, you agree to our ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 12
                            )
                        ),
                        TextSpan(
                            text: "Terms and Condition",
                            style: TextStyle(
                                fontSize: 12
                            )
                        )
                      ]
                  ),
                ),
                padding: EdgeInsets.only(
                    bottom: 0
                ),
              ),
              Padding(
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "and that you have read our ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 12
                            )
                        ),
                        TextSpan(
                            text: "Data Use Policy.",
                            style: TextStyle(
                                fontSize: 12
                            )
                        )
                      ]
                  ),
                ),
                padding: EdgeInsets.only(
                    bottom: 30
                ),
              ),
              Padding(
                child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: InkWell(
                      child: Container(
                        child: Text(
                          "SIGN IN",
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
//                      onTap: ()=>Navigator.of(context).pushNamed("/verify"),
                      onTap: () async {
                        FlutterAccountKit akt = new FlutterAccountKit();
                        Config cfg = Config(
                          facebookNotificationsEnabled: true,
                          responseType: ResponseType.code,
                          readPhoneStateEnabled: false,
                          initialPhoneNumber: PhoneNumber(
                            countryCode: '+855'
                          )
                        );
                        await akt.configure(cfg);
                        LoginResult result = await akt.logInWithPhone();
                        if(result.status == LoginStatus.loggedIn){
                          Navigator.of(context).pushNamed("/verify");
                        }
                      },
                    )
                ),
                padding: EdgeInsets.only(
                    bottom: 10
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}