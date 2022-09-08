import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/controller/knowledge_controller.dart';
import 'package:retail_academy/app/knowledge/modal/knowledge_entity.dart';
import '../../../common/app_strings.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/widget/custom_app_bar.dart';
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

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getKnowledgeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: AppStrings.knowledge,
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: ClampingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: _controller.dataList.length,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  itemBuilder: (BuildContext context, int index) {
                    KnowledgeEntity knowledgeEntity =
                        _controller.dataList[index];
                    return ItemKnowledge(
                      item: knowledgeEntity,
                      onPressed: () {
                        switch (knowledgeEntity.title) {
                          case AppStrings.funFacts:
                          case AppStrings.masterClass:
                            {
                              var arguments = <String, dynamic>{
                                "title": knowledgeEntity.title,
                                "color": knowledgeEntity.color,
                                "fileId":
                                    knowledgeEntity.title == AppStrings.funFacts
                                        ? 6
                                        : 5,
                              };
                              Get.toNamed(
                                  RouteString.funFactsAndMasterClassScreen,
                                  arguments: arguments);
                            }
                            break;
                          default:
                            {}
                        }
                      },
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
