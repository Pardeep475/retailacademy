import 'package:get/get.dart';
import 'package:retail_academy/app/auth/login/controller/forgot_password_controller.dart';
import 'package:retail_academy/app/auth/login/controller/help_and_contact_retail_controller.dart';
import 'package:retail_academy/app/comment/controller/trending_comment_controller.dart';
import 'package:retail_academy/app/home/controller/home_controller.dart';
import 'package:retail_academy/app/home/controller/trending_detail_controller.dart';
import 'package:retail_academy/app/info_sessions/controller/info_sessions_controller.dart';
import 'package:retail_academy/app/knowledge/controller/fun_facts_and_master_class_controller.dart';
import 'package:retail_academy/app/knowledge/controller/knowledge_controller.dart';
import 'package:retail_academy/app/knowledge/controller/pod_cast_content_controller.dart';
import 'package:retail_academy/app/knowledge/controller/pod_cast_controller.dart';
import 'package:retail_academy/app/knowledge/controller/pod_cast_detail_controller.dart';
import 'package:retail_academy/app/knowledge/controller/quiz_master_controller.dart';
import 'package:retail_academy/app/knowledge/controller/whats_hot_blog_controller.dart';
import 'package:retail_academy/app/profile/controller/profile_controller.dart';
import 'package:retail_academy/app/retails_reels/controller/retail_reels_content_controller.dart';
import 'package:retail_academy/app/retails_reels/controller/retail_reels_controller.dart';
import '../../app/auth/login/controller/login_controller.dart';
import '../../app/auth/splash/controller/splash_controller.dart';
import '../../app/dashboard/controller/dashboard_controller.dart';
import '../../app/knowledge/controller/fun_facts_and_master_class_content_controller.dart';
import '../../app/knowledge/controller/fun_facts_and_master_class_detail_controller.dart';
import '../../app/knowledge/controller/quiz_master_detail_controller.dart';
import '../../app/knowledge/controller/whats_hot_blog_content_controller.dart';
import '../../app/retails_reels/controller/retail_reels_detail_controller.dart';
import 'binding_consts.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(),
        tag: BindingConst.splashScreenBinding);
    Get.lazyPut(() => LoginController(), tag: BindingConst.loginScreenBinding);
    Get.lazyPut(() => DashboardController(),
        tag: BindingConst.dashboardScreenBinding);
    Get.lazyPut(() => HomeController(), tag: BindingConst.homeScreenBinding);
    Get.lazyPut(() => KnowledgeController(),
        tag: BindingConst.knowledgeScreenBinding);
    Get.lazyPut(() => RetailReelsController(),
        tag: BindingConst.retailReelsScreenBinding);
    Get.lazyPut(() => RetailReelsContentController(),
        tag: BindingConst.retailReelsContentScreenBinding);
    Get.lazyPut(() => RetailReelsDetailController(),
        tag: BindingConst.retailReelsDetailScreenBinding);
    Get.lazyPut(() => InfoSessionsController(),
        tag: BindingConst.infoSessionsScreenBinding);
    Get.lazyPut(() => ProfileController(),
        tag: BindingConst.profileScreenBinding);
    Get.lazyPut(() => FunFactsAndMasterClassController(),
        tag: BindingConst.funFactsAndMasterClassScreenBinding);
    Get.lazyPut(() => FunFactsAndMasterClassContentController(),
        tag: BindingConst.funFactsAndMasterClassContentScreenBinding);
    Get.lazyPut(() => FunFactsAndMasterClassDetailController(),
        tag: BindingConst.funFactsAndMasterClassDetailScreenBinding);
    Get.lazyPut(() => ForgotPasswordController(),
        tag: BindingConst.forgotPasswordScreenBinding);
    Get.lazyPut(() => WhatsHotBlogController(),
        tag: BindingConst.whatsHotBlogScreenBinding);
    Get.lazyPut(() => WhatsHotBlogContentController(),
        tag: BindingConst.whatsHotBlogContentScreenBinding);
    Get.lazyPut(() => PodCastController(),
        tag: BindingConst.podCastScreenBinding);
    Get.lazyPut(() => PodCastContentController(),
        tag: BindingConst.podCastContentScreenBinding);
    Get.lazyPut(() => PodCastDetailController(),
        tag: BindingConst.podCastDetailScreenBinding);
    Get.lazyPut(() => QuizMasterController(),
        tag: BindingConst.quizMasterScreenBinding);
    Get.lazyPut(() => QuizMasterDetailController(),
        tag: BindingConst.quizMasterDetailScreenBinding);
    Get.lazyPut(() => HelpAndContactRetailController(),
        tag: BindingConst.helpAndContactRetailScreenBinding);
    Get.lazyPut(() => TrendingDetailController(),
        tag: BindingConst.trendingDetailScreenBinding);
    Get.lazyPut(() => TrendingCommentController(),
        tag: BindingConst.commentScreenBinding);
  }
}
