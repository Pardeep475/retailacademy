import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retail_academy/common/local_storage/session_manager.dart';
import 'package:retail_academy/network/modal/base/base_response.dart';
import 'package:retail_academy/network/modal/profile/update_profile_image_request.dart';
import '../../../common/app_strings.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/profile/logout_request.dart';
import '../../../network/modal/profile/logout_response.dart';
import '../../../network/modal/profile/profile_response.dart';

class ProfileController extends GetxController {
  var showLoader = false.obs;
  var notificationSwitchEnabled = false.obs;

  var profileImage = ''.obs;
  var staffName = ''.obs;
  var storeName = ''.obs;
  var staffIdNumber = ''.obs;
  var emailAddress = ''.obs;

  final ImagePicker _picker = ImagePicker();

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

  updateNotificationSwitch(bool value) {
    notificationSwitchEnabled.value = value;
  }

  cameraClickListener() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      updateProfileImage(imgUrl: image.path);
    } else {
      Utils.errorSnackBar(AppStrings.error.tr, AppStrings.imageCancelByUser);
    }
  }

  galleryClickListener() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      updateProfileImage(imgUrl: image.path);
    } else {
      Utils.errorSnackBar(AppStrings.error.tr, AppStrings.imageCancelByUser);
    }
  }

  isUrl() {
    if (profileImage.value.isEmpty) {
      return true;
    } else if (profileImage.value.contains('http://') ||
        profileImage.value.contains('https://')) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchUserDetails() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.fetchUserDetails(
          userId: userId,
        );
        if (response != null) {
          ProfileResponse profileResponse = (response as ProfileResponse);
          if (profileResponse.status) {
            profileImage.value = profileResponse.profilePic;
            staffName.value = profileResponse.userFullName;
            storeName.value = '';
            staffIdNumber.value = profileResponse.employeeNumber;
            emailAddress.value = profileResponse.emailId;
          } else {
            Utils.errorSnackBar(AppStrings.error, profileResponse.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  Future updateProfileImage({required String imgUrl}) async {

    List<int> imageBytes = await File(imgUrl).readAsBytes();
    String base64Image = base64Encode(imageBytes);
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.updateProfileImage(
          request: UpdateProfileImageRequest(
              userid: userId, base64Image: base64Image),
        );
        if (response != null) {
          BaseResponse value = (response as BaseResponse);
          if (value.status) {
            Utils.errorSnackBar(AppStrings.success, value.message,
                isSuccess: true);
            fetchUserDetails();
          } else {
            Utils.errorSnackBar(AppStrings.error, value.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  Future logoutApi() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String platform = Platform.isAndroid ? "android" : "ios";
        String deviceToken = await SessionManager.getDeviceToken();
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.logoutApi(
          request: LogoutRequest(
            deviceToken: deviceToken,
            platform: platform,
            userid: userId,
          ),
        );

        if (response != null) {
          LogoutResponse value = (response as LogoutResponse);
          if (value.status) {
            Utils.errorSnackBar(AppStrings.success, value.message,
                isSuccess: true);
            await SessionManager.clearAllData();
            Get.offAndToNamed(RouteString.loginScreen);
          } else {
            Utils.errorSnackBar(AppStrings.error, value.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }
}
