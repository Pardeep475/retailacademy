import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:retail_academy/common/app_images.dart';
import 'package:retail_academy/common/widget/app_text.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/app_button.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.fetchInfoSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const CustomAppBar(
                title: AppStrings.infoSessions,
              ),
              Expanded(
                child: Image.asset(AppImages.imgInfoSessionBackground),
              ),
              Obx(() {
                if (!_controller.status.value) {
                  return const SizedBox();
                }
                if (_controller.zoomMeetingStartDate.isNotEmpty) {
                  return AppText(
                    text: AppStrings.nextSession,
                    textSize: 25.sp,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  );
                }
                return const SizedBox();
              }),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                if (!_controller.status.value) {
                  return const SizedBox();
                }

                if (_controller.zoomMeetingStartDate.isNotEmpty) {
                  return AppText(
                    text: Utils.infoSessionDateFormat(
                        selectedDate: _controller.zoomMeetingStartDate.value),
                    textSize: 25.sp,
                    lineHeight: 1.5,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  );
                }
                return const SizedBox();
              }),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                if (!_controller.status.value) {
                  return const SizedBox();
                }
                if (!_controller.registrationStatus.value) {
                  return AppButton(
                    txt: AppStrings.register,
                    onPressed: () {
                      _controller.fetchInfoSessionRegistration();
                    },
                    width: Get.width * 0.9,
                  );
                } else if (!_controller.registrationStatus.value &&
                    _controller.meetingRecordedUrl.isNotEmpty) {
                  return AppButton(
                    txt: AppStrings.playRecording,
                    onPressed: () {
                      // need to dycript password
                      _controller.joinMeeting(
                          context: context,
                          meetingId: _controller.meetingRecordedUrl.value,
                          meetingPassword: '');
                    },
                    width: Get.width * 0.9,
                  );
                } else if (!_controller.registrationStatus.value &&
                    _controller.zoomMeetingID.isNotEmpty) {
                  return AppButton(
                    txt: AppStrings.join,
                    onPressed: () {
                      _controller.joinMeeting(
                          context: context,
                          meetingId: _controller.zoomMeetingID.value,
                          meetingPassword: '');
                    },
                    width: Get.width * 0.9,
                  );
                }
                return const SizedBox();
              }),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
          Obx(
            () => Positioned.fill(
              child: _controller.showLoader.value ||
                      _controller.showLoaderRegistration.value
                  ? Container(
                      color: Colors.transparent,
                      width: Get.width,
                      height: Get.height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.loaderColor),
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
