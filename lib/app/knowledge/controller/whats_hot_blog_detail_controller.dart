import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_like_or_dislike.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_request.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_response.dart';
import 'package:http/http.dart' as http;

class WhatsHotBlogDetailController extends GetxController {
  var showLoader = true.obs;
  var hasLiked = false.obs;
  var showLoaderQuiz = false.obs;
  var blogDescription = ''.obs;
  var videoUrl = ''.obs;
  var isError = false.obs;

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
    blogDescription.value = '';
    videoUrl.value = '';
  }

  Future fetchWhatsHotContentApi(
      {required int categoryId, required int blogId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;

        String userId = await SessionManager.getUserId();
        WhatsHotBlogContentRequest request = WhatsHotBlogContentRequest(
            userId: int.parse(userId), categoryId: categoryId, blogId: blogId);
        var response = await ApiProvider.apiProvider
            .fetchWhatsHotBlogContent(request: request);
        if (response != null) {
          WhatsHotBlogContentResponse whatsHotBlogContentResponse =
              (response as WhatsHotBlogContentResponse);
          if (whatsHotBlogContentResponse.status &&
              whatsHotBlogContentResponse.blogContentList != null &&
              whatsHotBlogContentResponse.blogContentList!.isNotEmpty) {
            BlogContentElement blogContentElement =
                whatsHotBlogContentResponse.blogContentList!.first;

            blogDescription.value = blogContentElement.blogDescription;
            hasLiked.value = blogContentElement.hasLiked;

            if (Utils.isPdf(blogContentElement.videoUrl)) {
              await getFileFromUrl(blogContentElement.videoUrl);
            } else {
              if (blogContentElement.videoUrl.isNotEmpty) {
                videoUrl.value = blogContentElement.videoUrl;
              } else {
                videoUrl.value = blogContentElement.imageUrl;
              }
            }
          } else {
            Utils.errorSnackBar(
                AppStrings.error, whatsHotBlogContentResponse.message);
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

  Future likeOrDislikeBlogApi({required int blogId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoaderQuiz.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.likeOrDislikeBlogApi(
          request: WhatsHotBlogContentLikeOrDisLikeRequest(
            blogId: blogId,
            userId: int.parse(userId),
          ),
        );
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
      videoUrl.value = urlFile.path;
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
}
