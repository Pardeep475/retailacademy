import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_zoom_sdk/zoom_options.dart';
// import 'package:flutter_zoom_sdk/zoom_view.dart';
import 'package:get/get.dart';
import 'package:retail_academy/network/modal/base/base_response.dart';
import 'package:retail_academy/network/modal/info_session/info_session_response.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/info_session/info_session_registration_request.dart';

class InfoSessionsController extends GetxController {
  var showLoader = true.obs;
  var showLoaderRegistration = false.obs;
  late Timer timer;

  var registrationStatus = false.obs;
  var zoomMeetingID = ''.obs;
  var zoomMeetingPassword = ''.obs;
  var zoomMeetingStartDate = ''.obs;
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
            zoomMeetingStartDate.value =
                infoSessionResponse.zoomMeetingStartDate;
          } else {
            // Utils.errorSnackBar(AppStrings.error, infoSessionResponse.message);
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
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
            Utils.errorSnackBar(AppStrings.success, baseResponse.message,
                isSuccess: true);
            fetchInfoSession();
          } else {
            Utils.errorSnackBar(AppStrings.error, baseResponse.message);
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
      {required BuildContext context,
      required String userName,
      required String meetingId,
      required String meetingPassword}) async {
    await platform.invokeMethod('JOIN_MEETING', {
      "USER_NAME": userName,
      "MEETING_ID": meetingId,
      "MEETING_PASSWORD": meetingPassword
    });
  }
}
