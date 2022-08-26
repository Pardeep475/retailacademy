import 'package:get/get.dart';
import 'package:retail_academy/app/auth/login/page/forgot_password_screen.dart';
import 'package:retail_academy/app/knowledge/page/fun_facts_and_master_class_screen.dart';
import 'package:retail_academy/common/routes/route_strings.dart';

import '../../app/auth/login/page/login_screen.dart';
import '../../app/auth/splash/page/splash_screen.dart';
import '../../app/dashboard/page/dashboard_screen.dart';

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
        page: () => DashboardScreen(),
      ),
      GetPage(
        name: RouteString.funFactsAndMasterClassScreen,
        page: () => FunFactsAndMasterClassScreen(),
      ),
      GetPage(
        name: RouteString.forgotPasswordScreen,
        page: () => ForgotPasswordScreen(),
      ),
    ];
  }
}
