import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
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
  String? description;
  String? categoryId;

  final WhatsHotBlogContentController _controller =
      Get.isRegistered<WhatsHotBlogContentController>()
          ? Get.find<WhatsHotBlogContentController>()
          : Get.put(WhatsHotBlogContentController());

  @override
  void initState() {
    Map<String, dynamic> value = Get.arguments;
    title = value['title'];
    description = value['description'];
    _controller.categoryId = value['categoryId'];
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
              CustomAppBar(
                title: title ?? '',
                isBackButtonVisible: true,
                isSearchButtonVisible: false,
                isNotificationButtonVisible: true,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: description ?? '',
                  textSize: 16.sp,
                  textAlign: TextAlign.left,
                  color: AppColor.black,
                  lineHeight: 1.3,
                  maxLines: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () =>
                          _controller.fetchWhatsHotContentApi(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => _controller.fetchWhatsHotContentApi(
                        isLoader: false),
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
