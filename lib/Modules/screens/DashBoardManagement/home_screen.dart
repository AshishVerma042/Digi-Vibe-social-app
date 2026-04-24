import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Modules/screens/DashBoardManagement/storyPreviewScreen.dart';
import 'package:instagram_clone/common/gradient.dart';
import 'package:instagram_clone/resources/images.dart';
import 'package:instagram_clone/resources/strings.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../../controllers/homeScreencontroller.dart';
import '../../../main.dart';
import '../../../resources/colors.dart';
import '../../../routes/RoutesClass.dart';

class HomeScreen extends ParentWidget {
  const HomeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(HomeScreenController());

    return Scaffold(
      appBar: commonAppBar("Home"),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            storySection(h, w, controller),

            postItem(
              context,
              "Car_Hub",
              AppImages.avatar1,
              "Crazy Cars World",
              [AppImages.car1, AppImages.car2, AppImages.car3],
              controller,
              "Check out this amazing car!",
              isSponsored: true,
            ),
            suggestionSection(h, w, controller),
            postItem(
              context,
              "TravelGuru",
              AppImages.avatar2,
              "World of Cars",
              [AppImages.searchPost1, AppImages.searchPost2, AppImages.searchPost3],
              controller,
              "Beautiful destinations around the world.",
            ),
            postItem(
              context,
              "FoodieFun",
              AppImages.avatar3,
              "Crazy World",
              [AppImages.searchPost4, AppImages.searchPost5, AppImages.searchPost6],
              controller,
              "Delicious recipes to try at home.",
            ), postItem(
              context,
              "Nature",
              AppImages.avatar2,
              "World of Cars",
              [AppImages.searchPost7, AppImages.car2, AppImages.searchPost8, AppImages.car1, AppImages.searchPost1],
              controller,
              "Beautiful destinations around the world.",
            ),
            postItem(
              context,
              "Crazy Cars",
              AppImages.avatar3,
              "Crazy World",
              [AppImages.searchPost6, AppImages.car3, AppImages.car1, AppImages.car2],
              controller,
              "Delicious recipes to try at home.",
            ), postItem(
              context,
              "Tree Garden",
              AppImages.avatar2,
              "World of Cars",
              [AppImages.searchPost8, AppImages.car1,AppImages.car2, AppImages.car3, AppImages.car1],
              controller,
              "Beautiful destinations around the world.",
            ),
            postItem(
              context,
              "Music King",
              AppImages.avatar3,
              "Crazy World",
              [AppImages.searchPost5, AppImages.searchPost1, AppImages.car2],
              controller,
              "Delicious recipes to try at home.",
            ),
          ],
        ),
      ),
    );
  }
}

Widget postItem(
    BuildContext context,
    String username,
    String userImage,
    String subTitle,
    List<String> postImages,
    HomeScreenController controller,
    String caption, {
      bool isSponsored = false,
      bool isBookmark = false,
    }) {
  return Container(
    margin:  EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),

    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(userImage),
                  ),
                  10.kW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        isSponsored ? appStrings.sponsored : subTitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon:  Icon(Icons.more_vert, color: Colors.black54),
                onPressed: () {},
              ),
            ],
          ),
        ),

        Padding(
          padding:  EdgeInsets.all(8.0),
          child: Stack(
            children: [
              GestureDetector(
                onDoubleTap: () => controller.toggleLike(username),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CarouselSlider.builder(
                    itemCount: postImages.length,
                    itemBuilder: (context, index, _) => Image.asset(
                      postImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    options: CarouselOptions(
                      height: 350,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) =>
                          controller.updateIndex(username, index),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 16,
                right: 16,
                child: Obx(() {
                  final currentIndex = controller.getCurrentIndex(username);
                  return Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${currentIndex + 1}/${postImages.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
              ),

              Obx(() {
                final showHeart = controller.getHeart(username).value;
                return Positioned.fill(
                  child: AnimatedScale(
                    scale: showHeart ? 1.0 : 0.0,
                    duration:  Duration(milliseconds: 400),
                    curve: Curves.easeInOutBack,
                    child:  Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 120,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        Obx(() {
          final currentIndex = controller.getCurrentIndex(username);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              postImages.length,
                  (index) => AnimatedContainer(
                duration:  Duration(milliseconds: 250),
                width: currentIndex == index ? 10 : 6,
                height: 6,
                margin:
                 EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentIndex == index
                      ?  Color(0xFF00BCD4)
                      : Colors.grey.shade300,
                ),
              ),
            ),
          );
        }),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(() {
                    final isLiked = controller.likedPosts.contains(username);
                    return GestureDetector(
                      onTap: () => controller.toggleLike(username),
                      child: Icon(
                        isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border,
                        color: isLiked
                            ? Colors.redAccent
                            : Colors.grey.shade700,
                        size: 28,
                      ),
                    );
                  }),
                  16.kW,



              GestureDetector(
                onTap: () {
                  showCommentBottomSheet(context, controller);
                },
                child: SvgPicture.asset(AppImages.commentIcon),
              ),
              12.kW,
              SvgPicture.asset(AppImages.messageIcon),
            ],
          ),


              Obx(() {
                final isBookmarked =
                controller.bookmarkedPosts.contains(username);
                return GestureDetector(
                  onTap: () => controller.toggleBookmark(username),
                  child: Icon(
                    isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                    color: isBookmarked
                        ?  Color(0xFF00BCD4)
                        : Colors.grey.shade700,
                    size: 26,
                  ),
                );
              }),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            caption,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget commonAppBar(String title) {
  return AppBar(
    backgroundColor: appColors.whitePrimary,
    elevation: 3,
    shadowColor: Colors.grey.withOpacity(0.2),
    surfaceTintColor: Colors.transparent,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(AppImages.D_icon, height: 30, width: 30),
        Row(
          children: [
            Text("igi",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text("Vibe",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xEA01B595))),
          ],
        ),
        60.kW,
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: appColors.black,
          ),
        ),
      ],
    ),
    centerTitle: false,
    toolbarHeight: 60,
    actions: [
      IconButton(
        icon:  Icon(Icons.search, size: 26),
        onPressed: () => Get.toNamed(RoutesClass.gotoSearchScreen()),
      ),
      IconButton(
        icon:  Icon(Icons.notifications_outlined),
        onPressed: () => Get.toNamed(RoutesClass.gotoNotificationscreen()),
      ),
    ],
  );

}

Widget suggestionSection(double h, double w, HomeScreenController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appStrings.suggestedForYou,
              style:  TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              appStrings.seeAll,
              style:  TextStyle(
                color: Color(0xFF00BCD4),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      SizedBox(
        height: h * 0.26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.suggestions.length,
          itemBuilder: (context, index) {
            final user = controller.suggestions[index];

            return Container(
              width: w * 0.48,
              margin:  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding:  EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset:  Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage(user["image"] ?? ""),
                  ),
                  10.kH,
                  Text(
                    user["name"] ?? "",
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  2.kH,
                  Text(
                    "Popular Creator",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  10.kH,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side:  BorderSide(color: Color(0xFF00BCD4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:  EdgeInsets.symmetric(vertical: 8),
                      ),
                      child:  Text(
                        "Follow",
                        style: TextStyle(
                          color: Color(0xFF00BCD4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}


void showCommentBottomSheet(BuildContext context, HomeScreenController controller) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.8,
        initialChildSize: 0.6,
        minChildSize: 0.3,
        builder: (context, scrollController) {
          return Obx(() => Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 12, bottom: 8),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    final comment = controller.comments[index];
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(comment["avatar"] ?? ""),
                          ),
                          8.kW,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      comment["name"] ?? "username",
                                      style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    4.kW,
                                    Text(
                                      comment["time"] ?? "1h",
                                      style:  TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                4.kH,
                                Text(
                                  comment["text"] ?? "",
                                  style:  TextStyle(color: Colors.black),
                                ),
                                4.kH,
                                GestureDetector(
                                  onTap: () {},
                                  child:  Text(
                                    "Reply",
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                           Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                        ],
                      ),
                    );
                  },
                ),
              ),

               Divider(height: 0.5, thickness: 0.5, color: Colors.grey),

              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 8,
                  top: 8,
                ),
                child: Row(
                  children: [
                     CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(AppImages.avatar1),
                    ),
                    8.kW,
                    Expanded(
                      child: TextField(
                        controller: controller.commentController,
                        decoration:  InputDecoration(
                          hintText: appStrings.addAComment,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child:  Icon(Icons.north_outlined, color: Colors.white),
                      ),
                      onPressed: () {
                        final text = controller.commentController.text.trim();
                        if (text.isNotEmpty) {
                          controller.comments.add({
                            "name": "You",
                            "avatar": AppImages.avatar1,
                            "text": text,
                            "time": "Just now",
                          });
                          controller.commentController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ));
        },
      );
    },
  );
}

Widget storySection(double h, double w, HomeScreenController controller) {
  return Padding(
    padding:  EdgeInsets.only(top: 10),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          circularAvatarForUserStory(controller, 80, 80),


        ],
      ),
    ),
  );
}




Widget circularAvatarForUserStory(HomeScreenController controller, double w, double h) {
  final hasStories = controller.userStories.isNotEmpty;
    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (hasStories == false) {
                Get.toNamed(RoutesClass.gotoUploadStoryScreen());
              } else {
                if (controller.userStories.isNotEmpty) {
                  final lastStory = controller.userStories.last;

                  Get.to(() => StoryPreviewScreen(
  files: controller.userStories.map((e) => File(e)).toList(),
  isVideoList: controller.userStories.map((e) => controller.storyType[e] == "videos").toList(),
));
                }
                else {

                  Get.snackbar("No story", "Please upload a story first.");
                }

              } 
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColors.teal
              ),
              padding:  EdgeInsets.all(2.5),
              child: Container(padding: EdgeInsets.all(3),decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),color: Colors.white),
                child: Obx(
                      () {
                        final profileFile = controller.profileController.profileImageFile.value ;
                        final ImageProvider avatarImage = (profileFile.path.isNotEmpty && profileFile.existsSync())
                            ? FileImage(profileFile) as ImageProvider
                            : AssetImage(AppImages.avatar1) as ImageProvider;
                        return CircleAvatar(
                          radius: w / 2,
                          backgroundImage: avatarImage,
                        );
                  },
                ),
              ),


            ),
          ),

          Positioned(
            bottom: 2,
            right: 2,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RoutesClass.gotoUploadStoryScreen());
              },
              child: Container(
                width: w * 0.3,
                height: h * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: appColors.teal, width: 1.9),

                ),
                child: Icon(Icons.add, color: appColors.black, size: 16,),
              ),
            ),
          ),
        ],
      ),
    );

}

Widget storyAvatar(ImageProvider image, double w, double h) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: AppGradients.customGradientForText,
    ),
    child: Padding(
      padding: EdgeInsets.all(3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(w / 2),
        child: Image(
          image: image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    ),
  );
}


