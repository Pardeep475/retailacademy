import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/retails_reels/retail_reels_list_request.dart';
import '../../../network/modal/retails_reels/retail_reels_list_response.dart';

class RetailReelsContentController extends GetxController {
  var showLoader = true.obs;
  final RxList<ReelElement> dataList = RxList();
  var categoryId = -1;

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

  Future fetchRetailReelsContentApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        RetailReelsListRequest request = RetailReelsListRequest(
            userId: userId, categoryId: categoryId.toString());
        var response = await ApiProvider.apiProvider
            .fetchRetailsReelsList(request: request);
        if (response != null) {
          RetailReelsListResponse reelsListResponse =
              (response as RetailReelsListResponse);
          if (reelsListResponse.status) {
            dataList.clear();
            dataList.addAll(reelsListResponse.reel ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(
                AppStrings.error, reelsListResponse.message);
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
}
