import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;
  final EdgeInsetsGeometry? padding;
  final double aspectRatio;
  final bool showControllers;

  const VideoItems({
    required this.videoPlayerController,
    this.padding,
    this.looping = true,
    this.autoplay = true,
    this.showControllers = false,
    this.aspectRatio = 8 / 10,
    Key? key,
  }) : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late ChewieController _chewieController;
  var isInitialize = false.obs;

  @override
  void initState() {
    widget.videoPlayerController.initialize().then((value) {
      isInitialize.value = true;
      debugPrint('VIdeoInitialize:----   ${isInitialize.value}');
      _chewieController.play();
    });
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      showControls: widget.showControllers,
      showOptions: false,
      showControlsOnInitialize: false,
      allowFullScreen: widget.showControllers,
      allowMuting: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.blueAccent, fontSize: 20.sp),
          ),
        );
      },
    );
    _chewieController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Chewie(
        key: UniqueKey(),
        controller: _chewieController,

      ),
    );
    // return Obx(() {
    //   return isInitialize.value
    //       ? Padding(
    //           padding: widget.padding ?? const EdgeInsets.all(8.0),
    //           child: Chewie(
    //             controller: _chewieController,
    //           ),
    //         )
    //       : Container(
    //           color: Colors.transparent,
    //           width: Get.width,
    //           height: Get.height,
    //           child: const Center(
    //             child: CircularProgressIndicator(
    //               valueColor:
    //                   AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
    //             ),
    //           ),
    //         );
    // });
  }
}
