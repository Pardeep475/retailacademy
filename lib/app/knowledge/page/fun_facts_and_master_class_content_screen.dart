import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';

// import '../../../common/app_strings.dart';
// import '../../../common/utils.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/knowledge/content_knowledge_response.dart';
import '../controller/fun_facts_and_master_class_content_controller.dart';
import '../widget/item_fun_facts_and_master_class.dart';
import 'fun_facts_and_master_class_detail_screen.dart';

class FunFactsAndMasterClassContentScreen extends StatefulWidget {
  const FunFactsAndMasterClassContentScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FunFactsAndMasterClassContentScreenState();
}

class _FunFactsAndMasterClassContentScreenState
    extends State<FunFactsAndMasterClassContentScreen> {
  String? title;
  Color? color;

  final FunFactsAndMasterClassContentController _controller =
      Get.isRegistered<FunFactsAndMasterClassContentController>()
          ? Get.find<FunFactsAndMasterClassContentController>()
          : Get.put(FunFactsAndMasterClassContentController());

  @override
  void initState() {
    _controller.clearAllData();
    Map<String, dynamic> value = Get.arguments;
    title = value['title'];
    _controller.fileId = value['fileId'];
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getContentKnowledgeSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppBar(
                title: title ?? '',
                isBackButtonVisible: true,
                isSearchButtonVisible: true,
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
                    onRefresh: () =>
                        _controller.getContentKnowledgeSection(isLoader: false),
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
                            Get.to(
                                  () => FunFactsAndMasterClassDetailScreen(
                                fileId: item.fileId.toString(),
                              ),
                            );


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
