import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../controller/fun_facts_and_master_class_controller.dart';
import '../widget/item_fun_facts_and_master_class.dart';

class FunFactsAndMasterClassScreen extends StatefulWidget {
  const FunFactsAndMasterClassScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FunFactsAndMasterClassScreenState();
}

class _FunFactsAndMasterClassScreenState
    extends State<FunFactsAndMasterClassScreen> {
  String? title;
  Color? color;

  final FunFactsAndMasterClassController _controller =
      Get.isRegistered<FunFactsAndMasterClassController>()
          ? Get.find<FunFactsAndMasterClassController>()
          : Get.put(FunFactsAndMasterClassController());

  @override
  void initState() {
    Map<String, dynamic> value = Get.arguments;
    title = value['title'];
    color = value['color'];
    _controller.fileId = value['fileId'];
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
                              mainAxisSpacing: 8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemFolderKnowledge(
                          item: _controller.dataList[index],
                          color: color ?? AppColor.yellowKnowledge,
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
