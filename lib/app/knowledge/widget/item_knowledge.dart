import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retail_academy/app/knowledge/modal/knowledge_entity.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/widget/app_text.dart';

class ItemKnowledge extends StatelessWidget {
  final KnowledgeEntity item;
  final VoidCallback onPressed;

  const ItemKnowledge({required this.item, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: EdgeInsets.only(bottom: 10.h),
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
                    AppText(
                      text: item.title,
                      textSize: 20.sp,
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppText(
                      text: item.description,
                      textSize: 16.sp,
                      color: AppColor.white,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              Image.asset(
                item.icon,
                width: 150.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
