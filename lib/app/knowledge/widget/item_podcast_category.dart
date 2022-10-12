import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/widget/app_text.dart';
import '../../../network/modal/podcast/pod_cast_category_response.dart';

class ItemPodCastCategory extends StatelessWidget {
  final PodCastCategoryElement item;
  final VoidCallback onPressed;
  const ItemPodCastCategory({required this.item,required this.onPressed,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      margin: EdgeInsets.only(right: 10.w),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              height: 100.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(5.r)),
              margin: EdgeInsets.only(bottom: 10.h),
              child:  Icon(Icons.mic,size: 36.0.r,),
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
                    text: 'Continue Listening',
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
    );
  }
}
