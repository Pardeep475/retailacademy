import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'common/app_strings.dart';
import 'common/binding/application_binding.dart';
import 'common/local_storage/hive/answer_element_modal.dart';
import 'common/local_storage/hive/correct_answer_element_modal.dart';
import 'common/local_storage/hive/quiz_element_modal.dart';
import 'common/local_storage/hive/quiz_modal.dart';
import 'common/routes/route_strings.dart';
import 'common/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

/*
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // final document = await getApplicationDocumentsDirectory();
  // Hive
  //   ..init(document.path)
  //   ..registerAdapter(QuizModalAdapter())
  //   ..registerAdapter(QuizElementModalAdapter())
  //   ..registerAdapter(CorrectAnswerElementModalAdapter())
  //   ..registerAdapter(AnswerElementModalAdapter());

  // await Hive.openBox<QuizModal>(AppStrings.quizDataBaseName);

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
      AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          debugPrint('$request');
          return null;
        },
      ));
    }
  }

  // Locale locale = await fetchLanguage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF9FA0A5),
                  ),
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              backgroundColor: Colors.white),
          builder: (context, child) => Scaffold(
            // Global GestureDetector that will dismiss the keyboard
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: child,
            ),
          ),
          // defaultTransition: Transition.fadeIn,
          // transitionDuration: const Duration(milliseconds: 500),
          initialRoute: RouteString.splashScreen,
          initialBinding: ApplicationBinding(),
          getPages: Routes.generateRoute(),
        );
      },
    );
  }

}



