import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  final email = ''.obs;
  final password = ''.obs;
  final phone = ''.obs;
  final address = ''.obs;

  final RxBool isLoading = false.obs;
  final Rx<File> profileImage = Rx<File>(File(''));
  final RxString profilePath = ''.obs;

  File get profileFile {
    final file = File(profilePath.value);
    if (file.existsSync() && profilePath.value.isNotEmpty) {
      return file;
    }
    return File('');
  }


  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage({required ImageSource source}) async {
    XFile image = await _picker.pickImage(source: source, imageQuality: 80)
        ?? XFile('');
    final file = File(image.path);
    if (file.path.isNotEmpty && await file.exists()) {
      profileImage.value = file;
    }
  }


  void showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () {
                pickImage(source: ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: () {
                pickImage(source: ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveUserPreferences() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        profileImage.value.path.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields and select a profile picture",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('address', addressController.text);
    await prefs.setString('profilePath', profileImage.value.path);
    await prefs.setBool('isRegistered', true);

    isLoading.value = false;
    Get.offAllNamed("/login");
  }

  Future<void> loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('email') ?? '';
    password.value = prefs.getString('password') ?? '';
    phone.value = prefs.getString('phone') ?? '';
    address.value = prefs.getString('address') ?? '';
    final path = prefs.getString('profilePath') ?? '';
    if (path.isNotEmpty && File(path).existsSync()) {
      profileImage.value = File(path);
    }
  }
}
