import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retail_academy/common/utils.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/notification/notification_list_response.dart';

class ItemNotification extends StatelessWidget {
  final NotificationElement item;
  final VoidCallback onPressed;

  const ItemNotification(
      {required this.item, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff5266CB),
          borderRadius: BorderRadius.circular(5.h),
        ),
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.iconReels,
              color: AppColor.white,
              height: 60,
              width: 45,
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: item.moduleName.notificationTypeValue,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  AppText(
                    text: item.message,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
