import 'package:flutter/material.dart';
import 'package:flutter_kickstart/models/models.dart';

class PostPhoto extends StatelessWidget{
  final Post post;

  const PostPhoto({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      child: FadeInImage.assetNetwork(
          placeholder: "assets/images/logo.png",
          image: post.file.source
      ),
    );
  }
}