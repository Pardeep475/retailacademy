import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_zoom_sdk/zoom_options.dart';
// import 'package:flutter_zoom_sdk/zoom_view.dart';
import 'package:get/get.dart';
import 'package:retail_academy/network/modal/info_session/info_session_response.dart';

import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';

class InfoSessionsController extends GetxController {
  var showLoader = true.obs;
  late Timer timer;

  var registrationStatus = false.obs;
  var zoomRegistrationID = ''.obs;
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
            zoomRegistrationID.value = infoSessionResponse.zoomRegistrationId;
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

  bool _isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid) {
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    } else {
      result = status == "MEETING_STATUS_IDLE";
    }

    return result;
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

      // if (meetingId.isNotEmpty) {
      //   ZoomOptions zoomOptions = ZoomOptions(
      //     domain: "zoom.us",
      //     appKey: "ZhOoqcaWoRvolchX0NjY9BR5Y4WyN6c4PUUZ",
      //     //API KEY FROM ZOOM - Sdk API Key
      //     appSecret:
      //         "3HeeyzxDjVXIVissomgp3kzykUbUkohAAYMh", //API SECRET FROM ZOOM - Sdk API Secret
      //   );
      //   var meetingOptions = ZoomMeetingOptions(
      //       userId: userName,
      //       //pass username for join meeting only --- Any name eg:- EVILRATT.
      //       meetingId: meetingId,
      //       //pass meeting id for join meeting only
      //       meetingPassword: meetingPassword,
      //       //pass meeting password for join meeting only
      //       disableDialIn: "true",
      //       disableDrive: "true",
      //       disableInvite: "true",
      //       disableShare: "true",
      //       disableTitlebar: "false",
      //       viewOptions: "true",
      //       noAudio: "false",
      //       noDisconnectAudio: "false");
      //
      //   var zoom = ZoomView();
      //   zoom.initZoom(zoomOptions).then((results) {
      //     if (results[0] == 0) {
      //       zoom.onMeetingStatus().listen((status) {
      //         debugPrint(
      //             "[Meeting Status Stream] : " + status[0] + " - " + status[1]);
      //         if (_isMeetingEnded(status[0])) {
      //           debugPrint("[Meeting Status] :- Ended");
      //           timer.cancel();
      //         }
      //       });
      //       debugPrint("listen on event channel");
      //       zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
      //         timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      //           zoom.meetingStatus(meetingOptions.meetingId!).then((status) {
      //             debugPrint("[Meeting Status Polling] : " +
      //                 status[0] +
      //                 " - " +
      //                 status[1]);
      //           });
      //         });
      //       });
      //     }
      //   }).catchError((error) {
      //     debugPrint("[Error Generated] : " + error);
      //   });
      // } else {
      //   if (meetingId.isEmpty) {
      //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text("Enter a valid meeting id to continue."),
      //     ));
      //   } else if (meetingPassword.isEmpty) {
      //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text("Enter a meeting password to start."),
      //     ));
      //   }
      // }
  }
}
