import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_images.dart';

import '../app_strings.dart';
import 'app_button.dart';

class NoDataAvailable extends StatelessWidget {
  final VoidCallback onPressed;

  const NoDataAvailable({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.imgNoDataFound),
        AppButton(
          txt: AppStrings.tapToReload,
          onPressed: onPressed,
          width: Get.width * 0.9,
        )
      ],
    );
  }
}
