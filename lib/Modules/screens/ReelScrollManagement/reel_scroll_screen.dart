import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/resources/colors.dart';
import 'package:instagram_clone/resources/images.dart';
import 'package:instagram_clone/resources/strings.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import 'package:video_player/video_player.dart';
import '../../../common/gradient.dart';
import '../../../controllers/reelcontroller.dart';

class ReelScrollScreen extends StatelessWidget {
  ReelScrollScreen({super.key});

  final PageController pageController = PageController();
  final ReelController controller = Get.put(ReelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: controller.localVideos.isEmpty
              ? 1
              : controller.localVideos.length + 1,
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) {
            if (controller.localVideos.isEmpty ||
                index == controller.localVideos.length) {
              return uploadScreen();
            }
            final videoController = controller.controllers[index];
            return videoController.value.isInitialized
                ? reelScreenIcons(controller, index, videoController)
                : SizedBox.shrink();
          },
        );
      }),
    );
  }


Widget uploadScreen() {
    return Container(
      color: appColors.whitePrimary,
      child: Center(
        child: GestureDetector(
          onTap: controller.pickVideo,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: appColors.whitePrimary,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  color: appColors.grey,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Icon(Icons.add, size: 100, color: appColors.grey),
          ),
        ),
      ),
    );
  }
}

IconButton reelIcons(
  String text, {
  IconData? icon,
  bool rating = true,
  void Function()? onPressed,
}) {
  return IconButton(
    icon: Column(
      children: [
        Icon(icon, color: appColors.whitePrimary),
        (rating == true)
            ? Text(
                text,
                style: TextStyle(
                  color: appColors.whitePrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              )
            : SizedBox.shrink(),
      ],
    ),
    onPressed: onPressed,
  );
}

Stack reelScreenIcons(ReelController controller, int index, videoController) {
  return Stack(
    fit: StackFit.expand,
    children: [
      GestureDetector(
        onTap: () => controller.togglePlayPause(index),
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: videoController.value.size.width,
            height: videoController.value.size.height,
            child: VideoPlayer(videoController),
          ),
        ),
      ),
      Positioned(
        right: 16,
        bottom: 40,
        child: Column(
          children: [
            reelIcons("32K", icon: Icons.favorite_border),
            reelIcons("438", icon: Icons.comment),
            IconButton(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.messageIcon,
                    color: appColors.whitePrimary,
                  ),
                  Text(
                    "5356",
                    style: TextStyle(
                      color: appColors.whitePrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),

            reelIcons("", icon: Icons.more_vert, rating: false),
          ],
        ),
      ),
      lowerFloatingIconForReelScreen(),
    ],
  );
}

Positioned lowerFloatingIconForReelScreen() {
  return Positioned(
    bottom: 10,
    left: 10,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(onTap: () {}, child: circularAvtar(1, 42, 42)),
            8.kW,
            Text("username", style: TextStyle(color: appColors.whitePrimary)),
            11.kW,
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: appColors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  appStrings.follow,
                  style: TextStyle(
                    fontSize: 13,
                    color: appColors.whitePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        4.kH,
        Text(
          "Best Mushaira by ustad Nusrat Fata Ali Khan Shahab",
          style: TextStyle(color: appColors.whitePrimary, fontSize: 12),
        ),
      ],
    ),
  );
}


Widget circularAvtar(int index, double w, double h,  ) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: AppGradients.customGradientForText,
    ),
    child: Padding(
      padding: EdgeInsets.all(3.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppImages.avatarStatus,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),

          (index == 0)
              ? Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: appColors.whitePrimary,
                shape: BoxShape.circle,
                border: Border.all(color: appColors.black, width: 1.9),
              ),
              child: Icon(Icons.add, color: appColors.black, size: 18),
            ),
          )
              : SizedBox(),
        ],
      ),
    ),
  );
}