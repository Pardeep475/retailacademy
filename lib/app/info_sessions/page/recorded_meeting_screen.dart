import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/widget/custom_app_bar.dart';

class RecordedMeetingScreen extends StatefulWidget {
  final String recordedMeetingUrl;
  final String recordedMeetingPassword;
  final String title;

  const RecordedMeetingScreen(
      {required this.recordedMeetingPassword,
      required this.recordedMeetingUrl,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecordedMeetingScreenState();
}

class _RecordedMeetingScreenState extends State<RecordedMeetingScreen> {
  var showLoader = true.obs;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppBar(
                title: widget.title,
                isBackButtonVisible: true,
              ),
              Expanded(
                child: InAppWebView(
                  key: webViewKey,
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(widget.recordedMeetingUrl)),
                  // initialUrlRequest:
                  // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
                  // initialFile: "assets/index.html",
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) async {
                    setState(() {});
                  },

                  onLoadStop: (controller, url) async {
                    showLoader.value = false;
                  },
                  onUpdateVisitedHistory: (controller, url, isReload) {},
                  onConsoleMessage: (controller, consoleMessage) {
                    debugPrint('$consoleMessage');
                  },
                ),
              ),
            ],
          ),
          Obx(
            () => Positioned.fill(
              child: showLoader.value
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
