import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/retails_reels/page/retail_reels_detail_screen.dart';

import '../../../common/app_color.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/retails_reels/retail_reels_list_response.dart';
import '../controller/retail_reels_content_controller.dart';
import '../retails_reels_navigation/retail_reels_navigation.dart';
import '../widget/item_retail_reels_content.dart';

class RetailReelsContentScreen extends StatefulWidget {
  final String title;
  final int categoryId;

  const RetailReelsContentScreen(
      {required this.title, required this.categoryId, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RetailReelsContentScreenState();
}

class _RetailReelsContentScreenState extends State<RetailReelsContentScreen> {


  final RetailReelsContentController _controller =
      Get.isRegistered<RetailReelsContentController>()
          ? Get.find<RetailReelsContentController>()
          : Get.put(RetailReelsContentController());

  @override
  void initState() {
    _controller.clearAllData();
    _controller.categoryId = widget.categoryId;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.fetchRetailReelsContentApi();
    });
  }

  onBackPressed() async {
    try {
      Get.keys[RetailReelsNavigation.id]!.currentState!.maybePop();
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
                title: widget.title,
                isBackButtonVisible: true,
                isSearchButtonVisible: false,
                isNotificationButtonVisible: true,
                onBackPressed: () async {
                  await onBackPressed();
                },
              ),
              Expanded(
                child: Obx(() {
                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () => _controller.fetchRetailReelsContentApi(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.fetchRetailReelsContentApi(isLoader: false),
                    child: GridView.builder(
                      itemCount: _controller.dataList.length,
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: ClampingScrollPhysics()),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 3.0,
                              childAspectRatio: 1,
                              mainAxisSpacing: 3.0),
                      itemBuilder: (BuildContext context, int index) {
                        ReelElement item = _controller.dataList[index];
                        return ItemRetailReelsContent(
                          item: item,
                          onPressed: () {
                            Get.to(
                              RetailReelsDetailScreen(
                                item: item,
                                categoryId: _controller.categoryId,
                              ),
                            );
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
