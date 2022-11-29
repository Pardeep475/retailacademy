import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_images.dart';
import '../../../../common/app_strings.dart';
import '../../../../common/widget/app_button.dart';
import '../../../../common/widget/app_text_field.dart';
import '../controller/help_and_contact_retail_controller.dart';

class HelpAndContactRetailScreen extends StatelessWidget {
  final int screenType;

  HelpAndContactRetailScreen({required this.screenType, Key? key})
      : super(key: key);

  final HelpAndContactRetailController _controller =
      Get.isRegistered<HelpAndContactRetailController>()
          ? Get.find<HelpAndContactRetailController>()
          : Get.put(HelpAndContactRetailController());

  final TextEditingController _txtController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: Get.height * 0.35,
                      color: AppColor.black,
                      child: Image.asset(
                        AppImages.imgLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: AppTextField(
                        placeHolder: AppStrings.typeHere,
                        controller: _txtController,
                        minLines: 5,
                        maxLines: 5,
                        validator: (value) => _controller.validateValue(
                            value: value, screenType: screenType),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16.w, 0, 16.h, 10.h),
                      child: AppButton(
                        txt: AppStrings.send,
                        onPressed: () => _submitClickListener(),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ),
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
          Positioned(
            left: 10,
            top: (kToolbarHeight / 2),
            child: IconButton(
              onPressed: () => Get.back(),
              splashColor: Colors.white54,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submitClickListener() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formGlobalKey.currentState!.validate()) {
      _controller.helpApi(
          txt: _txtController.text.toString(), screenType: screenType);
    }
  }
}
