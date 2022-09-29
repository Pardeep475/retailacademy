import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/utils.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../knowledge/widget/video_items.dart';

class FullScreenImageAndVideoScreen extends StatefulWidget {
  final String url;
  final String title;

  const FullScreenImageAndVideoScreen(
      {required this.title, required this.url, Key? key})
      : super(key: key);

  @override
  State<FullScreenImageAndVideoScreen> createState() =>
      _FullScreenImageAndVideoScreenState();
}

class _FullScreenImageAndVideoScreenState
    extends State<FullScreenImageAndVideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: widget.title,
            isBackButtonVisible: true,
            isSearchButtonVisible: false,
            isNotificationButtonVisible: true,
            onBackPressed: () {
              Get.back();
            },
          ),
          Expanded(child: Utils.isVideo(widget.url)
              ? VideoItems(
            videoPlayerController: VideoPlayerController.network(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4' /*widget.item.activityImage*/,
            ),
            key: UniqueKey(),
            padding: EdgeInsets.zero,
          )
              : PhotoView(
            imageProvider: NetworkImage(widget.url),
            backgroundDecoration:
            const BoxDecoration(color: AppColor.white),
            loadingBuilder: (context, event) => Container(
              color: Colors.transparent,
              width: Get.width,
              height: Get.height ,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
                ),
              ),
            ),
            errorBuilder: (context, error, stacktrace) => Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColor.grey),
              child: Image.asset(
                AppImages.imgNoImageFound,
                height: Get.height * 0.15,
                color: AppColor.black,
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
