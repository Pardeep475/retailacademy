import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/dashboard/controller/dashboard_controller.dart';
import 'package:retail_academy/app/home/page/home_screen.dart';
import 'package:retail_academy/app/info_sessions/page/info_sessions_screen.dart';
import 'package:retail_academy/app/knowledge/page/knowledge_screen.dart';
import 'package:retail_academy/app/profile/page/profile_screen.dart';
import 'package:retail_academy/app/retails_reels/page/retail_reels_screen.dart';
import 'package:retail_academy/common/app_color.dart';
import 'package:retail_academy/common/widget/app_text.dart';

import '../../../common/app_strings.dart';

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
    KnowledgeScreen(),
    RetailReelsScreen(),
    InfoSessionsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      body: SafeArea(
        top: false,
        // child: contentList[_selectedIndex],
        child: Obx(
          () => IndexedStack(
            index: _controller.currentSelectedIndex.value,
            children: contentList,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    const Icon(
                      Icons.home_filled,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AppText(
                      text: AppStrings.home,
                      color: AppColor.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _controller.currentSelectedIndex.value = 1,
                splashColor: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    const Icon(
                      Icons.work_outline_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AppText(
                      text: AppStrings.knowledge,
                      color: AppColor.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _controller.currentSelectedIndex.value = 2,
                splashColor: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    const Icon(
                      Icons.widgets_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AppText(
                      text: AppStrings.reels,
                      color: AppColor.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _controller.currentSelectedIndex.value = 3,
                splashColor: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AppText(
                      text: AppStrings.infoSessions,
                      color: AppColor.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _controller.currentSelectedIndex.value = 4,
                splashColor: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    const Icon(
                      Icons.language,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const AppText(
                      text: AppStrings.profile,
                      color: AppColor.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
