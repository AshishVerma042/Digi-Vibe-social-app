import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/main.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../controllers/uploadStoryController.dart';
import '../../../resources/enums.dart';
import '../../../routes/RoutesClass.dart';

class StoryUploadScreen extends ParentWidget {
  const StoryUploadScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(UploadStoryController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:  IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.close,color: Colors.white,)),
        title: Center(child: Text("Upload Story",style: TextStyle(color: Colors.white),)),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.white,))],

      ),
      body:Obx(() {

        return Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton(padding: EdgeInsets.symmetric(horizontal: 16,),
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
                    child: Text(label, style: TextStyle(color: Colors.white,fontSize: 16)),
                  );
                }).toList(),
                onChanged: (filter) {
                  controller.filterMedia(filter ?? AlbumFilter.recent);
                },
                icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
                dropdownColor: Colors.black,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(thickness: 0.4,),
            Expanded(
              child: controller.mediaList.isEmpty ||
                  controller.thumbnails.length < controller.mediaList.length
                  ?  Center(child: CircularProgressIndicator())
                  : GridView.builder(
                padding:  EdgeInsets.all(2),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: controller.mediaList.length,
                itemBuilder: (context, index) {
                  final asset = controller.mediaList[index];
                  final bytes = controller.thumbnails[index];

                  return GestureDetector(
                    onTap: () { controller.selectMedia(index);},
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.memory(bytes, fit: BoxFit.cover),
                        if (asset.type == AssetType.video)
                           Positioned(
                            right: 8,
                            bottom: 8,
                            child: Icon(Icons.play_circle_fill,
                                color: Colors.white, size: 28),
                          ),
                        Obx(() {
                          final isSelected = controller.selectedIndex.value == index;
                          return isSelected
                              ? Container(color: Colors.white.withOpacity(0.6))
                              : SizedBox.shrink();
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),

      floatingActionButton: Obx(() {
        if (controller.mediaList.isEmpty) return SizedBox.shrink();
        final index = controller.selectedIndex.value.clamp(0, controller.mediaList.length - 1);
        final asset = controller.mediaList[index];
        return Container(
          height: 50,
          width: 160,
          margin: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () async {
              final file = await asset.file;
              final isVideo = asset.type == AssetType.video;
              controller.homeScreenController.userStories.add(file.path);
              controller.homeScreenController.storyType[file.path] = isVideo ? "videos" : "image";
              Get.toNamed(RoutesClass.gotoHomeScreen());
            },
            shape: RoundedRectangleBorder(side: BorderSide(width: 1,color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor:  Colors.black.withOpacity(0.5),
            elevation: 5,
            child: Text(
              "Upload Story",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );
  }
}

