import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_read_more_text.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';

class ItemPodCast extends StatelessWidget {
  final PodcastElement item;
  final VoidCallback onItemPressed;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;

  const ItemPodCast(
      {required this.item,
      required this.onItemPressed,
      required this.onCommentPressed,
      required this.onLikePressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onItemPressed,
        splashColor: Colors.white54,
        child: Column(
          children: [
            SizedBox(
              height: 16.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  height: 85.h,
                  width: 85.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(5.r)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // child: Icon(
                  //   Icons.mic,
                  //   size: 36.0.r,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnailPath,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
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
                      child: Icon(
                        Icons.mic,
                        size: 36.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.mic,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppText(
                            text: item.podcastTitle,
                            textSize: 15.sp,
                            color: AppColor.black,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            lineHeight: 1.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      CustomReadMoreText(
                        value: item.podcastDescription.trim(),
                        padding: EdgeInsets.zero,
                        moreTextColor: AppColor.lightNavyBlue,
                        textColor: AppColor.black,
                      ),
                      // AppText(
                      //   text: item.podcastDescription,
                      //   textSize: 15.sp,
                      //   color: AppColor.black,
                      //   maxLines: 1,
                      //   textAlign: TextAlign.start,
                      //   overflow: TextOverflow.ellipsis,
                      //   lineHeight: 1.3,
                      //   fontWeight: FontWeight.w500,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: onLikePressed,
                  icon: SvgPicture.asset(
                    AppImages.iconHeart,
                    color: item.hasLiked ? AppColor.red : AppColor.black,
                    height: 24.r,
                  ),
                ),
                IconButton(
                  onPressed: onCommentPressed,
                  icon: SvgPicture.asset(
                    AppImages.iconChat,
                    color: AppColor.black,
                    height: 24.r,
                  ),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: onItemPressed,
                  icon: Icon(
                    Icons.play_circle,
                    size: 28.r,
                  ),
                ),
              ],
            ),
            Divider(
              height: 1.h,
            ),
          ],
        ),
      ),
    );
  }
}
