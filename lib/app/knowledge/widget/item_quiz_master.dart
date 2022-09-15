import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/widget/app_text.dart';

class ItemQuizMaster extends StatelessWidget {
  const ItemQuizMaster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColor.pinkKnowledge),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          const Icon(Icons.file_copy,color: AppColor.white,),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: AppText(
              text:
                  'In publishing and graphic design, Lorem ipsum is a placeholder text commonly',
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
    );
  }
}
