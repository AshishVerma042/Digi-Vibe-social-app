import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/postview_controller.dart';
import '../../../main.dart';

class PostViewScreen extends ParentWidget {
  final File file;
  final bool isVideo;

  PostViewScreen({
    required this.file,
    required this.isVideo,
    super.key,
  });

  final PostViewController controller = Get.put(PostViewController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(file, isVideo);
    });

    return WillPopScope(
      onWillPop: () async {
        controller.pauseVideo();
        Get.delete<PostViewController>();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Preview"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              controller.pauseVideo();
              Get.back();
              Get.delete<PostViewController>();
            },
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  Get.defaultDialog(
                    title: "Delete",
                    middleText: "Are you sure you want to delete?",
                    textConfirm: "Yes",
                    textCancel: "No",
                    onConfirm: () {
                      controller.deleteStory(file, onDeleted: () {
                        Get.back();
                        Get.back(result: true);
                        Get.delete<PostViewController>();
                      });
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text("Delete"),
                  ),
                ];
              },
            )
          ],
        ),
        body: Center(
          child: isVideo
              ? Obx(() {
            if (controller.isInitialized.value) {
              return AspectRatio(
                aspectRatio: controller.videoController.value.aspectRatio,
                child: VideoPlayer(controller.videoController),
              );
            } else {
              return CircularProgressIndicator(color: Colors.white);
            }
          })
              : Image.file(file, fit: BoxFit.contain),
        ),


        bottomNavigationBar: bottomSearchBar(),
      ),
    );
  }
}


Widget bottomSearchBar (){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border(
        top: BorderSide(width: 0.3, color: Colors.grey.shade700),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Send to...",
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade900,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          onPressed: () {
          },
          icon: Icon(Icons.send, color: Colors.white),
        ),
      ],
    ),
  );
}