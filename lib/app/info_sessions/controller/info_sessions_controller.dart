import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/encrypt_data.dart';
import 'package:retail_academy/network/modal/base/base_response.dart';
import 'package:retail_academy/network/modal/info_session/info_session_response.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/info_session/info_session_register_response.dart';
import '../../../network/modal/info_session/info_session_registration_request.dart';
import '../page/recorded_meeting_screen.dart';

class InfoSessionsController extends GetxController {
  var showLoader = true.obs;
  var showLoaderRegistration = false.obs;
  late Timer timer;

  var registrationStatus = false.obs;
  var zoomMeetingID = ''.obs;
  var zoomMeetingPassword = ''.obs;
  var zoomMeetingStartDate = ''.obs;
  var zoomMeetingEndDate = ''.obs;
  var meetingRecordedUrl = ''.obs;
  var playUrlPassword = ''.obs;
  var meetingTitle = ''.obs;

  var status = false.obs;

  static const platform =
      MethodChannel('application.raybiztech.retailacademy/ZOOM_INTEGRATION');

  @override
  void onInit() {
    super.onInit();
    Utils.logger.e("on init");
  }

  @override
  void onReady() {
    super.onReady();
    Utils.logger.e("on ready");
  }

  @override
  void onClose() {
    super.onClose();
    Utils.logger.e("on close");
  }

  Future fetchInfoSession() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.getInfoSession(
          userId: userId,
        );
        if (response != null) {
          InfoSessionResponse infoSessionResponse =
              (response as InfoSessionResponse);
          status.value = infoSessionResponse.status;
          if (infoSessionResponse.status) {
            registrationStatus.value = infoSessionResponse.registrationStatus;
            zoomMeetingID.value = infoSessionResponse.webinarId;
            zoomMeetingPassword.value = infoSessionResponse.password;
            zoomMeetingStartDate.value =
                infoSessionResponse.zoomMeetingStartDate;
            zoomMeetingEndDate.value = infoSessionResponse.zoomMeetingEndDate;
            meetingRecordedUrl.value = infoSessionResponse.meetingRecordedUrl;
            playUrlPassword.value = infoSessionResponse.playUrlPassword;
            meetingTitle.value = infoSessionResponse.sessionDescription;
          }
        }
      } catch (e) {
        // Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  Future fetchInfoSessionRegistration() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoaderRegistration.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.getInfoSessionRegistration(
          request: InfoSessionRegistrationRequest(
            userId: userId,
            webinarMeetingId: zoomMeetingID.value,
          ),
        );
        if (response != null) {
          InfoSessionRegisterRespose baseResponse =
              (response as InfoSessionRegisterRespose);
          if (baseResponse.registrantId != null) {
            Utils.errorSnackBar(AppStrings.success, baseResponse.message ?? "",
                isSuccess: true);
            fetchInfoSession();
          } else {
            Utils.errorSnackBar(AppStrings.error, baseResponse.message ?? "");
          }
        }
      } catch (e) {
        // Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoaderRegistration.value = false;
      }
    }
    return null;
  }

  joinMeeting(
      {required String meetingId, required String meetingPassword}) async {
    var userName = await SessionManager.getUserName();
    var userEmail = await SessionManager.getUserEmail();

    await platform.invokeMethod('JOIN_MEETING', {
      "USER_NAME": userName,
      "MEETING_ID": meetingId,
      "MEETING_PASSWORD": meetingPassword,
      "USER_EMAIL": userEmail
    });
  }

  playRecording(
      {required String title,
      required String recordedMeetingUrl,
      required String recordedMeetingPassword}) {

    Get.to(
      RecordedMeetingScreen(
        title: title,
        recordedMeetingPassword: recordedMeetingPassword,
        recordedMeetingUrl: recordedMeetingUrl,
      ),
    );
  }
}
