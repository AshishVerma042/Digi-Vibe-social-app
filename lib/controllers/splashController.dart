import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:instagram_clone/controllers/reelcontroller.dart';
import '../routes/RoutesClass.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {

  final ReelController reelController = Get.put(ReelController());

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    reelController.pauseAllVideos();
  }

  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed( Duration(seconds: 2));

    if (isLoggedIn== false) {
      Get.offAllNamed(RoutesClass.gotoLoginScreen());
    } else if (isLoggedIn) {
      Get.offAllNamed(RoutesClass.commonScreen);
    }
  }
}
