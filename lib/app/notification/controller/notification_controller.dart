import 'package:get/get.dart';
import 'package:retail_academy/common/app_strings.dart';

import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/quiz_category_response.dart';
import '../../../network/modal/notification/notification_list_request.dart';
import '../../../network/modal/notification/notification_list_response.dart';

class NotificationController extends GetxController {
  var showLoader = true.obs;
  var showLoaderQuiz = false.obs;
  RxList<NotificationElement> dataList = RxList();

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
    showLoaderQuiz.value = false;
    dataList = RxList();
  }

  Future getNotificationApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.fetchNotificationListApi(
          request: NotificationListRequest(
            userId: userId,
            orgId: AppStrings.orgId,
          ),
        );
        if (response != null) {
          NotificationListResponse notificationListResponse =
              (response as NotificationListResponse);
          if (notificationListResponse.status) {
            dataList.clear();
            dataList.addAll(notificationListResponse.listNotification ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(
                AppStrings.error, notificationListResponse.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        if (isLoader) {
          showLoader.value = false;
        }
      }
    }
    return null;
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
