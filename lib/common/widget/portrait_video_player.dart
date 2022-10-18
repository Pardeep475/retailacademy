import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../app_color.dart';
import 'advanced_overlay_widget.dart';
import 'portrait_landscape_player_page.dart';

class PortraitVideoPlayer extends StatefulWidget {
  final String url;
  final String? token;
  final String? filePath;
  final bool isAutoPlay;
  final double aspectRatio;
  final Duration? duration;
  final Function(Duration value)? onDurationChanged;
  final Widget? commentIcon;
  final Widget? likeIcon;
  final Widget? titleWidget;
  final Widget? descriptionWidget;

  const PortraitVideoPlayer(
      {Key? key,
      required this.url,
      this.token,
      this.filePath,
      this.isAutoPlay = true,
      this.duration,
      this.onDurationChanged,
      this.commentIcon,
      this.likeIcon,
      this.titleWidget,
      this.descriptionWidget,
      this.aspectRatio = 9 / 16})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PortraitVideoPlayerState();
}

class _PortraitVideoPlayerState extends State<PortraitVideoPlayer> {
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
          controller?.addListener(() {
            if (widget.onDurationChanged != null) {
              widget.onDurationChanged!(
                  controller?.value.position ?? const Duration());
            }
            debugPrint(
                'CUSTOM_LISTENER:---- --  ${controller?.value.position}');
          });
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

          controller?.addListener(() {
            if (widget.onDurationChanged != null) {
              widget.onDurationChanged!(
                  controller?.value.position ?? const Duration());
            }
            debugPrint(
                'CUSTOM_LISTENER:---- --  ${controller?.value.position}');
          });
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
  Widget build(BuildContext context) {
    return VideoPlayerPortraitWidget(
      controller: controller,
      url: widget.url,
      aspectRatio: widget.aspectRatio,
      commentIcon: widget.commentIcon,
      likeIcon: widget.likeIcon,
      titleWidget: widget.titleWidget,
      descriptionWidget: widget.descriptionWidget,
    );
  }
}

class VideoPlayerPortraitWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final double aspectRatio;
  final String url;
  final Widget? commentIcon;
  final Widget? likeIcon;
  final Widget? titleWidget;
  final Widget? descriptionWidget;

  const VideoPlayerPortraitWidget({
    Key? key,
    required this.controller,
    required this.aspectRatio,
    required this.url,
    this.commentIcon,
    this.likeIcon,
    this.titleWidget,
    this.descriptionWidget,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPlayerPortraitWidgetState();
}

class _VideoPlayerPortraitWidgetState extends State<VideoPlayerPortraitWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          return true;
        },
        child:
            widget.controller != null && widget.controller!.value.isInitialized
                ? Container(
                    color: AppColor.black001,
                    alignment: Alignment.center,
                    child: buildVideo())
                : const Center(child: CircularProgressIndicator()),
      );

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(true),
          Positioned.fill(
            child: AdvancedOverlayWidget(
                controller: widget.controller,
                commentIcon: widget.commentIcon,
                likeIcon: widget.likeIcon,
                titleWidget: widget.titleWidget,
                descriptionWidget: widget.descriptionWidget,
                onClickedFullScreen: () async {
                  Duration? position = await widget.controller?.position;
                  Get.to(
                    PortraitLandscapePlayerPage(
                      url: widget.url,
                      duration: position,
                      commentIcon: widget.commentIcon,
                      likeIcon: widget.likeIcon,
                      titleWidget: widget.titleWidget,
                      descriptionWidget: widget.descriptionWidget,
                    ),
                  )?.then((value) {
                    if (value != null) {
                      widget.controller?.seekTo(value as Duration);
                      widget.controller?.play();
                    }
                  });
                },
                isPortrait: true),
          ),
        ],
      );

  Widget buildVideoPlayer(bool isPortrait) {

    final video = SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: widget.controller!.value.size.width ?? 0,
          height: widget.controller!.value.size.height ?? 0,
          child: VideoPlayer(widget.controller!),
        ),
      ),
    );

    // final video = AspectRatio(
    //   aspectRatio: isPortrait
    //       ? widget.aspectRatio
    //       : widget.controller!.value.aspectRatio,
    //   child: VideoPlayer(widget.controller!),
    // );

    return buildFullScreen(child: video);
  }

  Widget buildFullScreen({
    required Widget child,
  }) {
    return Container(
        alignment: Alignment.center, width: Get.width, child: child);
  }
}
