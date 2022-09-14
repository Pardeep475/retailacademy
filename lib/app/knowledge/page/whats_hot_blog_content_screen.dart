import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_strings.dart';

import '../../../common/app_color.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_response.dart';
import '../controller/whats_hot_blog_content_controller.dart';
import '../widget/item_whats_hot_blog_content.dart';
import 'whats_hot_blog_detail_screen.dart';

class WhatsHotBlogContentScreen extends StatefulWidget {
  const WhatsHotBlogContentScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WhatsHotBlogContentScreenState();
}

class _WhatsHotBlogContentScreenState extends State<WhatsHotBlogContentScreen> {
  String? title;
  String? categoryId;

  final WhatsHotBlogContentController _controller =
      Get.isRegistered<WhatsHotBlogContentController>()
          ? Get.find<WhatsHotBlogContentController>()
          : Get.put(WhatsHotBlogContentController());

  @override
  void initState() {
    Map<String, dynamic> value = Get.arguments;
    title = value['title'];
    _controller.categoryId = value['categoryId'];
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.fetchWhatsHotContentApi();
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: ClampingScrollPhysics()),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                        child: AppText(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          textSize: 16.sp,
                          textAlign: TextAlign.left,
                          color: AppColor.black,
                          maxLines: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(() {
                        return RefreshIndicator(
                          onRefresh: () => _controller.fetchWhatsHotContentApi(
                              isLoader: false),
                          child: GridView.builder(
                            itemCount: _controller.dataList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 3.0,
                                    childAspectRatio: .8,
                                    mainAxisSpacing: 3.0),
                            itemBuilder: (BuildContext context, int index) {
                              BlogContentElement item =
                                  _controller.dataList[index];
                              return ItemWhatsHotBlogContent(
                                item: item,
                                onPressed: () {
                                  Get.to(
                                    WhatsHotBogDetailScreen(
                                      item: item,
                                      categoryId: _controller.categoryId,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      })
                    ],
                  ),
                ),
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
