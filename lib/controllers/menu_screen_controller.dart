import 'package:get/get.dart';
import 'package:instagram_clone/controllers/reelcontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreencontroller.dart';

class MenuScreenController extends GetxController{
  final reelcontroller = Get.put(ReelController());
  final homecontroller = Get.put(HomeScreenController());


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Get.offAllNamed('/login');
  }
}