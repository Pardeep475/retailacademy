import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../app_color.dart';
import 'advanced_overlay_widget.dart';

class PortraitVideoPlayer extends StatefulWidget {
  final String url;
  final String? token;
  final String? filePath;
  final bool isAutoPlay;
  final double aspectRatio;
  final VoidCallback onFullScreen;
  final VideoPlayerController? videoPlayerController;

  const PortraitVideoPlayer(
      {Key? key,
      required this.url,
      required this.onFullScreen,
      this.token,
      this.filePath,
      this.isAutoPlay = true,
      this.videoPlayerController,
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
    debugPrint('URL_VIDEO:--   ${widget.url}');
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    if (widget.videoPlayerController != null) {
      controller = widget.videoPlayerController;
      controller?.addListener(() => setState(() {}));
      controller?.setLooping(false);
      controller?.initialize().then((_) {
        debugPrint('CUSTOM_LISTENER:---- --  ${controller?.value.position}');
        controller?.seekTo(const Duration());
        if (widget.isAutoPlay) {
          controller?.play();
          controller?.setVolume(0);
        } else {
          controller?.pause();
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
          controller?.seekTo(const Duration());
          if (widget.isAutoPlay) {
            controller?.play();
            controller?.setVolume(0);
          } else {
            controller?.pause();
          }

          controller?.addListener(() {
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
      onPressed: widget.onFullScreen,
      aspectRatio: widget.aspectRatio,
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
  final VoidCallback onPressed;

  const VideoPlayerPortraitWidget({
    Key? key,
    required this.controller,
    required this.aspectRatio,
    required this.url,
    this.commentIcon,
    this.likeIcon,
    this.titleWidget,
    required this.onPressed,
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
                isList: true,
                onClickedFullScreen: widget.onPressed,
                isPortrait: true),
          ),
        ],
      );

  Widget buildVideoPlayer(bool isPortrait) {
    final video = SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: widget.controller!.value.size.width,
          height: widget.controller!.value.size.height,
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
