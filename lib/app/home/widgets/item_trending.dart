import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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

   const ItemTrending(
      {required this.item,
      required this.onLikeButtonPressed,
      required this.onCommentButtonPressed,
      required this.onItemPressed,
      Key? key})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => FunFactsAndMasterClassDetailScreen(
                fileId: item.contentFileId.toString(),
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
                child: PortraitVideoPlayer(
                  url: item.activityImage,
                  isAutoPlay: false,
                  onFullScreen: onItemPressed,
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
