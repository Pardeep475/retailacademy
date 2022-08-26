import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';
import 'package:retail_academy/common/app_images.dart';
import 'package:retail_academy/common/app_strings.dart';

import '../../../common/utils.dart';
import '../modal/knowledge_entity.dart';

class KnowledgeController extends GetxController {
  var showLoader = false.obs;
  final RxList<KnowledgeEntity> dataList = RxList();


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

  getKnowledgeData() {
    if (dataList.isNotEmpty) {
      dataList.clear();
    }

    KnowledgeRepository _knowledgeRepository = KnowledgeRepository();
    List<KnowledgeEntity> entityList =
    _knowledgeRepository.getKnowledgeData();

    dataList.addAll(entityList);
    dataList.refresh();
  }

}

class KnowledgeRepository {
  List<KnowledgeEntity> getKnowledgeData() {
    return [
      KnowledgeEntity(
          title: AppStrings.funFacts,
          description: AppStrings.funFactsDescription,
          color: AppColor.yellowKnowledge,
          icon: AppImages.iconFunFacts,
      ),

      KnowledgeEntity(
          title: AppStrings.masterClass,
          description: AppStrings.masterClassDescription,
          color: AppColor.redKnowledge,
          icon: AppImages.iconMasterClass,
      ),

      KnowledgeEntity(
        title: AppStrings.quizMaster,
        description: AppStrings.quizMasterDescription,
        color: AppColor.pinkKnowledge,
        icon: AppImages.iconQuizMaster,
      ),

      KnowledgeEntity(
        title: AppStrings.whatsHotBlog,
        description: AppStrings.whatsHotBlogDescription,
        color: AppColor.greenKnowledge,
        icon: AppImages.iconWhatsHotBlog,
      ),
      KnowledgeEntity(
        title: AppStrings.podCast,
        description: AppStrings.podCastDescription,
        color: AppColor.darkBlueKnowledge,
        icon: AppImages.iconPodCast,
      ),
    ];
  }
}
