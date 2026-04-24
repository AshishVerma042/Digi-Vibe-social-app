import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/RoutesClass.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final RxBool isLoading = false.obs;

  Future<void> loginUser() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    await Future.delayed(const Duration(seconds: 1));

    if (emailController.text == savedEmail && passwordController.text == savedPassword) {
      await prefs.setBool('isLoggedIn', true);
      isLoading.value = false;
      Get.offAllNamed(RoutesClass.commonScreen);
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Email or password is incorrect',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
