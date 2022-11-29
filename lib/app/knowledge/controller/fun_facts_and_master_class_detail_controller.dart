import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retail_academy/network/modal/knowledge/like_or_dislike_content_knowledge_section_request.dart';
import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';

import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/knowledge/content_display_request.dart';
import '../../../network/modal/knowledge/content_display_response.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../network/modal/knowledge/quiz_category_response.dart';

class FunFactsAndMasterClassDetailController extends GetxController {
  var showLoader = true.obs;
  var showLoaderQuiz = false.obs;

  var isError = false.obs;
  var hasLiked = false.obs;

  var filePath = ''.obs;
  var fileName = ''.obs;
  var description = ''.obs;

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

  void clearAllData() {
    showLoader.value = false;
    hasLiked.value = false;
    isError.value = false;
    filePath.value = '';
    fileName.value = '';
    description.value = '';
  }

  Future contentDisplayApi({required int fileId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.contentDisplayApi(
          request: ContentDisplayRequest(
            fileId: fileId,
            userId: int.parse(userId),
          ),
        );
        if (response != null) {
          ContentDisplayResponse contentDisplayResponse =
              (response as ContentDisplayResponse);
          if (contentDisplayResponse.status) {
            hasLiked.value = contentDisplayResponse.likeByUser;
            fileName.value = contentDisplayResponse.fileName;
            description.value = '' /*contentDisplayResponse.message*/;
            if (Utils.isPdf(contentDisplayResponse.filesUrl)) {
              await getFileFromUrl(contentDisplayResponse.filesUrl);
            } else {
              filePath.value = contentDisplayResponse.filesUrl;
            }
          } else {
            Utils.errorSnackBar(
                AppStrings.error, contentDisplayResponse.message);
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

  Future likeOrDislikeContentKnowledgeSectionApi(
      {required int fileId, bool isLoader = false}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoaderQuiz.value = true;

        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider
            .likeOrDislikeContentKnowledgeSectionApi(
                request: LikeOrDislikeContentKnowledgeSectionRequest(
          fileId: fileId,
          userId: int.parse(userId),
          check: hasLiked.value ? 0 : 1,
        ));
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
            hasLiked.value = !hasLiked.value;
          } else {
            Utils.errorSnackBar(AppStrings.error, baseResponse.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoaderQuiz.value = false;
      }
    }
    return null;
  }

  updateError(bool error) {
    isError.value = error;
  }

  // downloadfile
  Future<String?> getFileFromUrl(String url, {name}) async {
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
      filePath.value = urlFile.path;
    } catch (e) {
      debugPrint("Error opening url file  $e");
    } finally {
      showLoader.value = false;
    }
  }

  Future<bool> requestPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    }
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    var value = await Permission.storage.status;
    if (value.isDenied) {
      if (await Permission.storage.request().isGranted) {
        return true;
      } else {
        return false;
      }
    }
    if (value.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    if (value.isRestricted) {
      return await requestPermission();
    }
    return false;
  }

  Future<QuizCategoryElement?> getQuizMasterApi({required int quizId}) async {
    QuizCategoryElement? item;

    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoaderQuiz.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.getQuizCategoryApi(
            userId: userId, orgId: AppStrings.orgId, quizId: quizId);
        if (response != null) {
          QuizCategoryResponse quizCategoryResponse =
              (response as QuizCategoryResponse);
          if (quizCategoryResponse.status) {
            if (quizCategoryResponse.quizCategories != null &&
                quizCategoryResponse.quizCategories!.isNotEmpty) {
              item = quizCategoryResponse.quizCategories!.first;
            }
          } else {
            Utils.errorSnackBar(AppStrings.error, quizCategoryResponse.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoaderQuiz.value = false;
      }
    }
    return item;
  }
}
