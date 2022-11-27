import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../controller/fun_facts_and_master_class_controller.dart';
import '../knowledge_navigation/knowledge_navigation.dart';
import '../widget/item_fun_facts_and_master_class.dart';

class FunFactsAndMasterClassScreen extends StatefulWidget {
  final String title;
  final Color color;
  final int fileId;

  const FunFactsAndMasterClassScreen(
      {required this.title,
      required this.color,
      required this.fileId,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FunFactsAndMasterClassScreenState();
}

class _FunFactsAndMasterClassScreenState
    extends State<FunFactsAndMasterClassScreen> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  final FunFactsAndMasterClassController _controller =
      Get.isRegistered<FunFactsAndMasterClassController>()
          ? Get.find<FunFactsAndMasterClassController>()
          : Get.put(FunFactsAndMasterClassController());

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
      Get.keys[KnowledgeNavigation.id]!.currentState!.maybePop();
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
                title: widget.title,
                isBackButtonVisible: true,
                isSearchButtonVisible: true,
                key: UniqueKey(),
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
                      isButtonVisible:
                          _searchController.text.isEmpty ? true : false,
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
                              mainAxisSpacing: 8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemFolderKnowledge(
                          item: _controller.searchDataList[index],
                          color: widget.color,
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

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
