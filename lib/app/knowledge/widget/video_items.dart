// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../common/app_color.dart';
//
// class VideoItems extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
//   final bool looping;
//   final bool autoplay;
//   final EdgeInsetsGeometry? padding;
//   final double aspectRatio;
//   final bool showControllers;
//   final bool allowFullScreen;
//   final bool allowMuting;
//   final bool showOptions;
//   final bool showControlsOnInitialize;
//
//   const VideoItems({
//     required this.videoPlayerController,
//     this.padding,
//     this.looping = true,
//     this.autoplay = true,
//     this.showControllers = true,
//     this.allowFullScreen = true,
//     this.allowMuting = true,
//     this.showOptions = true,
//     this.showControlsOnInitialize = false,
//     this.aspectRatio = 7 / 10,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _VideoItemsState createState() => _VideoItemsState();
// }
//
// class _VideoItemsState extends State<VideoItems> {
//   ChewieController? _chewieController;
//   var isInitialize = false.obs;
//
//   @override
//   void initState() {
//     // _chewieController.addListener(() {});
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//       widget.videoPlayerController.initialize().then((value) {
//         isInitialize.value = true;
//         debugPrint('VIdeoInitialize:----   ${isInitialize.value}');
//         if (_chewieController != null) {
//           _chewieController!.play();
//         }
//       });
//       _chewieController = ChewieController(
//         videoPlayerController: widget.videoPlayerController,
//         aspectRatio: widget.videoPlayerController.value.aspectRatio,
//         autoInitialize: true,
//         autoPlay: widget.autoplay,
//         looping: widget.looping,
//         showControls: widget.showControllers,
//         showOptions: widget.showOptions,
//         showControlsOnInitialize: widget.showControlsOnInitialize,
//         allowFullScreen: widget.allowFullScreen,
//         allowMuting: widget.allowMuting,
//         materialProgressColors: ChewieProgressColors(
//           playedColor: Colors.red.shade500,
//           bufferedColor: Colors.red,
//           handleColor: Colors.red,
//           backgroundColor: Colors.red.shade100,
//         ),
//         zoomAndPan: true,
//         // customControls: ,
//         overlay: const SizedBox(
//           height: 50,
//         ),
//         placeholder: Container(
//           color: Colors.transparent,
//           width: Get.width,
//           height: Get.height,
//           child: const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
//             ),
//           ),
//         ),
//         errorBuilder: (context, errorMessage) {
//           return Center(
//             child: Text(
//               errorMessage,
//               style: TextStyle(color: Colors.blueAccent, fontSize: 20.sp),
//             ),
//           );
//         },
//       );
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     // widget.videoPlayerController.dispose();
//     if (_chewieController != null) {
//       _chewieController!.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('value:-   VIDEO_ITEM');
//     return Container(
//       color: Colors.black,
//       padding: widget.padding ?? const EdgeInsets.all(8.0),
//       child: _chewieController == null
//           ? const SizedBox()
//           : Chewie(
//               key: UniqueKey(),
//               controller: _chewieController!,
//             ),
//     );
//     // return Obx(() {
//     //   return isInitialize.value
//     //       ? Padding(
//     //           padding: widget.padding ?? const EdgeInsets.all(8.0),
//     //           child: Chewie(
//     //             controller: _chewieController,
//     //           ),
//     //         )
//     //       : Container(
//     //           color: Colors.transparent,
//     //           width: Get.width,
//     //           height: Get.height,
//     //           child: const Center(
//     //             child: CircularProgressIndicator(
//     //               valueColor:
//     //                   AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
//     //             ),
//     //           ),
//     //         );
//     // });
//   }
// }
