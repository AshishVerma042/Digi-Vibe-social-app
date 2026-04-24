import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PostViewController extends GetxController {
  late VideoPlayerController videoController;
  RxBool isInitialized = false.obs;

  void initialize(File file, bool isVideo) {
    if (isVideo == false || isInitialized.value == true) return;

    videoController = VideoPlayerController.file(file);

    videoController.initialize().then((_) {
      videoController.play();
      isInitialized.value = true;
      update();
    });
  }

  void pauseVideo() {
    if (isInitialized.value && videoController.value.isPlaying) {
      videoController.pause();
    }
  }

  void deleteStory(File file, {VoidCallback? onDeleted}) {
    try {
      if (file.existsSync()) {
        file.deleteSync();
      }
      onDeleted?.call();
    } catch (e) {
      print("Error deleting story: $e");
    }
  }

  @override
  void onClose() {
    if (isInitialized.value) {
      videoController.dispose();
    }
    super.onClose();
  }
}