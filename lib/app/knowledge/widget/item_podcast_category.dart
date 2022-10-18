import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/podcast/pod_cast_category_response.dart';

class ItemPodCastCategory extends StatelessWidget {
  final PodCastCategoryElement item;
  final VoidCallback onPressed;

  const ItemPodCastCategory(
      {required this.item, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      margin: EdgeInsets.only(right: 10.w),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white54,
          child: Column(
            children: [
              Container(
                height: 100.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(5.r)),
                margin: EdgeInsets.only(bottom: 10.h),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  imageUrl: item.categoryThumbnailImage,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
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
                    child: Icon(
                      Icons.mic,
                      size: 36.0.r,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.mic,
                    color: Colors.lightBlueAccent,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: AppText(
                      text: item.podCastCategoryTitle,
                      textSize: 15.sp,
                      color: AppColor.black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      lineHeight: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}