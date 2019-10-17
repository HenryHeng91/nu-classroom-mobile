import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/app_state.dart';
import 'package:flutter_kickstart/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CreatePostPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CreatePostPageState();
  }
}

class _CreatePostPageState extends State<CreatePostPage>{
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      rebuildOnChange: false,
      builder: (context, _ViewModel viewModel){
        return Scaffold(
          appBar: _buildAppBar(),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 120,
                          child: Card(
                            elevation: 4,
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/logo.png",
                              image: viewModel.user.profilePicture,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text("Henry Heng"),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text("Your feed"),
                                        ),
                                        ImageIcon(
                                          AssetImage("assets/images/dropdown.png")
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text("Public"),
                                        ),
                                        ImageIcon(
                                            AssetImage("assets/images/dropdown.png")
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Write your description..."
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ImageIcon(
                                AssetImage("assets/icons/add.png")
                              ),
                              Text("Post to Class")
                            ],
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              ImageIcon(
                                  AssetImage("assets/icons/photo.png")
                              ),
                              Text("Photo")
                            ],
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              ImageIcon(
                                  AssetImage("assets/icons/file.png")
                              ),
                              Text("File")
                            ],
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              ImageIcon(
                                  AssetImage("assets/icons/question.png")
                              ),
                              Text("Ask Questions")
                            ],
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
      },
    );
  }

  AppBar _buildAppBar(){
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
                    border: Border.all(
                        color: Colors.black,
                        width: 1
                    )
                ),
              ),
            ),
          ),
          onTap: (){
            Navigator.of(context).pushNamed("/me");
          },
        )
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}

class _ViewModel {
  final User user;

  _ViewModel(this.user);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.user);
  }
}