import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/network/modal/trending/trending_response.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/home_controller.dart';
import '../widgets/item_trending.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.getTrendingApi();
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
                title: AppStrings.trending,
              ),
              Expanded(
                child: Obx(() {
                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.getTrendingApi(isLoader: false),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: _controller.dataList.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        itemBuilder: (BuildContext context, int index) {
                          ActivityStream item = _controller.dataList[index];
                          return ItemTrending(
                            item: item,
                            onLikeButtonPressed: () {
                              _controller.trendingLikeApi(
                                  index: index,
                                  activityStreamId: item.activityStreamId);
                            },
                          );
                        }),
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
