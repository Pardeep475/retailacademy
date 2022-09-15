import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/widget/item_pod_cast.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/pod_cast_controller.dart';

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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // _controller.getTrendingApi();
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
                  debugPrint('length:-  ${_controller.dataList.length}');
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: ClampingScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.h, 0),
                          child: AppText(
                            text: 'Continue Listening',
                            textSize: 18.sp,
                            color: AppColor.black,
                            maxLines: 2,
                            lineHeight: 1.3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 190.h,
                          width: Get.width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: ClampingScrollPhysics()),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 10 /*_controller.dataList.length*/,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 20.h),
                              itemBuilder: (BuildContext context, int index) {
                                return const ItemPodCast();
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 0, 20.h, 0),
                          child: AppText(
                            text: 'Continue Listening',
                            textSize: 18.sp,
                            color: AppColor.black,
                            maxLines: 2,
                            lineHeight: 1.3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 190.h,
                          width: Get.width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: ClampingScrollPhysics()),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 10 /*_controller.dataList.length*/,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 20.h),
                              itemBuilder: (BuildContext context, int index) {
                                return const ItemPodCast();
                              }),
                        ),
                      ],
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
