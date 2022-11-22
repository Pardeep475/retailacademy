import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/knowledge/whats_hot_blog_response.dart';

class ItemWhatsHotBlog extends StatelessWidget {
  final BlogCategoryElement item;
  final VoidCallback? onItemClick;

  const ItemWhatsHotBlog({Key? key, required this.item, this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: item.color,
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onItemClick,
          splashColor: Colors.white54,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: Get.width,
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: item.thumbnailImage,
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
                    child: Image.asset(
                      AppImages.imgNoImageFound,
                      color: AppColor.black,
                      height: 50.h,
                      width: 50.h,
                    ),
                  ),
                ),
              ),
              AppText(
                text: item.blogCategory,
                textSize: 20.sp,
                textAlign: TextAlign.center,
                color: AppColor.black,
                maxLines: 2,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
