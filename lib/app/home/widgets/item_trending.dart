import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/trending/trending_response.dart';

class ItemTrending extends StatelessWidget {
  final ActivityStream item;
  final VoidCallback onLikeButtonPressed;

  const ItemTrending(
      {required this.item, required this.onLikeButtonPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          text: item.userName,
          textSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 10.h),
        CachedNetworkImage(
          imageUrl: item.activityImage,
          height: Get.height * 0.4,
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
            decoration: const BoxDecoration(color: AppColor.grey),
            child: Image.asset(
              AppImages.imgNoImageFound,
              height: Get.height * 0.15,
              color: AppColor.black,
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
                color: item.hasLiked ? AppColor.red :AppColor.black,

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
            )
          ],
        ),
        SizedBox(height: 5.h),
        AppText(
          text: item.activityStreamText,
          textSize: 16.sp,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
