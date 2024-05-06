

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatefulWidget {
  List<dynamic> imagesUrl;
  CustomImageView({super.key,required this.imagesUrl});

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: PageView.builder(
        itemCount: widget.imagesUrl.length,
          itemBuilder: (context, index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.network(widget.imagesUrl[index].path,fit: BoxFit.cover,)]);
          },



      ),
    );
  }
}

class CustomChatImageView extends StatefulWidget {
  String imageUrl;
  CustomChatImageView({super.key,required this.imageUrl});

  @override
  State<CustomChatImageView> createState() => _CustomChatImageViewState();
}

class _CustomChatImageViewState extends State<CustomChatImageView> {
  @override
  Widget build(BuildContext context) {
    return  PageView(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.network(widget.imageUrl,fit: BoxFit.fitWidth,))
      ],

    );
  }
}

