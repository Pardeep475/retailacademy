import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';

class ItemPodCast extends StatelessWidget {
  final PodcastElement item;
  final VoidCallback onItemPressed;

  const ItemPodCast({required this.item, required this.onItemPressed, Key? key})
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
            SizedBox(height: 16.w,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16.w,),
                Container(
                  height: 85.h,
                  width: 85.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Icon(
                    Icons.mic,
                    size: 36.0.r,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      AppText(
                        text: item.podcastDescription,
                        textSize: 15.sp,
                        color: AppColor.black,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        lineHeight: 1.3,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w,),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    // _controller.likeOrDislikeBlogApi(
                    //     blogId: widget.item.blogId);
                  },
                  icon: SvgPicture.asset(
                    AppImages.iconHeart,
                    color:AppColor.black,
                    height: 24.r,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppImages.iconChat,
                    color: AppColor.black,
                    height: 24.r,
                  ),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.play_circle,size: 28.r,),
                ),
              ],
            ),
            Divider(height: 1.h,),
          ],
        ),
      ),
    );
  }
}
