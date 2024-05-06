import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  String path;
   VideoApp({super.key,required this.path});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {});
      });
    print("lkhfghg${widget.path}");

  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = _controller!.value.aspectRatio;
    double containerMargin = 16.0; //space between edge of screen and video

    double dynamicWidth = MediaQuery.of(context).size.width - containerMargin * 2;
    double dynamicHeight = dynamicWidth / aspectRatio;

    return  SizedBox(
      width: 135,
      height: 100,
      child: _controller!.value.isInitialized
          ? Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16), //20 minus yellow border width
                child: AspectRatio(
                        aspectRatio: 7/9,
                        child: FittedBox(
                          fit: BoxFit.cover,
                            child: SizedBox(
                                width: _controller!.value.size.width,
                                height: _controller!.value.size.height,
                                child: VideoPlayer(_controller!))),
                      ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell (
                  onTap: () {
                    setState(() {
                      _controller!.value.isPlaying
                          ? _controller!.pause()
                          : _controller!.play();
                    });
                  },
                  child: Icon(
                    _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,size: 26,
                  ),
                ),
              ),
            ],
          )
          : Container(),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}