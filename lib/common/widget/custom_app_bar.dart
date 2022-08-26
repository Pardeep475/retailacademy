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

  const CustomAppBar(
      {required this.title,
      this.onBackPressed,
      this.points = '00',
      this.isSearchButtonVisible = false,
      this.isBackButtonVisible = false,
      this.isNotificationButtonVisible = false,
      this.searchController,
      this.isSearchWidgetVisible = false,
      this.onSearchChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight *
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
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.black,
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
                  isNotificationButtonVisible
                      ? const SizedBox()
                      : AppText(
                          text:
                              "${AppStrings.pointConstant} ${AppStrings.points}",
                          textSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  isNotificationButtonVisible
                      ? const SizedBox()
                      : isSearchButtonVisible
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search_sharp,
                                color: AppColor.black,
                              ),
                            )
                          : const SizedBox(),
                  isNotificationButtonVisible
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            color: AppColor.black,
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
        AppText(
          text: title,
          textSize: 25.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
