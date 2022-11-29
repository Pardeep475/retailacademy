import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';
import '../../../common/utils.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/knowledge/content_knowledge_response.dart';
import '../controller/fun_facts_and_master_class_content_controller.dart';
import '../knowledge_navigation/knowledge_navigation.dart';
import '../widget/item_fun_facts_and_master_class.dart';
import 'fun_facts_and_master_class_detail_screen.dart';

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
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

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

  _initDebounce({required String value}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
      _controller.searchFunctionality(value: value);
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
                title: widget.fileName,
                isBackButtonVisible: true,
                key: UniqueKey(),
                isSearchButtonVisible: true,
                onBackPressed: () async {
                  await onBackPressed();
                },
                textController: _searchController,
                onEditingComplete: () {
                  debugPrint('Search_Functionality:----  onEditingComplete');
                  _controller.searchFunctionality(
                      value: _searchController.text.toString());
                },
                onChanged: (value) {
                  debugPrint('Search_Functionality:---- onChanged $value');
                  _initDebounce(value: value);
                },
                onCrossClick: () {
                  debugPrint('Search_Functionality:---- onCrossClick ');
                  _controller.searchFunctionality(value: '');
                },
              ),
              Expanded(
                child: Obx(() {
                  debugPrint(
                      'item length:---   ${_controller.searchDataList.length}');

                  if (!_controller.showLoader.value &&
                      _controller.searchDataList.isEmpty) {
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
                      itemCount: _controller.searchDataList.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 1.3,
                              mainAxisSpacing: 16.0),
                      itemBuilder: (BuildContext context, int index) {
                        FileElement item = _controller.searchDataList[index];
                        return ItemContentKnowledge(
                          item: item,
                          onPressed: () async {
                            if (Utils.isPdf(item.filesUrl)) {
                              Get.toNamed(
                                  KnowledgeNavigation
                                      .funFactsAndMasterClassDetailScreen,
                                  id: KnowledgeNavigation.id,
                                  arguments: {
                                    "fileId": item.fileId.toString(),
                                    "quizId": item.quizId,
                                    "quizName": item.quizName,
                                  });
                            } else {
                              Get.to(FunFactsAndMasterClassDetailScreen(
                                fileId: item.fileId.toString(),
                                quizName: item.quizName,
                                quizId: item.quizId,
                                isTrending: true,
                              ));
                            }
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
