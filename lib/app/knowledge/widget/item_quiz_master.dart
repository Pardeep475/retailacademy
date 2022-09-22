import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/widget/app_text.dart';
import '../../../network/modal/knowledge/quiz_category_response.dart';

class ItemQuizMaster extends StatelessWidget {
  final QuizCategoryElement item;
  final VoidCallback onItemPressed;
  final Color color;

  const ItemQuizMaster(
      {required this.item,
      required this.onItemPressed,
      this.color = AppColor.pinkKnowledge,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: color),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onItemPressed,
          splashColor: Colors.white54,
          borderRadius: BorderRadius.circular(5.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          item.hasViewed ? Colors.transparent : AppColor.red),
                ),
                SizedBox(
                  width: 8.w,
                ),
                const Icon(
                  Icons.file_copy,
                  color: AppColor.white,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: AppText(
                    text: item.categoryName + '\n',
                    textSize: 18.sp,
                    color: AppColor.white,
                    maxLines: 2,
                    lineHeight: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
