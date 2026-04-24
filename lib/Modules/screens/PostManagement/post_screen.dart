import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controllers/profilecontroller.dart';
import 'package:instagram_clone/resources/colors.dart';
import 'package:instagram_clone/resources/strings.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../../controllers/postcontroller.dart';
import '../../../main.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../resources/enums.dart';

class PostScreen extends ParentWidget {
  const PostScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(PostController());
    final profilecontroller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: appColors.black,
      body: Obx(() {
        if (controller.hasPermission.value == false) {
          return Center(child: Text(appStrings.permissionRequired));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediaPreview(controller),
            8.kH,

            Expanded(child: mediaGrid(controller)),
          ],
        );
      }),


      floatingActionButton: Obx(() {
        if (controller.mediaList.isEmpty) return const SizedBox.shrink();

        final selectedIndex = controller.selectedIndex.value ?? 0;

        final index = selectedIndex.clamp(0, controller.mediaList.length - 1);

        final asset = controller.mediaList[index];

        return Container(
          height: 50,
          width: 160,
          margin:  EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () async {
              final file = await asset.file;

              if (file?.path.isEmpty ?? true) return;

              final isVideo = asset.type == AssetType.video;

              profilecontroller.uploadedPosts.add(file!.path);
              profilecontroller.postType[file.path] = isVideo ? "videos" : "image";

              controller.commonDashController.selectedIndex.value = 4;
            },
            shape: RoundedRectangleBorder(side: BorderSide(width: 1,color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.black.withOpacity(0.5),
            elevation: 5,
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(
                  "Post",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  AppBar topAppBar(PostController controller) {
    return AppBar(
      backgroundColor: appColors.whitePrimary,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          controller.commonDashController.selectedIndex.value = 0;
        },
      ),
      title: Text(appStrings.newPost,
          style: TextStyle(color: appColors.black)),
      centerTitle: true,
    );
  }
}
Widget mediaPreview(PostController controller) {
  return Obx(() {
    final selected = controller.selectedMedia.value;

    final thumb = controller.thumbnails[selected.id] ?? Uint8List(0);

    return thumb.isEmpty
        ? Container(
      height: 350,
      color: appColors.grey300,
    )
        : Image.memory(
      thumb,
      width: double.infinity,
      height: 450,
      fit: BoxFit.cover,
    );
  });
}

Widget mediaGrid(PostController controller) {
  return Obx(() {
    if (controller.mediaList.isEmpty ||
        controller.thumbnails.length < controller.mediaList.length) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton(
            padding: EdgeInsets.symmetric(horizontal: 16),
            value: controller.selectedFilter.value,
            items: AlbumFilter.values.map((filter) {
              String label;
              switch (filter) {
                case AlbumFilter.recent:
                  label = "Recent";
                  break;
                case AlbumFilter.photos:
                  label = "Photos";
                  break;
                case AlbumFilter.videos:
                  label = "Videos";
                  break;
                case AlbumFilter.all:
                  label = "All Albums";
                  break;
              }
              return DropdownMenuItem(
                value: filter,
                child: Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
              );
            }).toList(),
            onChanged: (filter) {
              controller.filterMedia(filter ?? AlbumFilter.recent);
            },
            icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
            dropdownColor: Colors.black,
            style: TextStyle(color: Colors.black),
          ),
        ),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: controller.mediaList.length,
            itemBuilder: (context, index) {
              final asset = controller.mediaList[index];

              // Use a default empty Uint8List if thumbnail not loaded
              final bytes = controller.thumbnails[asset.id] ?? Uint8List(0);

              return GestureDetector(
                onTap: () => controller.selectMedia(index),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    bytes.isEmpty
                        ? Container(color: Colors.grey[300])
                        : Image.memory(bytes, fit: BoxFit.cover),
                    if (asset.type == AssetType.video)
                      const Positioned(
                        right: 8,
                        bottom: 8,
                        child: Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
                      ),
                    Obx(() {
                      final isSelected = controller.selectedIndex.value == index;
                      return isSelected
                          ? Container(color: Colors.white.withOpacity(0.6))
                          :  SizedBox.shrink();
                    }),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  });
}

