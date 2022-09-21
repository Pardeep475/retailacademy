import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_strings.dart';

import '../../../common/app_color.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../network/modal/knowledge/whats_hot_blog_response.dart';
import '../controller/whats_hot_blog_controller.dart';
import '../widget/item_whats_hot_blog.dart';

class WhatsHotBlogScreen extends StatefulWidget {
  const WhatsHotBlogScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WhatsHotBlogScreenState();
}

class _WhatsHotBlogScreenState extends State<WhatsHotBlogScreen> {
  final WhatsHotBlogController _controller =
      Get.isRegistered<WhatsHotBlogController>()
          ? Get.find<WhatsHotBlogController>()
          : Get.put(WhatsHotBlogController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.fetchWhatsHotApi();
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
                title: AppStrings.whatsHotBlog,
                isBackButtonVisible: true,
                isSearchButtonVisible: false,
                isNotificationButtonVisible: true,
              ),
              Expanded(
                child: Obx(() {
                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.fetchWhatsHotApi(isLoader: false),
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
                        BlogCategoryElement item = _controller.dataList[index];
                        return ItemWhatsHotBlog(
                          item: item,
                          onItemClick: () {
                            var arguments = <String, dynamic>{
                              "title": item.blogCategory,
                              "categoryId": item.categoryId,
                              "description": 'item.categoryId',
                            };
                            Get.toNamed(RouteString.whatsHotBlogContentScreen,
                                arguments: arguments);
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
