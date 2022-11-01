import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/controller/knowledge_controller.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/knowledge/knowledge_api_response.dart';
import '../widget/item_knowledge.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final KnowledgeController _controller =
      Get.isRegistered<KnowledgeController>()
          ? Get.find<KnowledgeController>()
          : Get.put(KnowledgeController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearAllData();
      _controller.getKnowledgeApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const CustomAppBar(
                title: AppStrings.knowledge,
              ),
              Expanded(
                child: Obx(() {
                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () => _controller.getKnowledgeApi(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.getKnowledgeApi(isLoader: false),
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: _controller.dataList.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        itemBuilder: (BuildContext context, int index) {
                          KnowledgeElement knowledgeEntity =
                              _controller.dataList[index];
                          return ItemKnowledge(
                            item: knowledgeEntity,
                            onPressed: () {
                              if (knowledgeEntity.folderId >= 0) {
                                var arguments = <String, dynamic>{
                                  "title": knowledgeEntity.folderName,
                                  "color": Utils.hexToColor(
                                      knowledgeEntity.colourCode),
                                  "fileId": knowledgeEntity.folderId,
                                };
                                Get.toNamed(
                                    RouteString.funFactsAndMasterClassScreen,
                                    arguments: arguments);
                              } else {
                                if (knowledgeEntity.folderId == -1) {
                                  var arguments = <String, dynamic>{
                                    "color": Utils.hexToColor(
                                        knowledgeEntity.colourCode),
                                  };
                                  Get.toNamed(RouteString.quizMasterScreen,
                                      arguments: arguments);
                                } else if (knowledgeEntity.folderId == -2) {
                                  Get.toNamed(
                                    RouteString.whatsHotBlogScreen,
                                  );
                                } else if (knowledgeEntity.folderId == -3) {
                                  Get.toNamed(
                                    RouteString.podCastScreen,
                                  );
                                }
                              }
                            },
                          );
                        }),
                  );
                }),
              ),
            ],
          ),
          Obx(
            () => Positioned.fill(
              child: _controller.showLoader.value
                  ? Container(
                      color: Colors.transparent,
                      width: Get.width,
                      height: Get.height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.loaderColor),
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
