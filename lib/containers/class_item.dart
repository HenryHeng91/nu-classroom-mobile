import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum action{
  join,
  leave,
  share
}

class ClassItem extends StatefulWidget{
  final Class classItem;

  const ClassItem({Key key, this.classItem}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ClassItemState();
  }
}

class _ClassItemState extends State<ClassItem>{
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      distinct: true,
      rebuildOnChange: false,
      builder: (context,_ViewModel viewModel){
        return Container(
          child: Material(
            color: hexToColor(widget.classItem.color),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.classItem.classTitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22
                          ),
                        ),
                        Text(
                          widget.classItem.organization!=null ? widget.classItem.organization.name : "",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        Text(
                          "${widget.classItem.membersCount} students",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          widget.classItem.instructor != null ? "${widget.classItem.instructor.first_name} ${widget.classItem.instructor.last_name}" : "",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/classes/leadership.png"),
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: ImageIcon(
                            AssetImage("assets/icons/notification.png"),
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          child: PopupMenuButton(
                            child: ImageIcon(
                              AssetImage("assets/icons/more.png"),
                              color: Colors.white,
                            ),
                            itemBuilder: (context) => [
//                              PopupMenuItem<action>(
//                                child: Text("Join Class"),
//                                value: action.join,
//                              ),
                              PopupMenuItem<action>(
                                child: Text("Leave Class"),
                                value: action.leave,
                              ),
                              PopupMenuItem<action>(
                                child: Text("Share Class"),
                                value: action.share,
                              )
                            ],
                            onSelected: (val) async {
                              if(val == action.join){
                                _joinClass(context, viewModel.user, widget.classItem, val);
                              }else if(val == action.leave){
                                _leaveClass(context, viewModel.user, widget.classItem, val);
                              }else if(val == action.share){
                                var response = await FlutterShareMe().shareToSystem(msg: widget.classItem.url);
                                if (response == 'success') {
                                  print('navigate success');
                                }
                              }
                            },
                          ),
                          padding: EdgeInsets.all(10),
                        )
                      ],
                    ),
                  )
                ],
              ),
              height: 150,
            ),
          ),
          margin: EdgeInsets.all(10),
        );
      },
    );
  }

  Color hexToColor(String code) {
    if(!code.contains("#")){
      return new Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
    }
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Future<void> _joinClass(BuildContext context, User user, Class classItem, action action)async{
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
    url = "$url/api/v1/classes/${classItem.id}/join";
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
            onPressed: () => Navigator.pop(context),
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
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
  Future<void> _leaveClass(BuildContext context, User user, Class classItem, action action)async{
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
        message: "Leaving class ..."
    );
    pr.show();
    String url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/classes/${classItem.id}/left";
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
        desc: "You have left class successfully!.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
            onPressed: () => Navigator.pop(context),
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
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
}

class _ViewModel{
  User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store.state.user
    );
  }
}