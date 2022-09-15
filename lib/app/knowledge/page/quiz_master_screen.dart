import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/widget/item_quiz_master.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/quiz_master_controller.dart';

class QuizMasterScreen extends StatefulWidget {
  const QuizMasterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizMasterScreenState();
}

class _QuizMasterScreenState extends State<QuizMasterScreen> {
  final QuizMasterController _controller =
      Get.isRegistered<QuizMasterController>()
          ? Get.find<QuizMasterController>()
          : Get.put(QuizMasterController());

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
                title: AppStrings.quizMaster,
                isBackButtonVisible: true,
                isSearchButtonVisible: true,
              ),
              Expanded(
                child: Obx(() {
                  debugPrint('length:-  ${_controller.dataList.length}');
                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.getQuizMasterApi(isLoader: false),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: 50 /*_controller.dataList.length*/,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        itemBuilder: (BuildContext context, int index) {
                          return const ItemQuizMaster();
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
