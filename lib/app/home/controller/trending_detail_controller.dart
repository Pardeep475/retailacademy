import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/trending/activity_stream_viewed_request.dart';
import '../../../network/modal/trending/like_trending_request.dart';

class TrendingDetailController extends GetxController {
  var showLoader = false.obs;
  var hasLike = false.obs;

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
    hasLike.value = false;
  }

  Future trendingLikeApi({required int activityStreamId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.trendingLikeApi(
            request: LikeTrendingRequest(
          orgId: AppStrings.orgId,
          activityStreamId: activityStreamId,
          userid: userId,
        ));
        if (response != null) {
          BaseResponse baseResponse = (response as BaseResponse);
          if (baseResponse.status) {
            hasLike.value = !hasLike.value;
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

  Future fetchActivityStreamViewedApi({required int activityStreamId}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        String userId = await SessionManager.getUserId();
        await ApiProvider.apiProvider.onActivityStreamViewedApi(
          request: ActivityStreamViewedRequest(
            activityStreamId: activityStreamId.toString(),
            userid: userId,
          ),
        );
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }
}
