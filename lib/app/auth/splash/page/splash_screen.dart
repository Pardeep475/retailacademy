import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../../common/app_images.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController _controller = Get.isRegistered<SplashController>()
      ? Get.find<SplashController>()
      : Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          AppImages.imgLogo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
