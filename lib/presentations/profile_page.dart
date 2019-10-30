import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_account_kit/flutter_account_kit.dart';
import 'package:flutter_kickstart/actions/actions.dart';
import 'package:flutter_kickstart/api_client/user_api_client.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/containers/bottom_sheet_photo.dart';
import 'package:flutter_kickstart/containers/filter.dart';
import 'package:flutter_kickstart/containers/profile_activity.dart';
import 'package:flutter_kickstart/custom_widgets/profile_action_button.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/utils/date_util.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{
  File _image;
  var profileStream = StreamController<File>();

  @override
  void dispose() {
    profileStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, _ViewModel viewModel){
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      title: new Text(
        "Me",
        style: TextStyle(
            fontSize: 24
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildBody(_ViewModel viewModel){
    return Container(
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              InkWell(
                child: Container(
                  width: 120,
                  height: 120,
                  child: Card(
                    elevation: 4,
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: StreamBuilder(
                      stream: profileStream.stream,
                      builder: (context, snapshot){
                        if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                          return Image.file(
                            _image,
                            fit: BoxFit.cover,
                          );
                        }
                        return Image.network(
                          viewModel.user.profilePicture,
                        );
                      },
                    ),
                  ),
                ),
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context){
                      return BottomSheetPhoto(
                        onChooseCamera: () async {
                          _image = await ImagePicker.pickImage(source: ImageSource.camera);
                          profileStream.add(_image);
                          Navigator.of(context).pop();
                        },
                        onChooseGallery: () async {
                          _image = await ImagePicker.pickImage(source: ImageSource.gallery);
                          profileStream.add(_image);
                          Navigator.of(context).pop();
                          _uploadProfile(_image, viewModel.user);
                        },
                      );
                    }
                  );
                },
              ),
              Padding(
                child: Text(
                  "${viewModel.user.firstName} ${viewModel.user.lastName}",
                  style: TextStyle(
                      fontSize: 24
                  ),
                ),
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10
                ),
              ),
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ProfileActionButton(
                      icon: ImageIcon(
                        AssetImage("assets/icons/profile.png"),
                        size: 50,
                      ),
                      name: "Edit Profile",
                      onTap: (){
                        Navigator.of(context).pushNamed("/editprofile");
                      },
                    ),
                    ProfileActionButton(
                      icon: ImageIcon(
                        AssetImage("assets/icons/my_class.png"),
                        size: 50,
                      ),
                      name: "My Classes",
                    ),
                    PopupMenuButton(
                      child: ProfileActionButton(
                        icon: ImageIcon(
                          AssetImage("assets/icons/more.png"),
                          size: 50,
                        ),
                        name: "More",
                      ),
                      itemBuilder: (context){
                        return [
                          PopupMenuItem(
                            child: Text("Log Out"),
                            value: "logout",
                          )
                        ];
                      },
                      onSelected: (val) async {
                        if(val == "logout"){
                          FlutterAccountKit akt = new FlutterAccountKit();
                          await akt.logOut();
                          StoreProvider.of<AppState>(context).dispatch(SetGlobalUser(null));
                          Navigator.of(context).pushNamedAndRemoveUntil("/",ModalRoute.withName('/'));
                        }
                      },
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                    bottom: 10
                ),
              ),
              Padding(
                child: Text(
                  viewModel.user.selfDescription ?? "No Self Description",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Padding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: Row(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/gender.png"),
                            size: 30,
                          ),
                          Padding(
                            child: Text(
                              viewModel.user.gender.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: 20
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          bottom: 5
                      ),
                    ),
                    Padding(
                      child: Row(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/dob.png"),
                            size: 30,
                          ),
                          Padding(
                            child: Text(
                              viewModel.user.birthDate!=null ? DateUtil.formatDate(viewModel.user.birthDate, "yyyy-MM-dd", "dd MMMM yyyy"):"",
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: 20
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          bottom: 5
                      ),
                    ),
                    Padding(
                      child: Row(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/email.png"),
                            size: 30,
                          ),
                          Padding(
                            child: Text(
                              viewModel.user.email ?? "No Email",
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: 20
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          bottom: 5
                      ),
                    ),
                    Padding(
                      child: Row(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/phone.png"),
                            size: 30,
                          ),
                          Padding(
                            child: Text(
                              viewModel.user.phone,
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: 20
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          bottom: 5
                      ),
                    ),
                    Padding(
                      child: Row(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/grade.png"),
                            size: 30,
                          ),
                          Padding(
                            child: Text(
                              viewModel.user.educationLevel ?? "",
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: 20
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          bottom: 5
                      ),
                    ),
                    Padding(
                      child: Row(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/icons/more.png"),
                            size: 30,
                          ),
                          Padding(
                            child: Text(
                              "more information",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF294B76)
                              ),
                            ),
                            padding: EdgeInsets.only(
                                left: 20
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          bottom: 5
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
              Padding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Classmates",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: 5,
                          right: 5,
                          bottom: 10
                      ),
                    ),
                    FutureBuilder(
                      future: _getClassmate(context, viewModel.user),
                      builder: (context, AsyncSnapshot<List<Classmate>> snapshot){
                        if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                          var classmates = snapshot.data;
                          if(classmates?.length>0){
                            return GridView.builder(
                              itemCount: classmates.length > 6 ? 6 : classmates.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index){
                                return Stack(
                                  children: <Widget>[
                                    Container(
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/images/dummy.png",
                                        image: classmates[index].profilePicture,
                                        fit: BoxFit.cover,
                                      ),
                                      margin: EdgeInsets.all(5),
                                    ),
                                    Positioned(
                                      child: Container(
                                        color: Colors.white30,
                                        child: Text(
                                          "${classmates[index].firstName} ${classmates[index].lastName}",
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        padding: EdgeInsets.all(4),
                                      ),
                                      bottom: 5,
                                      width: MediaQuery.of(context).size.width/3 - 10,
                                    )
                                  ],
                                );
                              },
                            );
                          }else{
                            return Container(
                              child: Text(
                                  "No Classmate",
                                textAlign: TextAlign.center,
                              ),
                              width: double.infinity,
                            );
                          }
                        }
                        return Container(
                          child: Column(
                            children: <Widget>[CircularProgressIndicator()],
                          ),
                          width: double.infinity,
                        );
                      },
                    ),
                    Padding(
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          child: Text(
                            "See More",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),
                            textAlign: TextAlign.center,
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          right: 5,
                          left: 5,
                          top: 15,
                          bottom: 10
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.all(15),
              ),
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Activities",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    IconButton(
                      icon: ImageIcon(
                          AssetImage("assets/icons/filter.png")
                      ),
                      onPressed: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return Filter();
                            }
                        );
                      },
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
              ),
              ProfileActivity()
            ],
          )
      ),
      color: Colors.white,
    );
  }

  Future<void> _uploadProfile(File file, User user) async {
    var url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/me/profilepicutre";
    FormData formData = FormData.fromMap({
      "image_file": await MultipartFile.fromFile(_image.path)
    });
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
      message: "Uploading ..."
    );
    pr.show();
    try{
      var response = await Dio().post(
        url,
        data: formData,
        onSendProgress: (progress, total){
          pr.update(
            progress: progress.toDouble(),
            maxProgress: total.toDouble()
          );
        },
        options: Options(
          headers: {
            "access-token": user.accessToken
          },
        ),
      );
      pr.dismiss();
      debugPrint("code ${response.data}");
      if(response.statusCode == 200){
        var user = User.fromJson(response.data['data']);
        print("user ${user?.profilePicture}");
        StoreProvider.of<AppState>(context).dispatch(SetGlobalUser(user));
      }
    }catch(error){
      print("error $error");
      pr.dismiss();
    }
  }


  Future<List<Classmate>> _getClassmate(BuildContext context, User user) async {
    return await UserAPIClient.getClassmate(context, user);
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