import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/widget/app_text.dart';

import '../app_color.dart';
import '../app_strings.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final String points;
  final bool isSearchButtonVisible;
  final bool isBackButtonVisible;
  final bool isNotificationButtonVisible;
  final bool isSearchWidgetVisible;
  final Function(String)? onSearchChanged;
  final TextEditingController? searchController;
  final bool isIconsTitle;
  final bool isVideoComponent;

  const CustomAppBar(
      {required this.title,
      this.onBackPressed,
      this.points = '00',
      this.isSearchButtonVisible = false,
      this.isBackButtonVisible = false,
      this.isNotificationButtonVisible = false,
      this.searchController,
      this.isSearchWidgetVisible = false,
      this.isIconsTitle = false,
      this.isVideoComponent = false,
      this.onSearchChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height:  kToolbarHeight *
                  (isBackButtonVisible ||
                          isNotificationButtonVisible ||
                          isSearchButtonVisible
                      ? 0.7
                      : 0.8),
        ),
        Row(
          children: [
            isBackButtonVisible
                ? IconButton(
                    onPressed: onBackPressed ?? () => Get.back(),
                    splashColor: Colors.white54,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: isVideoComponent ? AppColor.white : AppColor.black,
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isNotificationButtonVisible || isVideoComponent
                      ? const SizedBox()
                      : AppText(
                          text:
                              "${AppStrings.pointConstant} ${AppStrings.points}",
                          textSize: 18.sp,
                          color: isVideoComponent
                              ? AppColor.white
                              : AppColor.black,
                          fontWeight: FontWeight.w600,
                        ),
                  isNotificationButtonVisible
                      ? const SizedBox()
                      : isSearchButtonVisible
                          ? IconButton(
                              onPressed: () {},
                              splashColor: Colors.white54,
                              icon: Icon(
                                Icons.search_sharp,
                                color: isVideoComponent
                                    ? AppColor.white
                                    : AppColor.black,
                              ),
                            )
                          : const SizedBox(),
                  isNotificationButtonVisible
                      ? IconButton(
                          onPressed: () {},
                          splashColor: Colors.white54,
                          icon: Icon(
                            Icons.notifications_none_outlined,
                            color: isVideoComponent
                                ? AppColor.white
                                : AppColor.black,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            SizedBox(
              width: isSearchButtonVisible || isNotificationButtonVisible
                  ? 0
                  : 20.w,
            ),
          ],
        ),
        SizedBox(
          height: isBackButtonVisible ? 0 : 10.h,
        ),
        isIconsTitle
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mic,
                    color: isVideoComponent ? AppColor.white : AppColor.black,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppText(
                    text: title,
                    textSize: 25.sp,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    color: isVideoComponent ? AppColor.white : AppColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              )
            : AppText(
                text: title,
                textSize: 25.sp,
                maxLines: 2,
                color: isVideoComponent ? AppColor.white : AppColor.black,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
