import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/alert_dialog_box.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/knowledge/quiz_category_response.dart';
import '../../../network/modal/notification/notification_list_response.dart';
import '../../knowledge/page/fun_facts_and_master_class_detail_screen.dart';
import '../../knowledge/page/quiz_master_detail_screen.dart';
import '../controller/notification_controller.dart';
import '../widget/item_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController _controller =
      Get.isRegistered<NotificationController>()
          ? Get.find<NotificationController>()
          : Get.put(NotificationController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearAllData();
      _controller.getNotificationApi();
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
                title: AppStrings.notification,
                isBackButtonVisible: true,
              ),
              Expanded(
                child: Obx(() {
                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () => _controller.getNotificationApi(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.getNotificationApi(isLoader: false),
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: _controller.dataList.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        itemBuilder: (BuildContext context, int index) {
                          NotificationElement notificationEntity =
                              _controller.dataList[index];
                          return ItemNotification(
                            item: notificationEntity,
                            onPressed: () {
                              _onNotificationClickEvent(
                                  item: notificationEntity);
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

  _onNotificationClickEvent({required NotificationElement item}) {
    switch (item.moduleName) {
      case NotificationType.reels:
        {
          // needs to change in blog detail item
        }
        break;
      case NotificationType.content:
        {
          Get.to(
                () => FunFactsAndMasterClassDetailScreen(
              fileId: item.moduleId.toString(),
              quizId: 0,
              quizName: '',
              isTrending: true,
            ),
          );
        }
        break;
      case NotificationType.quiz:
        {
          _quizNavigation(value: item);
        }
        break;
      case NotificationType.blog:
        {
          // needs to change in blog detail item
        }
        break;
      case NotificationType.info:
        {}
        break;
      case NotificationType.message:
        {}
        break;
      case NotificationType.podcast:
        {
          // needs to change in blog detail item
        }
        break;
      default:
        {}
    }
  }

  void _quizNavigation({required NotificationElement value}) async{
    QuizCategoryElement? item = await _controller
        .getQuizMasterApi(quizId: value.moduleId);
    if (item == null) {
      Get.to(
            () => QuizMasterDetailScreen(
          quizId: value.moduleId,
          quizName: value.message,
        ),
      );
    } else {
      if (item.isAttempted) {
        openAlreadySubmittedDialogBox(
            title: item.categoryName);
      } else {
        Get.to(
              () => QuizMasterDetailScreen(
                quizId: value.moduleId,
                quizName: value.message,
          ),
        );
      }
    }
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
