import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';

class ItemComment extends StatelessWidget {
  const ItemComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white54,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.white),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: EdgeInsets.all(12.r),
                height: 56.h,
                width: 56.w,
                child: SvgPicture.asset(
                  AppImages.iconUserImagePlaceHolder,
                  color: AppColor.black,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: 'item.activityStreamText',
                    textSize: 16.sp,
                    maxLines: 1,
                    color: AppColor.white,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AppText(
                    text: 'item.activityStreamText',
                    textSize: 16.sp,
                    maxLines: 1,
                    color: AppColor.white,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
