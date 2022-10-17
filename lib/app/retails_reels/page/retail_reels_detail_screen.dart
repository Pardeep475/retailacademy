import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/portrait_video_player.dart';
import '../../../network/modal/retails_reels/retail_reels_list_response.dart';
import '../../comment/page/retail_reels_comment_screen.dart';
import '../controller/retail_reels_detail_controller.dart';

class RetailReelsDetailScreen extends StatefulWidget {
  final ReelElement item;
  final int categoryId;

  const RetailReelsDetailScreen(
      {required this.item, required this.categoryId, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RetailReelsDetailScreenState();
}

class _RetailReelsDetailScreenState extends State<RetailReelsDetailScreen> {
  final RetailReelsDetailController _controller =
      Get.isRegistered<RetailReelsDetailController>()
          ? Get.find<RetailReelsDetailController>()
          : Get.put(RetailReelsDetailController());

  // VideoPlayerController? videoPlayerController;
  // ChewieController? _chewieController;

  @override
  void initState() {
    _controller.hasLiked.value = widget.item.hasLiked;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.fetchWhatsHotContentApi(
          categoryId: widget.categoryId, reelId: widget.item.reelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("VideoUrl:-    ${widget.item.filePath}");
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: widget.item.reelName,
                isBackButtonVisible: true,
                isSearchButtonVisible: false,
                isNotificationButtonVisible: true,
              ),
              Expanded(
                child: Obx(() {
                  debugPrint(
                      'value:-   ${_controller.videoUrl.value}  ${_controller.refreshDuration.value}');
                  if (_controller.videoUrl.isEmpty) {
                    return const SizedBox();
                  }
                  return PortraitVideoPlayer(
                    url:
                        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                    aspectRatio: 2 / 3,
                    duration: _controller.refreshDuration.value,
                    onDurationChanged: (value) {
                      _controller.position = value;
                    },
                  );
                }),
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      _controller.likeOrDislikeRetailReelsApi(
                          reelId: widget.item.reelId);
                    },
                    icon: Obx(() {
                      return SvgPicture.asset(
                        AppImages.iconHeart,
                        color: _controller.hasLiked.value
                            ? AppColor.red
                            : AppColor.black,
                        height: 24.r,
                      );
                    }),
                  ),
                  IconButton(
                    onPressed: () => _commentButtonPressed(),
                    icon: SvgPicture.asset(
                      AppImages.iconChat,
                      color: AppColor.black,
                      height: 24.r,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
                child: Obx(() {
                  return AppText(
                    text: _controller.reelDescription.value,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    maxLines: 5,
                    lineHeight: 1.2,
                    textAlign: TextAlign.start,
                  );
                }),
              ),
            ],
          ),
          Obx(
            () => Positioned.fill(
              child: _controller.showLoader.value
                  ? Container(
                      color: Colors.transparent,
                      width: Get.width,
                      height: Get.height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.loaderColor),
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _commentButtonPressed() {
    Get.to(() => RetailReelsCommentScreen(
          title: widget.item.userName,
          hasLike: _controller.hasLiked.value,
          // itemMediaUrl: _controller.videoUrl.value,
          itemMediaUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          reelId: widget.item.reelId,
          position: _controller.position,
        ))?.then((value) {
      if (value != null) {
        if (value['LIKE'] != null) {
          _controller.hasLiked.value = value as bool;
        }
        debugPrint('PROGRESS_VALUE:--  ${value['POSITION'] as Duration}');
        _controller.position = value['POSITION'] as Duration;
        _controller.refreshDuration.value = value['POSITION'] as Duration;
      }
    });
  }

  @override
  void dispose() {
    // if (videoPlayerController != null) {
    //   videoPlayerController!.dispose();
    // }
    // if (_chewieController != null) {
    //   _chewieController!.dispose();
    // }
    super.dispose();
  }
}
