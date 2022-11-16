import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/knowledge/content_knowledge_response.dart';
import '../controller/fun_facts_and_master_class_content_controller.dart';
import '../knowledge_navigation/knowledge_navigation.dart';
import '../widget/item_fun_facts_and_master_class.dart';


class FunFactsAndMasterClassContentScreen extends StatefulWidget {
  final String fileName;
  final int fileId;

  const FunFactsAndMasterClassContentScreen(
      {required this.fileId, required this.fileName, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FunFactsAndMasterClassContentScreenState();
}

class _FunFactsAndMasterClassContentScreenState
    extends State<FunFactsAndMasterClassContentScreen> {
  final FunFactsAndMasterClassContentController _controller =
      Get.isRegistered<FunFactsAndMasterClassContentController>()
          ? Get.find<FunFactsAndMasterClassContentController>()
          : Get.put(FunFactsAndMasterClassContentController());

  @override
  void initState() {
    _controller.clearAllData();
    _controller.fileId = widget.fileId;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getContentKnowledgeSection();
    });
  }

  onBackPressed() async {
    try {
      await Get.keys[KnowledgeNavigation.id]!.currentState!.maybePop();
    } catch (e) {
      // error
      debugPrint('ErrorWhileNavigation:----  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppBar(
                title: widget.fileName,
                isBackButtonVisible: true,
                isSearchButtonVisible: true,
                onBackPressed: () async {
                  await onBackPressed();
                },
              ),
              Expanded(
                child: Obx(() {
                  debugPrint(
                      'item length:---   ${_controller.dataList.length}');

                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () {
                        _controller.getContentKnowledgeSection();
                      },
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => _controller.getContentKnowledgeSection(
                        isLoader: false),
                    child: GridView.builder(
                      itemCount: _controller.dataList.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 1.3,
                              mainAxisSpacing: 16.0),
                      itemBuilder: (BuildContext context, int index) {
                        FileElement item = _controller.dataList[index];
                        return ItemContentKnowledge(
                          item: item,
                          onPressed: () async {
                            Get.toNamed(
                                KnowledgeNavigation
                                    .funFactsAndMasterClassDetailScreen,
                                id: KnowledgeNavigation.id,
                                arguments: {
                                  "fileId": item.fileId.toString(),
                                  "quizId": item.quizId,
                                  "quizName": item.quizName,
                                });

                            // Get.to(
                            //   () => FunFactsAndMasterClassDetailScreen(
                            //     fileId: item.fileId.toString(),
                            //   ),
                            // );

                            // String? filePath =
                            //     await _controller.getFileFromUrl(item.filesUrl);
                            // if (filePath != null) {
                            //   Get.to(
                            //     () => FunFactsAndMasterClassDetailScreen(
                            //       fileId: item.fileId.toString(),
                            //     ),
                            //   );
                            // } else {
                            //   Utils.errorSnackBar(
                            //       AppStrings.error, 'Something went wrong');
                            // }
                          },
                        );
                      },
                    ),
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
