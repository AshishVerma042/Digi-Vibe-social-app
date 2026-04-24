import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../routes/RoutesClass.dart';


class ReelController extends GetxController {

  final ImagePicker _picker = ImagePicker();


  var localVideos = <File>[].obs;

  var controllers = <VideoPlayerController>[].obs;
  var currentPage = 0.obs;


  Future<void> pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery)
        ?? XFile('');

    final filePath = pickedFile.path;
    if (filePath.isEmpty) return;

    final file = File(filePath);
    final controller = VideoPlayerController.file(file);
    await controller.initialize();
    controller.setLooping(true);

    localVideos.add(file);
    controllers.add(controller);

    if (currentPage.value == controllers.length - 1) {
      controller.play();
    }

    update();
    Get.toNamed(RoutesClass.gotoScrollScreen());
  }


  void onPageChanged(int index) {
    currentPage.value = index;
    for (int i = 0; i < controllers.length; i++) {
      if (i == index) {
        controllers[i].play();
      } else {
        controllers[i].pause();
      }
    }
  }

  void togglePlayPause(int index) {
    final controller = controllers[index];
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    update();
  }

  void pauseAllVideos() {
    for (var c in controllers) {
      if (c.value.isPlaying) {
        c.pause();
      }
    }
    update();
  }


  @override
  void onClose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.onClose();
  }
}