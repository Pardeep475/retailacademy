import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/app_images.dart';
import '../../../common/utils.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/knowledge/knowledge_api_response.dart';

class ItemKnowledge extends StatelessWidget {
  final KnowledgeElement item;
  final VoidCallback onPressed;

  const ItemKnowledge({required this.item, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Utils.hexToColor(item.colourCode),
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white54,
          borderRadius: BorderRadius.circular(10.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    AppText(
                      text: item.folderName,
                      textSize: 20.sp,
                      maxLines: 2,
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppText(
                      text: item.folderDescription,
                      textSize: 16.sp,
                      maxLines: 4,
                      color: AppColor.white,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              CachedNetworkImage(
                imageUrl: item.thumbnailImage,
                width: 150.w,
                height: 150.h,
                imageBuilder: (context, imageProvider) => Container(
                  width: 150.w,
                  height: 150.h,
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
                    width: 150.w,
                    height: 150.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
