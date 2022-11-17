import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/utils.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/portrait_video_player.dart';
import '../../../common/widget/read_more_text.dart';
import '../../../network/modal/trending/trending_response.dart';
import '../../knowledge/page/fun_facts_and_master_class_detail_screen.dart';

class ItemTrending extends StatelessWidget {
  final ActivityStream item;
  final VoidCallback onLikeButtonPressed;
  final VoidCallback onCommentButtonPressed;
  final VoidCallback onItemPressed;

  ItemTrending(
      {required this.item,
      required this.onLikeButtonPressed,
      required this.onCommentButtonPressed,
      required this.onItemPressed,
      Key? key})
      : super(key: key);

  VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    debugPrint('IMAGE_IN_TENDING:---- -----     ${item.activityImage}');
    if (Utils.isVideo(item.activityImage)) {
      _controller = VideoPlayerController.network(item.activityImage);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => FunFactsAndMasterClassDetailScreen(
                fileId: item.contentFileId.toString(),
                quizId: 0,
                quizName: '',
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: AppText(
              text: item.contentFileName,
              textSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Utils.isVideo(item.activityImage)
            ? SizedBox(
                height: Get.height * 0.4,
                child: VisibilityDetector(
                  key: ObjectKey(item.activityStreamId),
                  onVisibilityChanged: (visibility) {
                    if (visibility.visibleFraction == 0 &&
                        _controller != null) {
                      // flickManager?.flickControlManager?.pause();//pausing  functionality
                      _controller?.pause();
                    }
                  },
                  child: PortraitVideoPlayer(
                    url: item.activityImage,
                    isAutoPlay: true,
                    onFullScreen: onItemPressed,
                    videoPlayerController: _controller,
                  ),
                ),
              )
            : GestureDetector(
                onTap: onItemPressed,
                child: CachedNetworkImage(
                  imageUrl: item.activityImage,
                  height: Get.height * 0.4,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      color: AppColor.commentBlack,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 36.r,
                        width: 36.r,
                        child: const CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColor.grey),
                    child: Image.asset(
                      AppImages.imgNoImageFound,
                      height: Get.height * 0.15,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
        SizedBox(height: 5.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: onLikeButtonPressed,
              icon: SvgPicture.asset(
                AppImages.iconHeart,
                color: item.hasLiked ? AppColor.red : AppColor.black,
                height: 24.r,
              ),
            ),
            IconButton(
              onPressed: onCommentButtonPressed,
              icon: SvgPicture.asset(
                AppImages.iconChat,
                color: AppColor.black,
                height: 24.r,
              ),
            )
          ],
        ),
        SizedBox(height: 5.h),
        ReadMoreText(
          item.activityStreamText,
          trimLines: 2,
          colorClickableText: AppColor.lightNavyBlue,
          trimMode: TrimMode.line,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              height: 1.6,
              color: AppColor.black),
          moreStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              height: 1.6,
              color: AppColor.lightNavyBlue),
          lessStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              height: 1.6,
              color: AppColor.lightNavyBlue),
        ),
        // AppText(
        //   text: item.activityStreamText,
        //   textSize: 16.sp,
        //   maxLines: 3,
        //   overflow: TextOverflow.ellipsis,
        //   fontWeight: FontWeight.w400,
        // ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
