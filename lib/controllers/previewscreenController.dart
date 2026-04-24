import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_controller.dart';

class StoryPreviewController extends GetxController {
  final CarouselSliderController carouselController = CarouselSliderController();

  final RxInt currentIndex = 0.obs;
  final RxList<File> stories = <File>[].obs;
  final RxList<bool> isVideoList = <bool>[].obs;
  final RxList<bool> isInitializedList = <bool>[].obs;

  late final List<VideoPlayerController> videoControllers;
  Timer? _autoScrollTimer;


  void initializeStories(List<File> files, List<bool> videoFlags) {
    if (stories.isNotEmpty) return;

    stories.assignAll(files);
    isVideoList.assignAll(videoFlags);
    isInitializedList.assignAll(List<bool>.filled(files.length, false));

    videoControllers = List.generate(stories.length, (i) {
      if (isVideoList[i]) {
        final vc = VideoPlayerController.file(stories[i]);
        vc.initialize().then((_) {
          isInitializedList[i] = true;
          update();

          if (i == 0) {
            vc.play();
            startAutoScrollTimerForVideo(vc);
          }
        });


        vc.addListener(() {
          final isAtEnd = vc.value.isInitialized &&
              vc.value.duration.inMilliseconds > 0 &&
              vc.value.position >= vc.value.duration;
          if (isAtEnd) nextStory();
        });

        return vc;
      } else {
        final dummy = VideoPlayerController.asset('');
        dummy.setLooping(false);
        dummy.initialize().then((_) => isInitializedList[i] = true);
        return dummy;
      }
    });

    _startAutoScrollTimer();
  }

  void onPageChanged(int index) {
    pauseCurrentVideo();
    _cancelAutoScrollTimer();
    currentIndex.value = index;

    if (index < 0 || index >= isVideoList.length) return;

    final vc = videoControllers[index];

    if (isVideoList[index]) {
      if (vc.value.isInitialized) {
        vc.play();
        startAutoScrollTimerForVideo(vc);
      } else {
        vc.initialize().then((_) {
          isInitializedList[index] = true;
          update();
          vc.play();
          startAutoScrollTimerForVideo(vc);
        });
      }
    } else {
      _startAutoScrollTimerForImage();
    }
  }

  void nextStory() {
    final nextIndex = currentIndex.value + 1;
    if (nextIndex < stories.length) {
      carouselController.nextPage();
    } else {
      pauseCurrentVideo();
      Get.back();
    }
  }

  void previousStory() {
    if (currentIndex.value > 0) {
      carouselController.previousPage();
    }
  }

  void _startAutoScrollTimer() {
    if (stories.isEmpty) return;

    if (isVideoList.first) {
      final vc = videoControllers.first;

      if (vc.value.isInitialized) {
        startAutoScrollTimerForVideo(vc);
      } else {
        vc.initialize().then((_) {
          isInitializedList[0] = true;
          update();
          startAutoScrollTimerForVideo(vc);
        });
      }
    } else {
      _startAutoScrollTimerForImage();
    }
  }

  void _startAutoScrollTimerForImage() {
    _cancelAutoScrollTimer();
    _autoScrollTimer = Timer(const Duration(seconds: 5), nextStory);
  }

  void startAutoScrollTimerForVideo(VideoPlayerController vc) {
    _cancelAutoScrollTimer();
    final duration = vc.value.isInitialized
        ? vc.value.duration
        : const Duration(seconds: 15);
    final autoDuration =
    duration < const Duration(seconds: 15) ? duration : const Duration(seconds: 15);
    _autoScrollTimer = Timer(autoDuration, nextStory);
  }

  void _cancelAutoScrollTimer() {
    _autoScrollTimer?.cancel();
  }

  void pauseCurrentVideo() {
    final current = currentIndex.value;
    if (current >= 0 && current < videoControllers.length && isVideoList[current]) {
      videoControllers[current].pause();
    }
    _cancelAutoScrollTimer();
  }

  @override
  void onClose() {
    _cancelAutoScrollTimer();
    for (final vc in videoControllers) {
      vc.dispose();
    }
    super.onClose();
  }
}
