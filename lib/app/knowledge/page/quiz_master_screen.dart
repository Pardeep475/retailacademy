import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/page/quiz_master_detail_screen.dart';
import 'package:retail_academy/app/knowledge/widget/item_quiz_master.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/alert_dialog_box.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/knowledge/quiz_category_response.dart';
import '../controller/quiz_master_controller.dart';

class QuizMasterScreen extends StatefulWidget {
  const QuizMasterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizMasterScreenState();
}

class _QuizMasterScreenState extends State<QuizMasterScreen> {
  Color? color;

  final QuizMasterController _controller =
      Get.isRegistered<QuizMasterController>()
          ? Get.find<QuizMasterController>()
          : Get.put(QuizMasterController());

  @override
  void initState() {
    Map<String, dynamic> value = Get.arguments;
    color = value['color'];
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.getQuizMasterApi();
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

                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () => _controller.getQuizMasterApi(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.getQuizMasterApi(isLoader: false),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: _controller.dataList.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        itemBuilder: (BuildContext context, int index) {
                          QuizCategoryElement item =
                              _controller.dataList[index];
                          return ItemQuizMaster(
                            item: item,
                            color: color ?? AppColor.pinkKnowledge,
                            onItemPressed: () {
                              // if (item.isAttempted) {
                              //   openAlreadySubmittedDialogBox(
                              //       title: item.categoryName);
                              // } else {
                              Get.to(() => QuizMasterDetailScreen(
                                    item: item,
                                    color: color ?? AppColor.pinkKnowledge,
                                  ));
                              // }
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

  openAlreadySubmittedDialogBox({required String title}) {
    AlertDialogBox(
      showCrossIcon: true,
      context: context,
      barrierDismissible: true,
      padding: EdgeInsets.zero,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h,
              ),
              AppText(
                text: AppStrings.alert,
                textSize: 22.sp,
                color: AppColor.black,
                maxLines: 2,
                lineHeight: 1.3,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 15.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppText(
                text: '\'$title\' ${AppStrings.quizAlreadyAttempted}',
                textSize: 18.sp,
                color: AppColor.black,
                maxLines: 2,
                textAlign: TextAlign.center,
                lineHeight: 1.3,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    child: AppText(
                      text: AppStrings.ok,
                      textSize: 18.sp,
                      color: Colors.lightBlue,
                      maxLines: 2,
                      lineHeight: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).show();
  }
}
