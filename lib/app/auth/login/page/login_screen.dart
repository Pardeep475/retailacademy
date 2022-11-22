import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/auth/login/page/help_and_contact_retail_screen.dart';
import '../../../../common/app_color.dart';
import '../../../../common/app_images.dart';
import '../../../../common/app_strings.dart';
import '../../../../common/routes/route_strings.dart';
import '../../../../common/widget/app_button.dart';
import '../../../../common/widget/app_text.dart';
import '../../../../common/widget/app_text_field.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController _controller = Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());

  final TextEditingController _emailController =
      TextEditingController(text: "15224");
  final TextEditingController _passwordController =
      TextEditingController(text: "feb12345");

  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 30.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: AppTextField(
                        placeHolder: AppStrings.userName,
                        controller: _emailController,
                        validator: (value) =>
                            _controller.validateEmail(value: value),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16.w, 0, 16.h, 20.h),
                      child: AppTextField(
                        placeHolder: AppStrings.password,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) =>
                            _controller.validatePassword(value: value),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16.w, 0, 16.h, 10.h),
                      child: AppButton(
                        txt: AppStrings.login,
                        onPressed: () => _loginClickListener(),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteString.forgotPasswordScreen);
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 20.w, 10.h),
                              child: const AppText(
                                  text: AppStrings.forgotPassword)),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            // help == 0, contact retail == 1
                            Get.to(() =>
                                HelpAndContactRetailScreen(screenType: 0));
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(20.w, 10.h, 0, 10.h),
                              child: const AppText(text: AppStrings.help)),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                      ],
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
        ],
      ),
    );
  }

  _loginClickListener() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formGlobalKey.currentState!.validate()) {
      _controller.fetchUserResponseApi(
          userName: _emailController.text.toString(),
          password: _passwordController.text.toString());
    }
  }
}
