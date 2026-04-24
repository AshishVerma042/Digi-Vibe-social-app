import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/previewscreenController.dart';
import 'package:instagram_clone/main.dart';

import '../ProfileManagement/post_view_screen.dart';

class StoryPreviewScreen extends ParentWidget {
  final List<File> files;
  final List<bool> isVideoList;

  const StoryPreviewScreen({
    super.key,
    required this.files,
    required this.isVideoList,
  });

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(StoryPreviewController());
    controller.initializeStories(files, isVideoList);

    return WillPopScope(
      onWillPop: () async {
        controller.pauseCurrentVideo();
        Get.delete<StoryPreviewController>();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Obx(() {
          if (controller.stories.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (details) {
                  final width = w;
                  if (details.globalPosition.dx < width / 3) {
                    controller.previousStory();
                  } else {
                    controller.nextStory();
                  }
                },
                onLongPressStart: (_) => controller.pauseCurrentVideo(),
                child: CarouselSlider.builder(
                  carouselController: controller.carouselController,
                  itemCount: controller.stories.length,
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.28,
                    enableInfiniteScroll: false,
                    scrollPhysics:  BouncingScrollPhysics(),
                    onPageChanged: (index, reason) =>
                        controller.onPageChanged(index),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final isVideo = controller.isVideoList[index];
                    final vc = controller.videoControllers[index];

                    if (isVideo) {
                      return Obx(() {
                        final initialized = controller.isInitializedList[index];
                        if (!initialized) {
                          return Center(child: CircularProgressIndicator(color: Colors.white));
                        }

                        if (index == controller.currentIndex.value && !vc.value.isPlaying) {
                          vc.play();
                          controller.startAutoScrollTimerForVideo(vc);
                        }

                        return AspectRatio(
                          aspectRatio: vc.value.aspectRatio,
                          child: VideoPlayer(vc),
                        );
                      });
                    } else {
                      return Image.file(
                        controller.stories[index],
                        fit: BoxFit.cover,
                      );
                    }

                  },
                ),
              ),

              Positioned(
                top: 50,
                left: 10,
                right: 10,
                child: Row(
                  children:
                  List.generate(controller.stories.length, (index) {
                    final active = index <= controller.currentIndex.value;
                    return Expanded(
                      child: Container(
                        margin:  EdgeInsets.symmetric(horizontal: 2),
                        height: 3,
                        decoration: BoxDecoration(
                          color: active ? Colors.white : Colors.white54,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              Positioned(
                top: 40,
                right: 10,
                child: IconButton(
                  icon:  Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    controller.pauseCurrentVideo();
                    Get.back();
                  },
                ),
              ),
            ],
          );
        }),
        bottomNavigationBar: bottomSearchBar(),
      ),
    );
  }
}
