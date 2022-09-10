import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retail_academy/network/modal/knowledge/like_or_dislike_content_knowledge_section_request.dart';
import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/knowledge/content_knowledge_response.dart';

class FunFactsAndMasterClassDetailController extends GetxController {
  var showLoader = false.obs;

  var fileUrl = ''.obs;

  void clearValue() {
    showLoader.value = false;

    fileUrl.value = '';
  }

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

  getFileFromUrl(String url, {name}) async {
    bool value = await requestPermission();
    if (!value) {
      return null;
    }
    var fileName = 'pdfOnline';
    if (name != null) {
      fileName = name;
    }
    showLoader.value = true;
    try {
      debugPrint(url);
      // var data = await http.get(Uri.parse("http://www.africau.edu/images/default/sample.pdf"));
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      debugPrint(file.path);
      File urlFile = await file.writeAsBytes(bytes);
      fileUrl.value = urlFile.path;
    } catch (e) {
      debugPrint("Error opening url file  $e");
      fileUrl.value = '';
    } finally {
      showLoader.value = false;
    }
  }

  Future<bool> requestPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    // You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
    // await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  Future likeOrDislikeContentKnowledgeSectionApi(
      {required FileElement item}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider
            .likeOrDislikeContentKnowledgeSectionApi(
                request: LikeOrDislikeContentKnowledgeSectionRequest(
          fileId: item.fileId,
          userId: int.parse(userId),
          check: 1,
        ));
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
          } else {
            Utils.errorSnackBar(AppStrings.error, baseResponse.message);
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
