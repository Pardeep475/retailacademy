import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/page/pod_cast_content_screen.dart';
import 'package:retail_academy/app/knowledge/page/pod_cast_detail_screen.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/podcast/pod_cast_category_response.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';
import '../controller/pod_cast_controller.dart';
import '../widget/item_podcast_category.dart';
import '../widget/item_recent_podcast.dart';

class PodCastScreen extends StatefulWidget {
  const PodCastScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PodCastScreenState();
}

class _PodCastScreenState extends State<PodCastScreen> {
  final PodCastController _controller = Get.isRegistered<PodCastController>()
      ? Get.find<PodCastController>()
      : Get.put(PodCastController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getPodCastApi();
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
                title: AppStrings.podCast,
                isBackButtonVisible: true,
                isNotificationButtonVisible: true,
              ),
              Expanded(
                child: Obx(() {
                  debugPrint(
                      'length:-  ${_controller.recentDataList.length} ${_controller.continueListeningDataList.length} ${_controller.categoryDataList.length}');

                  if (_controller.showLoader.value) {
                    return const SizedBox();
                  }

                  if (!_controller.showLoader.value &&
                      _controller.recentDataList.isEmpty &&
                      _controller.continueListeningDataList.isEmpty &&
                      _controller.categoryDataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () {
                        _controller.getPodCastApi();
                      },
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => _controller.getPodCastApi(isLoader: false),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _controller.continueListeningDataList.isNotEmpty
                              ? Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 20.h, 20.h, 0),
                                  child: AppText(
                                    text: AppStrings.continueListening,
                                    textSize: 18.sp,
                                    color: AppColor.black,
                                    maxLines: 2,
                                    lineHeight: 1.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height:
                                _controller.continueListeningDataList.isNotEmpty
                                    ? 190.h
                                    : 0,
                            width: Get.width,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: ClampingScrollPhysics()),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller
                                    .continueListeningDataList.length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                itemBuilder: (BuildContext context, int index) {
                                  PodcastElement item = _controller
                                      .continueListeningDataList[index];
                                  return ItemRecentPodCast(
                                      item: item, onPressed: () {});
                                }),
                          ),
                          _controller.recentDataList.isNotEmpty
                              ? Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 0, 20.h, 0),
                                  child: AppText(
                                    text: AppStrings.recent,
                                    textSize: 18.sp,
                                    color: AppColor.black,
                                    maxLines: 2,
                                    lineHeight: 1.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: _controller.recentDataList.isNotEmpty
                                ? 190.h
                                : 0,
                            width: Get.width,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: ClampingScrollPhysics()),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller.recentDataList.length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                itemBuilder: (BuildContext context, int index) {
                                  PodcastElement item =
                                      _controller.recentDataList[index];
                                  return ItemRecentPodCast(
                                      item: item, onPressed: () => Get.to(PodCastDetailScreen(item: item)));
                                }),
                          ),
                          _controller.categoryDataList.isNotEmpty
                              ? Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 0, 20.h, 0),
                                  child: AppText(
                                    text: AppStrings.category,
                                    textSize: 18.sp,
                                    color: AppColor.black,
                                    maxLines: 2,
                                    lineHeight: 1.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: _controller.categoryDataList.isNotEmpty
                                ? 190.h
                                : 0,
                            width: Get.width,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: ClampingScrollPhysics()),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller.categoryDataList.length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                itemBuilder: (BuildContext context, int index) {
                                  PodCastCategoryElement item =
                                      _controller.categoryDataList[index];
                                  return ItemPodCastCategory(
                                    item: item,
                                    onPressed: () => Get.to(PodCastContentScreen(item: item)),
                                  );
                                }),
                          ),
                        ],
                      ),
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
