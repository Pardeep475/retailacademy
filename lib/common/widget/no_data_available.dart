import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_images.dart';

import '../app_strings.dart';
import 'app_button.dart';

class NoDataAvailable extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isButtonVisible;

  const NoDataAvailable(
      {required this.onPressed, this.isButtonVisible = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isButtonVisible
            ? Expanded(child: Image.asset(AppImages.imgNoDataFound))
            : Image.asset(AppImages.imgNoDataFound),
        Visibility(
          visible: isButtonVisible,
          child: AppButton(
            txt: AppStrings.tapToReload,
            onPressed: onPressed,
            width: Get.width * 0.9,
          ),
        )
      ],
    );
  }
}
