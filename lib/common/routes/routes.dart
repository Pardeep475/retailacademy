import 'package:get/get.dart';
import 'package:retail_academy/app/auth/login/page/forgot_password_screen.dart';
import 'package:retail_academy/app/knowledge/page/fun_facts_and_master_class_screen.dart';
import 'package:retail_academy/app/knowledge/page/whats_hot_blog_screen.dart';
import 'package:retail_academy/common/routes/route_strings.dart';

import '../../app/auth/login/page/login_screen.dart';
import '../../app/auth/splash/page/splash_screen.dart';
import '../../app/dashboard/page/dashboard_screen.dart';
import '../../app/knowledge/page/fun_facts_and_master_class_content_screen.dart';
import '../../app/knowledge/page/whats_hot_blog_content_screen.dart';

class Routes {
  static List<GetPage>? generateRoute() {
    return [
      GetPage(
        name: RouteString.splashScreen,
        page: () => SplashScreen(),
      ),
      GetPage(
        name: RouteString.loginScreen,
        page: () => LoginScreen(),
      ),
      GetPage(
        name: RouteString.dashBoardScreen,
        page: () => const DashboardScreen(),
      ),
      GetPage(
        name: RouteString.funFactsAndMasterClassScreen,
        page: () => const FunFactsAndMasterClassScreen(),
      ),
      GetPage(
        name: RouteString.funFactsAndMasterClassContentScreen,
        page: () => const FunFactsAndMasterClassContentScreen(),
      ),
      GetPage(
        name: RouteString.forgotPasswordScreen,
        page: () => ForgotPasswordScreen(),
      ),
      GetPage(
        name: RouteString.whatsHotBlogScreen,
        page: () => const WhatsHotBlogScreen(),
      ),
      GetPage(
        name: RouteString.whatsHotBlogContentScreen,
        page: () => const WhatsHotBlogContentScreen(),
      ),
    ];
  }
}
