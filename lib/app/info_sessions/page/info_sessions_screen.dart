import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:retail_academy/common/app_images.dart';
import 'package:retail_academy/common/widget/app_text.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/info_sessions_controller.dart';

class InfoSessionsScreen extends StatefulWidget {
  const InfoSessionsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfoSessionsScreenState();
}

class _InfoSessionsScreenState extends State<InfoSessionsScreen> {
  final InfoSessionsController _controller =
      Get.isRegistered<InfoSessionsController>()
          ? Get.find<InfoSessionsController>()
          : Get.put(InfoSessionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: AppStrings.infoSessions,
          ),
          Expanded(
            child: GestureDetector(
                onTap: () {
                  _controller.joinMeeting(
                      context: context,
                      userName: 'Mobisprint',
                      meetingId: '285 282 5120',
                      meetingPassword: 'XBt21M');
                },
                child: Image.asset(AppImages.imgInfoSessionBackground)),
          ),
          AppText(
            text: AppStrings.nextSession,
            textSize: 25.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 10.h,
          ),
          AppText(
            text: 'Monday XXXXXXXXXX\n7:00 PM',
            textSize: 25.sp,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: Get.height * 0.08,
          ),
        ],
      ),
    );
  }
}
