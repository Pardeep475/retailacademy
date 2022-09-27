import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/base/base_response.dart';
import '../../../network/modal/trending/like_trending_request.dart';
import '../../../network/modal/trending/trending_pagination_request.dart';
import '../../../network/modal/trending/trending_response.dart';

class CommentController extends GetxController {
  var showLoader = false.obs;
  RxList<ActivityStream> dataList = RxList();
  var showPagination = false.obs;

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

  Future getTrendingApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.getTrendingApi(
          userId: userId,
          orgId: AppStrings.orgId,
        );
        if (response != null) {
          TrendingResponse trendingResponse = (response as TrendingResponse);
          if (trendingResponse.status) {
            dataList.clear();
            dataList.addAll(trendingResponse.activityStreams ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(AppStrings.error, trendingResponse.message);
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

  Future getTrendingApiWithPagination() async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showPagination.value = true;
        String userId = await SessionManager.getUserId();
        var response =
        await ApiProvider.apiProvider.getTrendingApiWithPagination(
          request: TrendingPaginationRequest(
              userId: int.parse(userId),
              orgId: AppStrings.orgId,
              aIDAfter: dataList[dataList.length - 1].activityStreamId),
        );
        if (response != null) {
          TrendingResponse trendingResponse = (response as TrendingResponse);
          if (trendingResponse.status) {
            dataList.addAll(trendingResponse.activityStreams ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(AppStrings.error, trendingResponse.message);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error, e.toString());
      } finally {
        showPagination.value = false;
      }
    }
    return null;
  }

  Future trendingLikeApi(
      {required int index, required int activityStreamId}) async {
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
            ActivityStream item = dataList[index];
            item.hasLiked = !item.hasLiked;
            dataList[index] = item;
            dataList.refresh();
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
