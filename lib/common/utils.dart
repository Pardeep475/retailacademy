import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'app_color.dart';
import 'app_strings.dart';
import 'local_storage/session_manager.dart';
import 'widget/app_text.dart';

class Utils {
  static final Utils _utils = Utils._internal();

  factory Utils() {
    return _utils;
  }

  Utils._internal();

  static double appBarHeightMargin = 77.h;

  static var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
  );

  static errorSnackBar(String title, String message, {bool isSuccess = false}) {
    Get.snackbar(
      title,
      message,
      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
      backgroundColor: isSuccess
          ? AppColor.greenKnowledge.withOpacity(0.9)
          : AppColor.red.withOpacity(0.9),
      borderRadius: 5.sp,
      snackPosition: SnackPosition.BOTTOM,
      colorText: AppColor.red,
      titleText: AppText(
        text: title,
        color: Colors.white,
        fontFamily: AppStrings.robotoFont,
        fontWeight: FontWeight.w700,
        lineHeight: 1.6,
        textAlign: TextAlign.start,
        textSize: 18.sp,
      ),
      messageText: AppText(
        text: message,
        color: Colors.white,
        fontFamily: AppStrings.robotoFont,
        fontWeight: FontWeight.w400,
        lineHeight: 1.6,
        maxLines: 4,
        textAlign: TextAlign.start,
        textSize: 18.sp,
      ),
    );
  }

  static Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        Utils.errorSnackBar(
            AppStrings.error, AppStrings.checkYourInternetConnectivity);
        return false;
      }
    } on SocketException catch (_) {
      Utils.errorSnackBar(
          AppStrings.error, AppStrings.checkYourInternetConnectivity);
      return false;
    }
  }

  // date format like 1967-6-7
  static DateTime stringToDateOtherFormat({var selectedDate}) {
    try {
      DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(selectedDate /*, isUtc: true*/);
      debugPrint("date time :-   $dateTime");
      return dateTime;
      // DateFormat originalFormat = new DateFormat("dd/MM/yyyy");
      // DateFormat targetFormat = new DateFormat("yyyy-MM-dd hh:mm:ss");
      // DateTime date = originalFormat.parse(selectedDate);
      // String formattedDate = targetFormat.format(date.toLocal());
      // return DateTime.parse(formattedDate);
    } catch (e) {
      return DateTime.now();
    }
  }

  // date format like 1967-6-7
  static DateTime stringToDateOtherFormatString({var selectedDate}) {
    try {
      // DateFormat originalFormat = new DateFormat("dd/MM/yyyy");
      // DateFormat targetFormat = new DateFormat("yyyy-MM-dd hh:mm:ss");
      // DateTime date = originalFormat.parse(selectedDate);
      // String formattedDate = targetFormat.format(date.toLocal());
      // return DateTime.parse(formattedDate);
      return DateTime.parse(selectedDate);
    } catch (e) {
      return DateTime.now();
    }
  }

  /*static Future<Escort?> getUserData() async {
    String? value = await SessionManager.getUserData();
    if (value != null) {
      return escortResponseFromJson(value);
    } else {
      return null;
    }
  }*/

  static bool isSameDate(String other) {
    var dateTime = DateFormat("dd-MMM-yyyy HH:mm:ss").parse(other);
    var now = DateTime.now();

    return now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;
  }

  static bool isSameDateFromDateTime(DateTime dateTime) {
    var now = DateTime.now();

    return now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;
  }

  /// Find the first date of the week which contains the provided date.
  static DateTime findFirstDateOfTheWeek() {
    DateTime dateTime = DateTime.now();
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  /// Find last date of the week which contains provided date.
  static DateTime findLastDateOfTheWeek() {
    DateTime dateTime = DateTime.now();
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static bool checkIfDatesExistInCurrentWeek(DateTime currentDate) {
    DateTime firstDate = findFirstDateOfTheWeek();
    DateTime lastDate = findLastDateOfTheWeek();

    return currentDate.isAfter(firstDate.subtract(const Duration(days: 1))) &&
        currentDate.isBefore(lastDate);

    // return (firstDate.isAfter(currentDate) && lastDate.isBefore(currentDate));
  }

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static bool isVideo(String path) {
    if (path.toUpperCase().contains('MP4') ||
        path.toUpperCase().contains('MOV') ||
        path.toUpperCase().contains('WMV') ||
        path.toUpperCase().contains('AVI') ||
        path.toUpperCase().contains('MKV') ||
        path.toUpperCase().contains('MPEG-2') ||
        path.toUpperCase().contains('WEBM') ||
        path.toUpperCase().contains('AVCHD')) {
      return true;
    }
    return false;
  }
}
