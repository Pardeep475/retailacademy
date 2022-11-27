import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/retails_reels/retail_reels_categories_response.dart';
import '../controller/retail_reels_controller.dart';
import '../retails_reels_navigation/retail_reels_navigation.dart';
import '../widget/item_retail_reels_category.dart';

class RetailReelsScreen extends StatefulWidget {
  const RetailReelsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RetailReelsScreenState();
}

class _RetailReelsScreenState extends State<RetailReelsScreen> {
  final RetailReelsController _controller =
      Get.isRegistered<RetailReelsController>()
          ? Get.find<RetailReelsController>()
          : Get.put(RetailReelsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearAllData();
      _controller.fetchRetailsReelsCategoriesApi();
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
                title: AppStrings.retailReels,
              ),
              Expanded(
                child: Obx(() {
                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () =>
                          _controller.fetchRetailsReelsCategoriesApi(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => _controller.fetchRetailsReelsCategoriesApi(
                        isLoader: false),
                    child: GridView.builder(
                      itemCount: _controller.dataList.length,
                      physics: const BouncingScrollPhysics(
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
                        RetailReelsCategoryElement item =
                            _controller.dataList[index];
                        return ItemRetailReelsCategory(
                          item: item,
                          onItemClick: () {
                            // Get.to(DummyVideoScreen());

                            Get.toNamed(
                                RetailReelsNavigation.retailReelsContentScreen,
                                id: RetailReelsNavigation.id,
                                arguments: {
                                  "title": item.reelCategory,
                                  "categoryId": item.categoryId,
                                });
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
