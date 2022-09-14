import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
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
              SizedBox(width: Get.width,),
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
