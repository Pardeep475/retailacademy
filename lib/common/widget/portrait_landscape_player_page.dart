import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../app_color.dart';
import 'video_player_both_widget.dart';

class PortraitLandscapePlayerPage extends StatefulWidget {
  final String url;
  final String? token;
  final String? filePath;
  final bool isAutoPlay;
  final double aspectRatio;
  final Duration? duration;
  final Widget? commentIcon;
  final Widget? likeIcon;
  final Widget? titleWidget;
  final Widget? descriptionWidget;
  final Widget? quizWidget;

  const PortraitLandscapePlayerPage(
      {Key? key,
      required this.url,
      this.token,
      this.filePath,
      this.isAutoPlay = true,
      this.aspectRatio = 9 / 16,
      this.commentIcon,
      this.likeIcon,
      this.titleWidget,
      this.descriptionWidget,
      this.quizWidget,
      this.duration})
      : super(key: key);

  @override
  _PortraitLandscapePlayerPageState createState() =>
      _PortraitLandscapePlayerPageState();
}

class _PortraitLandscapePlayerPageState
    extends State<PortraitLandscapePlayerPage> {
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    if (widget.filePath != null) {
      controller = VideoPlayerController.file(File(widget.filePath!))
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) {
          controller?.seekTo(widget.duration ?? const Duration());
          if (widget.isAutoPlay) {
            controller?.play();
          }
        });
    } else {
      controller = VideoPlayerController.network(widget.url,
          httpHeaders: widget.token != null
              ? {
                  'Authorization': 'Bearer ${widget.token}',
                }
              : {})
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) {
          controller?.seekTo(widget.duration ?? const Duration());
          if (widget.isAutoPlay) {
            controller?.play();
          }
        });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: null,
        backgroundColor: AppColor.black001,
        body: VideoPlayerBothWidget(
          controller: controller,
          aspectRatio: widget.aspectRatio,
          commentIcon: widget.commentIcon,
          likeIcon: widget.likeIcon,
          titleWidget: widget.titleWidget,
          quizWidget: widget.quizWidget,
          descriptionWidget: widget.descriptionWidget,
        ),
      );
}
