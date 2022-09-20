import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';
import 'package:retail_academy/common/app_images.dart';
import 'package:retail_academy/common/app_strings.dart';

import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/knowledge/knowledge_api_response.dart';
import '../modal/knowledge_entity.dart';

class KnowledgeController extends GetxController {
  var showLoader = false.obs;
  final RxList<KnowledgeElement> dataList = RxList();


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


  Future getKnowledgeApi({bool isLoader = true}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        if (isLoader) {
          showLoader.value = true;
        }
        String userId = await SessionManager.getUserId();
        var response = await ApiProvider.apiProvider.getKnowledgeApi(
          userId: userId,
          orgId: AppStrings.orgId,
        );
        if (response != null) {
          KnowledgeApiResponse knowledgeResponse = (response as KnowledgeApiResponse);
          if (knowledgeResponse.status) {
            dataList.clear();
            dataList.addAll(knowledgeResponse.knowledgeElement ?? []);
            dataList.refresh();
          } else {
            Utils.errorSnackBar(AppStrings.error, knowledgeResponse.message);
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

  // getKnowledgeData() {
  //   if (dataList.isNotEmpty) {
  //     dataList.clear();
  //   }
  //
  //   KnowledgeRepository _knowledgeRepository = KnowledgeRepository();
  //   List<KnowledgeEntity> entityList =
  //   _knowledgeRepository.getKnowledgeData();
  //
  //   dataList.addAll(entityList);
  //   dataList.refresh();
  // }

}

class KnowledgeRepository {
  List<KnowledgeEntity> getKnowledgeData() {
    return [
      KnowledgeEntity(
          title: AppStrings.funFacts,
          description: AppStrings.funFactsDescription,
          color: AppColor.yellowKnowledge,
          icon: AppImages.imgKnowledgeFunFacts,
      ),

      KnowledgeEntity(
          title: AppStrings.masterClass,
          description: AppStrings.masterClassDescription,
          color: AppColor.redKnowledge,
          icon: AppImages.imgKnowledgeMasterClass,
      ),

      KnowledgeEntity(
        title: AppStrings.quizMaster,
        description: AppStrings.quizMasterDescription,
        color: AppColor.pinkKnowledge,
        icon: AppImages.imgKnowledgeQuizMaster,
      ),

      KnowledgeEntity(
        title: AppStrings.whatsHotBlog,
        description: AppStrings.whatsHotBlogDescription,
        color: AppColor.greenKnowledge,
        icon: AppImages.imgKnowledgeWhatHotBlog,
      ),
      KnowledgeEntity(
        title: AppStrings.podCast,
        description: AppStrings.podCastDescription,
        color: AppColor.darkBlueKnowledge,
        icon: AppImages.imgKnowledgePodcast,
      ),
    ];
  }
}
