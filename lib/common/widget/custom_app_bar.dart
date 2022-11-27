import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/routes/route_strings.dart';
import 'package:retail_academy/common/widget/app_text.dart';

import '../app_color.dart';
import '../app_strings.dart';
import 'app_text_field.dart';


class CustomAppBar extends StatefulWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final String points;
  final bool isSearchButtonVisible;
  final bool isBackButtonVisible;
  final bool isNotificationButtonVisible;
  final bool isSearchWidgetVisible;
  final Function(String)? onSearchChanged;
  final TextEditingController? searchController;
  final bool isIconsTitle;
  final bool isVideoComponent;
  final int animationDurationInMilli;
  final TextStyle? style;
  final String helpText;
  final TextEditingController? textController;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onCrossClick;

   const CustomAppBar(
      {required this.title,
      this.onBackPressed,
      this.points = '00',
      this.isSearchButtonVisible = false,
      this.isBackButtonVisible = false,
      this.isNotificationButtonVisible = false,
      this.searchController,
      this.isSearchWidgetVisible = false,
      this.isIconsTitle = false,
      this.textController,
      this.isVideoComponent = false,
      this.onSearchChanged,
      this.animationDurationInMilli = 375,
      this.helpText = "Search...",
      this.style,
      this.inputFormatters,
      this.onChanged,
      this.onEditingComplete,
      this.onCrossClick,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomAppBarState();
}

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  _unFocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.animationDurationInMilli),
      curve: Curves.easeOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: kToolbarHeight *
                (widget.isBackButtonVisible ||
                        widget.isNotificationButtonVisible ||
                        widget.isSearchButtonVisible
                    ? 0.7
                    : 0.8),
          ),
          toggle == 0
              ? Row(
                  children: [
                    widget.isBackButtonVisible
                        ? IconButton(
                            onPressed: widget.onBackPressed ?? () => Get.back(),
                            splashColor: Colors.white54,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: widget.isVideoComponent
                                  ? AppColor.white
                                  : AppColor.black,
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.isNotificationButtonVisible ||
                                  widget.isVideoComponent
                              ? const SizedBox()
                              : AppText(
                                  text:
                                      "${AppStrings.pointConstant} ${AppStrings.points}",
                                  textSize: 18.sp,
                                  color: widget.isVideoComponent
                                      ? AppColor.white
                                      : AppColor.black,
                                  fontWeight: FontWeight.w600,
                                ),
                          widget.isNotificationButtonVisible
                              ? const SizedBox()
                              : widget.isSearchButtonVisible
                                  ? IconButton(
                                      onPressed: () {
                                        ///if the search bar is closed
                                        if (toggle == 0) {
                                          toggle = 1;
                                          setState(() {
                                            ///if the autoFocus is true, the keyboard will pop open, automatically
                                            FocusScope.of(context)
                                                .requestFocus(focusNode);
                                          });

                                          ///forward == expand
                                          _con.forward();
                                        }
                                      },
                                      splashColor: Colors.white54,
                                      icon: Icon(
                                        Icons.search_sharp,
                                        color: widget.isVideoComponent
                                            ? AppColor.white
                                            : AppColor.black,
                                      ),
                                    )
                                  : const SizedBox(),
                          widget.isNotificationButtonVisible
                              ? IconButton(
                                  onPressed: () {
                                    Get.toNamed(RouteString.notificationScreen);
                                  },
                                  splashColor: Colors.white54,
                                  icon: Icon(
                                    Icons.notifications_none_outlined,
                                    color: widget.isVideoComponent
                                        ? AppColor.white
                                        : AppColor.black,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: widget.isSearchButtonVisible ||
                              widget.isNotificationButtonVisible
                          ? 0
                          : 20.w,
                    ),
                  ],
                )
              : Visibility(
                  visible: toggle == 1,
                  child: Row(
                    children: [
                      IconButton(
                        ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                        ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                        ///prefixIcon is of type Icon
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(
                            () {
                              if (toggle == 1) {
                                ///if the search bar is expanded
                                toggle = 0;

                                ///if the autoFocus is true, the keyboard will close, automatically
                                setState(() {
                                  _unFocusKeyboard();
                                });

                                ///reverse == close
                                _con.reverse();
                              }
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: AppTextField(
                          placeHolder: widget.helpText,
                          controller: widget.textController,
                          isChangePadding: true,
                          isBorderRequired: false,
                          validator: (value) {},
                          onChanged: (value) => widget.onChanged == null
                              ? null
                              : widget.onChanged!(value),
                          onEditingComplete: widget.onEditingComplete,
                          // _controller.validateEmail(value: value),
                        ),
                      ),
                      IconButton(
                        ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                        ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                        ///prefixIcon is of type Icon
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(
                            () {
                              if (widget.textController != null &&
                                  widget.onCrossClick != null) {
                                widget.textController!.clear();
                                widget.onCrossClick!();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
          SizedBox(
            height: widget.isBackButtonVisible ? 0 : 10.h,
          ),
          widget.isIconsTitle
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mic,
                      color: widget.isVideoComponent
                          ? AppColor.white
                          : AppColor.black,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    AppText(
                      text: widget.title,
                      textSize: 25.sp,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      color: widget.isVideoComponent
                          ? AppColor.white
                          : AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                )
              : AppText(
                  text: widget.title,
                  textSize: 25.sp,
                  maxLines: 2,
                  color:
                      widget.isVideoComponent ? AppColor.white : AppColor.black,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    debugPrint("dispose_method_call  deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    _con.dispose();
    debugPrint("dispose_method_call");
    super.dispose();

  }

}
