import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_images.dart';
import 'package:retail_academy/common/local_storage/session_manager.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/profile_controller.dart';
import '../widget/item_custom_button_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _controller = Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const CustomAppBar(
                title: AppStrings.profile,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "http://via.placeholder.com/200x150",
                      height: Get.height * 0.3,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 36.r,
                            width: 36.r,
                            child: const CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.grey),
                        child: SvgPicture.asset(
                          AppImages.iconUserImagePlaceHolder,
                          height: Get.height * 0.2,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ItemCustomButtonProfile(
                      title: AppStrings.staffName,
                      onPressed: () {},
                    ),
                    ItemCustomButtonProfile(
                      title: AppStrings.storeName,
                      onPressed: () {},
                    ),
                    ItemCustomButtonProfile(
                      title: AppStrings.staffIdNumber,
                      onPressed: () {},
                    ),
                    ItemCustomButtonProfile(
                      title: AppStrings.emailAddress,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              RichText(
                overflow: TextOverflow.clip,
                textAlign: TextAlign.end,
                softWrap: true,
                maxLines: 1,
                text: TextSpan(
                  text: AppStrings.needToEditProfile,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColor.black,
                      fontFamily: AppStrings.robotoFont),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppStrings.contactRetailTeam,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('Tap Here onTap');
                        },
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: Colors.lightBlueAccent,
                          fontFamily: AppStrings.robotoFont),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  ItemCustomButtonProfile(
                    title: AppStrings.logout,
                    textSize: 20.sp,
                    onPressed: () => _controller.logoutApi(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        AppText(
                          text: AppStrings.notification,
                          textSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Obx(() {
                          return CupertinoSwitch(
                            value: _controller.notificationSwitchEnabled.value,
                            activeColor: AppColor.black,
                            onChanged: (bool? value) {
                              _controller
                                  .updateNotificationSwitch(value ?? false);
                            },
                          );
                        }),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                  )
                ],
              )
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
