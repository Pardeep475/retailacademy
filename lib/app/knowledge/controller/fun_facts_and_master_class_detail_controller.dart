import 'package:get/get.dart';
import '../../../common/utils.dart';


class FunFactsAndMasterClassDetailController extends GetxController {
  var showLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
    Utils.logger.e("on init");
  }

  @override
  void onReady() {
    super.onReady();
    Utils.logger.e("on ready");
  }

  @override
  void onClose() {
    super.onClose();
    Utils.logger.e("on close");
  }
}
