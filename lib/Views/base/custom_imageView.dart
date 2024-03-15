

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatefulWidget {
  String imageUrl;
  CustomImageView({super.key,required this.imageUrl});

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  @override
  Widget build(BuildContext context) {
    return  PageView(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
            },
              child: Image.asset(widget.imageUrl,fit: BoxFit.fitWidth,))
        ],

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

