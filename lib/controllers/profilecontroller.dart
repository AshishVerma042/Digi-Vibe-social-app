import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:instagram_clone/controllers/postcontroller.dart';
import 'package:instagram_clone/controllers/signup_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ProfileController extends GetxController {
  var uploadedPosts = <String>[].obs;
  var postType = <String, String>{}.obs;
  var videoThumbnails = <String, Uint8List>{}.obs;

  Rx<File> profileImageFile = Rx<File>(File(''));

  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;

  final postController = Get.put(PostController());
  final signupController = Get.put(SignUpController());

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadUploadedPosts();
  }

  void loadUserData() {
    signupController.loadUserPreferences().then((_) {
      final file = signupController.profileImage.value;
      if (file.path.isNotEmpty && file.existsSync()) {
        profileImageFile.value = file;
      }

      email.value = signupController.email.value;
      phone.value = signupController.phone.value;
      address.value = signupController.address.value;
    });
  }

  Future<void> saveUploadedPost(String path, String type) async {
    uploadedPosts.add(path);
    postType[path] = type;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('uploadedPosts', uploadedPosts);
    await prefs.setStringList('postTypes', postType.values.toList());
  }

  Future<void> loadUploadedPosts() async {
    final prefs = await SharedPreferences.getInstance();

    final savedPosts = prefs.getStringList('uploadedPosts') ?? [];
    final savedTypes = prefs.getStringList('postTypes') ?? [];

    if (savedPosts.isNotEmpty && savedPosts.length == savedTypes.length) {
      for (int i = 0; i < savedPosts.length; i++) {
        uploadedPosts.add(savedPosts[i]);
        postType[savedPosts[i]] = savedTypes[i];
      }

      await preloadVideoThumbnails();
    }
  }

  Future<Uint8List> getVideoThumbnail(String videoPath) async {
    final file = File(videoPath);
    if (file.existsSync() == false) return Uint8List(0);
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        quality: 75,
      );
      return uint8list ?? Uint8List(0);
    } catch (e) {
      print("Thumbnail error for $videoPath: $e");
      return Uint8List(0);
    }
  }

  Future<void> preloadVideoThumbnails() async {
    for (final path in uploadedPosts) {
      if (postType[path] == "videos" && videoThumbnails.containsKey(path)== false) {
        final thumb = await getVideoThumbnail(path);
        videoThumbnails[path] = thumb;
      }
    }
  }
}
