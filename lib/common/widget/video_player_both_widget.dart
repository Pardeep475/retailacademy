import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../app_color.dart';
import 'advanced_overlay_widget.dart';

class VideoPlayerBothWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final double aspectRatio;
  final Widget? commentIcon;
  final Widget? likeIcon;
  final Widget? titleWidget;
  final Widget? descriptionWidget;

  const VideoPlayerBothWidget({
    Key? key,
    required this.controller,
    required this.aspectRatio,
    this.commentIcon,
    this.likeIcon,
    this.titleWidget,
    this.descriptionWidget,
  }) : super(key: key);

  @override
  _VideoPlayerBothWidgetState createState() => _VideoPlayerBothWidgetState();
}

class _VideoPlayerBothWidgetState extends State<VideoPlayerBothWidget> {
  Orientation? target;

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    NativeDeviceOrientationCommunicator()
        .onOrientationChanged(useSensor: true)
        .listen((event) {
      final isPortrait = event == NativeDeviceOrientation.portraitUp;
      final isLandscape = event == NativeDeviceOrientation.landscapeLeft ||
          event == NativeDeviceOrientation.landscapeRight;
      final isTargetPortrait = target == Orientation.portrait;
      final isTargetLandscape = target == Orientation.landscape;

      if (isPortrait && isTargetPortrait || isLandscape && isTargetLandscape) {
        target = null;
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          Duration? position = await widget.controller?.position;
          Get.back(result: position);
          return true;
        },
        child: widget.controller != null &&
                widget.controller!.value.isInitialized
            ? Container(
                color: AppColor.black001,
                alignment: Alignment.center,
                child: buildVideo())
            : const Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
              )),
      );

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          setOrientation(isPortrait);

          return Stack(
            fit: /*isPortrait ? StackFit.loose : */ StackFit.expand,
            children: <Widget>[
              buildVideoPlayer(isPortrait),
              Positioned.fill(
                child: AdvancedOverlayWidget(
                    controller: widget.controller,
                    commentIcon: widget.commentIcon,
                    likeIcon: widget.likeIcon,
                    titleWidget: widget.titleWidget,
                    descriptionWidget: widget.descriptionWidget,
                    isCrossIconShown: true,
                    onClickedFullScreen: () {
                      target = isPortrait
                          ? Orientation.landscape
                          : Orientation.portrait;

                      if (isPortrait) {
                        AutoOrientation.landscapeRightMode();
                      } else {
                        AutoOrientation.portraitUpMode();
                      }
                    },
                    onBackPressed: () async {
                      target = isPortrait
                          ? Orientation.landscape
                          : Orientation.portrait;

                      if (isPortrait) {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                        ]);
                        Get.back();
                      } else {
                        AutoOrientation.portraitUpMode();
                      }
                    },
                    isPortrait: isPortrait),
              ),
            ],
          );
        },
      );

  Widget buildVideoPlayer(bool isPortrait) {
    final video = SizedBox.expand(
      child: FittedBox(
        fit: isPortrait ? BoxFit.cover : BoxFit.contain,
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.controller!.value.size.width,
          height: widget.controller!.value.size.height,
          child: VideoPlayer(widget.controller!),
        ),
      ),
    );
    // final video = AspectRatio(
    //   aspectRatio: /*isPortrait
    //       ? widget.aspectRatio
    //       :*/ widget.controller!.value.aspectRatio,
    //   child: VideoPlayer(widget.controller!),
    // );

    return buildFullScreen(child: video);
  }

  Widget buildFullScreen({
    required Widget child,
  }) {
    // final size = widget.controller!.value.size;
    /*   final width = size.width ?? 0;
    final height = size.height ?? 0;*/

    return Container(
        alignment: Alignment.center, width: Get.width, child: child);

    /*return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );*/
  }
}
