import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:retail_academy/app/dashboard/controller/dashboard_controller.dart';
import 'package:retail_academy/app/home/page/home_screen.dart';
import 'package:retail_academy/app/info_sessions/page/info_sessions_screen.dart';
import 'package:retail_academy/app/knowledge/knowledge_navigation/knowledge_navigation.dart';
import 'package:retail_academy/app/profile/page/profile_screen.dart';
import 'package:retail_academy/common/app_color.dart';
import '../../../common/app_images.dart';
import '../../knowledge/knowledge_navigation/knowledge_wrapper.dart';
import '../../retails_reels/retails_reels_navigation/retail_reels_navigation.dart';
import '../../retails_reels/retails_reels_navigation/retail_reels_wrapper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController _controller =
      Get.isRegistered<DashboardController>()
          ? Get.find<DashboardController>()
          : Get.put(DashboardController());

  final contentList = const [
    HomeScreen(),
    KnowledgeWrapper(),
    RetailReelsWrapper(),
    InfoSessionsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearAllData();
      _showForceUpdateDialog();
      _controller.maintenanceMessageApi();
    });
  }

  void _showForceUpdateDialog() async {
    final newVersion = NewVersion(
      iOSId: 'com.cwretailservices.staffapp',
      androidId: 'cy.com.cap.academy4',
    //
    );
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Custom Title',
        dialogText: 'Custom Text',
      );
    }
  }

  Future<bool> stackBackPressed() async {
    try {
      var value = await Get
          .keys[_controller.currentSelectedIndex.value == 2
              ? RetailReelsNavigation.id
              : KnowledgeNavigation.id]!
          .currentState!
          .maybePop();
      if (!value) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // error
      debugPrint('ErrorWhileNavigation:----  $e');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: stackBackPressed,
      child: Scaffold(
        bottomNavigationBar: buildMyNavBar(context),
        body: SafeArea(
          top: false,
          // child: contentList[_selectedIndex],
          child: Obx(
            () => /*IndexedStack(
              index: _controller.currentSelectedIndex.value,
              children: contentList,
            )*/
                contentList[_controller.currentSelectedIndex.value],
          ),
        ),
      ),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Container(
      height: 80.h,
      color: AppColor.black,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => _controller.currentSelectedIndex.value = 0,
                  splashColor: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Image.asset(
                      AppImages.iconHome,
                      fit: BoxFit.contain,
                    ),
                  )
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 8.h,
                  //     ),
                  //     const Icon(
                  //       Icons.home_filled,
                  //       color: Colors.white,
                  //       size: 24,
                  //     ),
                  //     SizedBox(
                  //       height: 5.h,
                  //     ),
                  //     const AppText(
                  //       text: AppStrings.home,
                  //       color: AppColor.white,
                  //     )
                  //   ],
                  // ),
                  ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => _controller.currentSelectedIndex.value = 1,
                  splashColor: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Image.asset(
                      AppImages.iconKnowledge,
                      fit: BoxFit.contain,
                    ),
                  )
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 8.h,
                  //     ),
                  //     const Icon(
                  //       Icons.work_outline_outlined,
                  //       color: Colors.white,
                  //       size: 24,
                  //     ),
                  //     SizedBox(
                  //       height: 5.h,
                  //     ),
                  //     const AppText(
                  //       text: AppStrings.knowledge,
                  //       color: AppColor.white,
                  //     )
                  //   ],
                  // ),
                  ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => _controller.currentSelectedIndex.value = 2,
                  splashColor: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(7.r),
                    child: Image.asset(
                      AppImages.iconReels,
                      fit: BoxFit.contain,
                    ),
                  )
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 8.h,
                  //     ),
                  //     const Icon(
                  //       Icons.widgets_outlined,
                  //       color: Colors.white,
                  //       size: 24,
                  //     ),
                  //     SizedBox(
                  //       height: 5.h,
                  //     ),
                  //     const AppText(
                  //       text: AppStrings.reels,
                  //       color: AppColor.white,
                  //     )
                  //   ],
                  // ),
                  ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => _controller.currentSelectedIndex.value = 3,
                  splashColor: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Image.asset(
                      AppImages.iconInfo,
                      fit: BoxFit.contain,
                    ),
                  )
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 8.h,
                  //     ),
                  //     const Icon(
                  //       Icons.person_outline,
                  //       color: Colors.white,
                  //       size: 24,
                  //     ),
                  //     SizedBox(
                  //       height: 5.h,
                  //     ),
                  //     const AppText(
                  //       text: AppStrings.infoSessions,
                  //       color: AppColor.white,
                  //     )
                  //   ],
                  // ),
                  ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _controller.currentSelectedIndex.value = 4,
                splashColor: Colors.white54,
                child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Image.asset(
                    AppImages.iconProfile,
                    fit: BoxFit.contain,
                  ),
                ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       height: 8.h,
                //     ),
                //     const Icon(
                //       Icons.language,
                //       color: Colors.white,
                //       size: 24,
                //     ),
                //     SizedBox(
                //       height: 5.h,
                //     ),
                //     const AppText(
                //       text: AppStrings.profile,
                //       color: AppColor.white,
                //     )
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
