import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:retail_academy/common/app_images.dart';
import 'package:retail_academy/common/widget/app_text.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/encrypt_data.dart';
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
               CustomAppBar(
                title: AppStrings.infoSessions,
              ),
              Expanded(
                child: GestureDetector(onTap:(){
                  EncryptData.decryptAES(value: 'kj');
                },child: Image.asset(AppImages.imgInfoSessionBackground)),
              ),
              Obx(() {
                if (!_controller.status.value) {
                  return const SizedBox();
                }
                if (_controller.meetingTitle.isNotEmpty) {
                  return AppText(
                    text:
                        '${AppStrings.title} ${_controller.meetingTitle.value}',
                    textSize: 25.sp,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  );
                }
                return const SizedBox();
              }),
              Obx(() {
                if (!_controller.status.value) {
                  return const SizedBox();
                }
                if (_controller.meetingTitle.isNotEmpty) {
                  return SizedBox(
                    height: 16.h,
                  );
                }
                return const SizedBox.shrink();
              }),
              Obx(() {
                if (!_controller.status.value) {
                  return const SizedBox();
                }
                if (_controller.zoomMeetingStartDate.isNotEmpty &&
                    _controller.zoomMeetingEndDate.isNotEmpty) {
                  if (Utils.infoSessionCompareDates(
                      value: _controller.zoomMeetingEndDate.value)) {
                    return AppText(
                      text:
                          "${AppStrings.pastSession} ${Utils.infoSessionDateFormat(selectedDate: _controller.zoomMeetingEndDate.value)}",
                      textSize: 25.sp,
                      lineHeight: 1.5,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    );
                  }
                  return AppText(
                    text:
                        "${AppStrings.nextSession} ${Utils.infoSessionDateFormat(selectedDate: _controller.zoomMeetingStartDate.value)}",
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
                if (Utils.infoSessionCompareDates(
                    value: _controller.zoomMeetingEndDate.value)) {
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
                } else if (_controller.meetingRecordedUrl.isNotEmpty) {
                  return AppButton(
                    txt: AppStrings.playRecording,
                    onPressed: () {
                      // need to dycript password
                      _controller.playRecording(
                          context: context,
                          recordedMeetingUrl:
                              _controller.meetingRecordedUrl.value,
                          recordedMeetingPassword:
                              _controller.playUrlPassword.value);
                    },
                    width: Get.width * 0.9,
                  );
                } else if (_controller.zoomMeetingID.isNotEmpty) {
                  return AppButton(
                    txt: AppStrings.join,
                    onPressed: () {
                      _controller.joinMeeting(
                          context: context,
                          meetingId: _controller.zoomMeetingID.value,
                          meetingPassword:
                              _controller.zoomMeetingPassword.value);
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
