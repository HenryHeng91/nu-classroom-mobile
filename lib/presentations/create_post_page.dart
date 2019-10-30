import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/api_client/post_api_client.dart';
import 'package:flutter_kickstart/config_wrapper.dart';
import 'package:flutter_kickstart/containers/action_item.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_kickstart/presentations/create_exam.dart';
import 'package:flutter_kickstart/presentations/create_question.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class CreatePostPage extends StatefulWidget{
  final Class myClass;

  const CreatePostPage({Key key, this.myClass}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CreatePostPageState();
  }
}

class _CreatePostPageState extends State<CreatePostPage>{
  CreatePost createPost = CreatePost(
    postType: "POST",
    access: "PUBLIC",
  );
  var chooseClass;
  var classWork;
  var descriptionController = TextEditingController();
  var attachmentStream = StreamController<Attachment>();
  var classworkStream = StreamController<CreatePost>();
  Attachment attachment;

  @override
  void dispose() {
    descriptionController.dispose();
    attachmentStream.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(widget.myClass != null){
      chooseClass = widget.myClass;
      createPost.classId = widget.myClass.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      rebuildOnChange: false,
      builder: (context, _ViewModel viewModel){
        return Scaffold(
          appBar: _buildAppBar(viewModel),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  AppBar _buildAppBar(_ViewModel viewModel){
    return AppBar(
      title: new Text(
        "Create Post",
        style: TextStyle(
            fontSize: 24
        ),
      ),
      actions: <Widget>[
        InkWell(
          child: Container(
            width: 54,
            child: Center(
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/submit.png")
                    ),
                    shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          onTap: (){
            createPost.detail = descriptionController.text;
            print("attachment $attachment");
            _submitPost(context, createPost, viewModel.user, attachment);
          },
        )
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildBody(_ViewModel viewModel){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/dummy.png",
                        image: viewModel.user.profilePicture,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(54)),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${viewModel.user.firstName} ${viewModel.user.lastName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                              margin: EdgeInsets.only(
                                  bottom: 10
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            createPost.classId != null ? chooseClass.classTitle : "Your feed",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          width: 50,
                                        ),
                                        ImageIcon(
                                            AssetImage("assets/icons/dropdown.png")
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 5
                                    ),
                                  ),
                                  onTap: () async {
                                    var postto = await Navigator.of(context).pushNamed("/postto");
                                    if(postto != null){
                                      if(postto == "class"){
                                        chooseClass = await Navigator.of(context).pushNamed("/posttoclass");
                                        print("posttoclass $chooseClass");
                                        if(chooseClass!=null){
                                          createPost.classId = chooseClass.id;
                                        }
                                      }else{
                                        createPost.classId = null;
                                      }
                                    }
                                  },
                                ),
                                InkWell(
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(createPost.access),
                                        ),
                                        ImageIcon(
                                            AssetImage("assets/icons/dropdown.png")
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 5
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 10
                                    ),
                                  ),
                                  onTap: () async {
                                    var access = await Navigator.of(context).pushNamed("/visibility");
                                    if(access != null){
                                      createPost.access = access;
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(
                            left: 10
                        ),
                      ),
                    )
                  ],
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: "Write your description..."
                  ),
                  maxLines: 10,
                ),
                StreamBuilder(
                  stream: attachmentStream.stream,
                  builder: (context, AsyncSnapshot<Attachment> snapshot){
                    if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                      var attachment = snapshot.data;
                      this.attachment = attachment;
                      return Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: attachment.FileType == "Photo" ? Image.file(attachment.file) : Image.asset("assets/images/question.png"),
                              width: 100,
                              height: 100,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 100
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            width: 1,
                                            color: Colors.black
                                        )
                                    )
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      attachment.FileType,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Colors.black,
                                width: 1
                            )
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                StreamBuilder(
                  stream: classworkStream.stream,
                  builder: (context, AsyncSnapshot<CreatePost> snapshot){
                    if(snapshot.hasData && !snapshot.hasError && snapshot.data != null){
                      var classwork = snapshot.data;
                      if(classwork.classwork != null){
                        return Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/images/question.png"),
                                width: 100,
                                height: 100,
                              ),
                              VerticalDivider(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: 100
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 1,
                                              color: Colors.black
                                          )
                                      )
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        classwork.postType,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1
                              )
                          ),
                        );
                      }
                    }
                    return SizedBox.shrink();
                  },
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      ActionItem(
                        title: "Post to Class",
                        icon: ImageIcon(
                            AssetImage("assets/icons/add.png")
                        ),
                        onTap: () async {
                          chooseClass = await Navigator.of(context).pushNamed("/posttoclass");
                          if(chooseClass!=null){
                            createPost.classId = chooseClass.id;
                          }
                        },
                      ),
                      Divider(),
                      ActionItem(
                        title: "Photo",
                        icon: ImageIcon(
                            AssetImage("assets/icons/photo.png")
                        ),
                        onTap: () async {
                          showModalChoosePhoto();
                        },
                      ),
                      Divider(),
                      ActionItem(
                        title: "File",
                        icon: ImageIcon(
                            AssetImage("assets/icons/file.png")
                        ),
                        onTap: () async {
                          showModalChooseFile();
                        },
                      ),
                      Divider(),
                      ActionItem(
                        title: "Ask Questions",
                        icon: ImageIcon(
                            AssetImage("assets/icons/question.png")
                        ),
                        onTap: () async {
                          if(createPost.postType == "EXAM"){
                            createPost.classwork = null;
                          }
                          classWork = await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>CreateQuestion(createClasswork: createPost.classwork,)
                          ));
                          if(classWork != null){
                            createPost.classwork = classWork;
                            createPost.postType = "QUESTION";
                          }
                          classworkStream.add(createPost);
                        },
                      ),
                      Divider(),
                      ActionItem(
                        title: "Create Exam",
                        icon: ImageIcon(
                            AssetImage("assets/icons/question.png")
                        ),
                        onTap: () async {
                          if(createPost.postType == "QUESTION"){
                            createPost.classwork = null;
                          }
                          classWork = await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>CreateExam(createClasswork: createPost.classwork,)
                          ));
                          if(classWork != null){
                            createPost.classwork = classWork;
                            createPost.postType = "EXAM";
                          }
                          classworkStream.add(createPost);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _submitPost(BuildContext context, CreatePost post, User user,Attachment attachment) async {
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
        message: "Sending ..."
    );
    pr.show();
    if(attachment != null){
      String fileId = await _uploadFile(context, attachment.file, user);
      print("fileId $fileId");
      post.fileId = fileId;
    }

    try{
      var temp = post.toJson();
      post.toJson().forEach((key,value){
        if(value == null){
          temp.remove(key);
        }
      });
      print(jsonEncode(temp));
      var postSuccess = await PostAPIClient.submitPost(context, post, user);
      pr.dismiss();
      print("success $postSuccess");
      if(postSuccess){
        Navigator.of(context).pop();
      }
    }catch(error){
      print("error $error");
      pr.dismiss();
    }
  }

  Future<String> _uploadFile(BuildContext context, File file, User user) async {
    var url = ConfigWrapper.of(context).baseUrl;
    url = "$url/api/v1/files";
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
      "useIn":"POST",
      "access":"PUBLIC"
    });
    try{
      var response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: {
            "access-token": user.accessToken
          },
        ),
      );
      debugPrint("code ${response.data['data']}");
      if(response.statusCode == 201){
        return response.data['data']['id'];
      }
    }catch(error){
      print("error $error");
    }
  }

  showModalChoosePhoto(){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
          return FractionallySizedBox(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Choose Source',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    margin: EdgeInsets.only(
                        bottom: 10
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1
                                )
                            ),
                            color: Colors.transparent,
                            child: InkWell(
                              child: Container(
                                  child: Text(
                                    "GALLERY",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity
                              ),
                              onTap: () async {
                                var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                attachmentStream.add(Attachment("Photo", image));
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          margin: EdgeInsets.only(
                              bottom: 10
                          ),
                        ),
                        Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1
                              )
                          ),
                          color: Colors.transparent,
                          child: InkWell(
                            child: Container(
                                child: Text(
                                  "CAMERA",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                padding: EdgeInsets.all(10),
                                width: double.infinity
                            ),
                            onTap: () async {
                              var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                              attachment = Attachment("Photo", image);
                              attachmentStream.add(attachment);
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
            ),
            heightFactor: 0.3,
          );
        }
    );
  }

  showModalChooseFile() async {
    File file = await FilePicker.getFile(type: FileType.ANY);
    attachment = Attachment("File", file);
    attachmentStream.add(attachment);
  }
}

class Attachment{
  final String FileType;
  final File file;

  Attachment(this.FileType, this.file);

}

class _ViewModel {
  final User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.user);
  }
}