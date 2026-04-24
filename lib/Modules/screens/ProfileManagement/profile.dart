// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:instagram_clone/Modules/screens/ProfileManagement/post_view_screen.dart';
// import 'package:instagram_clone/controllers/profilecontroller.dart';
// import 'package:instagram_clone/resources/strings.dart';
// import 'package:instagram_clone/utils/sized_box_extension.dart';
// import '../../../../resources/colors.dart';
// import '../../../main.dart';
// import '../../../resources/images.dart';
// import '../../../routes/RoutesClass.dart';
//
// class Profile extends ParentWidget {
//   const Profile({super.key});
//
//   @override
//   Widget buildingView(BuildContext context, double h, double w) {
//     final ProfileController controller = Get.put(ProfileController());
//
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: commonAppBar(appStrings.userName),
//         backgroundColor: appColors.whitePrimary,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           color: Colors.yellow,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(100),
//                             bottomRight: Radius.circular(100),
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         bottom: -50,
//                         left: 16,
//                         right: 16,
//                         child: Container(
//                           height: 180,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(30),
//                             boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5,offset: Offset(0, 4))]
//                           ),
//                           child: Padding(
//                             padding:  EdgeInsets.symmetric( horizontal: 24,vertical: 24),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Obx(() {
//                                       final userEmail = controller.email.value;
//                                       return Text(
//                                         userEmail.isNotEmpty ? userEmail : "Username",
//                                         style: TextStyle(fontWeight: FontWeight.bold),
//                                       );
//                                     }),
//                                     Text("Flutter Developer | Tech Enthusiast"),
//                                     Text(
//                                       "www.my_portfolio.com",
//                                       style: TextStyle(color: appColors.bluePrimary),
//                                     ),
//                                   ],
//                                 ),
//                                 20.kH,
//
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text("120", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//
//                                     Text("340K", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                                     Text("280", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//
//
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text("Posts", style: TextStyle(color: Colors.grey)),
//
//                                     Text("Followers", style: TextStyle(color: Colors.grey)),
//
//                                     Text("Following", style: TextStyle(color: Colors.grey)),
//
//                                   ],
//                                 ),
//
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//               Positioned(
//                 top: 10,
//                 left: 0,
//                 right: 0,
//                 child:  Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Obx(() {
//                         final avatarFile = controller.profileImageFile.value;
//                         final avatarImage =
//                         (avatarFile.path.isNotEmpty &&
//                             avatarFile.existsSync())
//                             ? FileImage(avatarFile)
//                             : AssetImage(AppImages.avatar1) as ImageProvider;
//                         return CircleAvatar(
//                           radius: 48,
//                           backgroundImage: avatarImage,
//                         );
//                       }),
//
//                     ],
//                   ),
//                 ),
//               )
//                     ],
//                   ),
//
//                   // Padding(
//                   //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   //   child: Row(
//                   //     children: [
//                   //       Obx(() {
//                   //         final avatarFile = controller.profileImageFile.value;
//                   //         final avatarImage =
//                   //             (avatarFile.path.isNotEmpty &&
//                   //                 avatarFile.existsSync())
//                   //             ? FileImage(avatarFile)
//                   //             : AssetImage(AppImages.avatar1) as ImageProvider;
//                   //         return CircleAvatar(
//                   //           radius: 48,
//                   //           backgroundImage: avatarImage,
//                   //         );
//                   //       }),
//                   //       20.kW,
//                   //       Expanded(
//                   //         child: Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   //           children: [
//                   //             Obx(
//                   //               () => status(
//                   //                 appStrings.post,
//                   //                 controller.uploadedPosts.length.toString(),
//                   //               ),
//                   //             ),
//                   //             status(appStrings.followers, "340T"),
//                   //             status(appStrings.following, "280"),
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//
//                   // Padding(
//                   //   padding: EdgeInsets.symmetric(horizontal: 16),
//                   //   child: Column(
//                   //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //     children: [
//                   //       Obx(() {
//                   //         final userEmail = controller.email.value;
//                   //         return Text(
//                   //           userEmail.isNotEmpty ? userEmail : "Username",
//                   //           style: TextStyle(fontWeight: FontWeight.bold),
//                   //         );
//                   //       }),
//                   //       Text("Flutter Developer | Tech Enthusiast"),
//                   //       Text(
//                   //         "www.my_portfolio.com",
//                   //         style: TextStyle(color: appColors.bluePrimary),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   80.kH,
//
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.teal,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 14),
//                             ),
//                             child: Text(
//                               appStrings.editProfile,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         8.kW,
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.yellow,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 14),
//                             ),
//                             child: Text(
//                               appStrings.shareProfile,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   12.kH,
//
//                   // SizedBox(
//                   //   height: 90,
//                   //   child: ListView(
//                   //     scrollDirection: Axis.horizontal,
//                   //     children: [
//                   //       highlight("New", AppImages.avatar1),
//                   //       highlight("Work", AppImages.avatar1),
//                   //       highlight("Trips", AppImages.avatar1),
//                   //       highlight("Favs", AppImages.avatar1),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//
//             TabBar(
//               indicatorColor: appColors.black,
//               indicatorWeight: 2,
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.grid_on, size: 28, color: appColors.black),
//                 ),
//                 Tab(
//                   icon: Icon(
//                     Icons.video_library_outlined,
//                     size: 28,
//                     color: appColors.black,
//                   ),
//                 ),
//                 Tab(
//                   icon: Icon(
//                     Icons.person_pin_outlined,
//                     size: 28,
//                     color: appColors.black,
//                   ),
//                 ),
//               ],
//             ),
//
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   Obx(() {
//                     if (controller.uploadedPosts.isEmpty) {
//                       return Center(child: Text(appStrings.noPostsYet));
//                     }
//
//                     return GridView.builder(
//                       padding: EdgeInsets.zero,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 2,
//                         mainAxisSpacing: 2,
//                       ),
//                       itemCount: controller.uploadedPosts.length,
//                       itemBuilder: (context, index) {
//                         final path = controller.uploadedPosts[index];
//                         final type = controller.postType[path];
//                         final file = File(path);
//
//                         final thumb = controller.videoThumbnails[path] ?? Uint8List(0);
//
//                         Widget media;
//                         if (type == "videos") {
//                           media = thumb.isNotEmpty
//                               ? Image.memory(thumb, fit: BoxFit.cover)
//                               : Container(
//                             color: Colors.black12,
//                             child: Icon(Icons.videocam, color: Colors.white70, size: 40),
//                           );
//                         } else {
//                           media = file.existsSync()
//                               ? Image.file(file, fit: BoxFit.cover)
//                               : Container(
//                             color: Colors.black12,
//                             child: Icon(Icons.image_not_supported,
//                                 color: Colors.white70, size: 40),
//                           );
//                         }
//
//                         return GestureDetector(
//                           onTap: () {
//                             Get.to(() => PostViewScreen(
//                               file: file,
//                               isVideo: type == "videos",
//                             ));
//                           },
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               media,
//                               if (type == "videos")
//                                 Positioned(
//                                   right: 8,
//                                   bottom: 8,
//                                   child: Icon(
//                                     Icons.play_circle_fill,
//                                     color: Colors.white,
//                                     size: 26,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   })
//                   ,
//
//
//
//                   Obx(() {
//                     final videoPosts = controller.uploadedPosts
//                         .where((path) => controller.postType[path] == "videos")
//                         .toList();
//
//                     if (videoPosts.isEmpty) {
//                       return Center(child: Text("No videos yet"));
//                     }
//
//                     return GridView.builder(
//                       padding: EdgeInsets.zero,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 2,
//                         mainAxisSpacing: 2,
//                       ),
//                       itemCount: videoPosts.length,
//                       itemBuilder: (context, index) {
//                         final path = videoPosts[index];
//                         final file = File(path);
//
//                         final thumb = controller.videoThumbnails[path] ?? Uint8List(0);
//
//                         Widget media = thumb.isNotEmpty
//                             ? Image.memory(thumb, fit: BoxFit.cover)
//                             : Container(
//                           color: Colors.black12,
//                           child: Icon(Icons.videocam, color: Colors.white70, size: 40),
//                         );
//
//                         return GestureDetector(
//                           onTap: () {
//                             Get.to(() => PostViewScreen(
//                               file: file,
//                               isVideo: true,
//                             ));
//                           },
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               media,
//                               Positioned(
//                                 right: 8,
//                                 bottom: 8,
//                                 child: Icon(
//                                   Icons.play_circle_fill,
//                                   color: Colors.white,
//                                   size: 26,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }),
//
//
//                   Center(child: Text(appStrings.taggedPosts)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// PreferredSizeWidget commonAppBar(String title) {
//   return AppBar(
//     backgroundColor: appColors.black,
//     automaticallyImplyLeading: true,
//     toolbarHeight: 70,
//     iconTheme: IconThemeData(color: appColors.grey),
//     title: Row(
//       children: [
//         Icon(Icons.lock_outline, size: 20, color: appColors.whitePrimary),
//         4.kW,
//         Text(
//           "Profile",
//           style: TextStyle(fontSize: 24, color: Colors.white,fontWeight: FontWeight.bold),
//         ),
//         // Icon(Icons.keyboard_arrow_down, size: 24),
//       ],
//     ),
//     actions: [
//       IconButton(
//         icon: Icon(Icons.alternate_email, color: appColors.whitePrimary),
//         onPressed: () {},
//       ),
//       // IconButton(
//       //   icon: Icon(Icons.add_box_outlined, color: appColors.whitePrimary),
//       //   onPressed: () {},
//       // ),
//       IconButton(
//         icon: Icon(Icons.menu, color: appColors.whitePrimary,size: 35,),
//         onPressed: () {
//           Get.toNamed(RoutesClass.gotoMenuScreen());
//         },
//       ),
//     ],
//   );
// }
//
// Widget status(String label, String count) {
//   return Column(
//     children: [
//       Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//       Text(label),
//     ],
//   );
// }
//
// Widget highlight(String label, String imgPath) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 8),
//     child: Column(
//       children: [
//         CircleAvatar(radius: 30, backgroundImage: AssetImage(imgPath)),
//         6.kH,
//         Text(label, style: TextStyle(fontSize: 12)),
//       ],
//     ),
//   );
// }
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Modules/screens/ProfileManagement/post_view_screen.dart';
import 'package:instagram_clone/controllers/profilecontroller.dart';
import 'package:instagram_clone/resources/strings.dart';
import '../../../main.dart';
import '../../../resources/images.dart';
import '../../../routes/RoutesClass.dart';

class Profile extends ParentWidget {
  const Profile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final ProfileController controller = Get.put(ProfileController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: commonAppBar(appStrings.userName),
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Header background
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade400,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    // Profile Card
                    Positioned(
                      bottom: -190,
                      left: 16,
                      right: 16,
                      child: Container(
                        height: 310,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 60), // Space for avatar
                            Obx(() {
                              final userEmail = controller.email.value;
                              return Text(
                                userEmail.isNotEmpty ? userEmail : "Username",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              );
                            }),
                            SizedBox(height: 6),
                            Text(
                              "Flutter Developer | Tech Enthusiast",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "www.my_portfolio.com",
                              style: TextStyle(color: Colors.teal),
                            ),
                            SizedBox(height: 16),
                            // Stats Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                statsColumn("120", "Posts"),
                                statsColumn("340K", "Followers"),
                                statsColumn("280", "Following"),
                              ],
                            ),
                            SizedBox(height: 16),
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    child: Text(
                                      appStrings.editProfile,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    child: Text(
                                      appStrings.shareProfile,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Avatar
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Obx(() {
                          final avatarFile = controller.profileImageFile.value;
                          final avatarImage =
                          (avatarFile.path.isNotEmpty && avatarFile.existsSync())
                              ? FileImage(avatarFile)
                              : AssetImage(AppImages.avatar1) as ImageProvider;
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: avatarImage,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200),
                // TabBar
                TabBar(
                  indicatorColor: Colors.teal,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on, size: 28, color: Colors.black87)),
                    Tab(icon: Icon(Icons.video_library_outlined, size: 28, color: Colors.black87)),
                    Tab(icon: Icon(Icons.person_pin_outlined, size: 28, color: Colors.black87)),
                  ],
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    children: [
                      buildPostsGrid(controller),
                      buildVideosGrid(controller),
                      Center(child: Text(appStrings.taggedPosts)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widgets
  Column statsColumn(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget buildPostsGrid(ProfileController controller) {
    return Obx(() {
      if (controller.uploadedPosts.isEmpty) {
        return Center(child: Text(appStrings.noPostsYet));
      }

      return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemCount: controller.uploadedPosts.length,
        itemBuilder: (context, index) {
          final path = controller.uploadedPosts[index];
          final type = controller.postType[path];
          final file = File(path);

          final thumb = controller.videoThumbnails[path] ?? Uint8List(0);

          Widget media;
          if (type == "videos") {
            media = thumb.isNotEmpty
                ? Image.memory(thumb, fit: BoxFit.cover)
                : Container(
              color: Colors.black12,
              child: Icon(Icons.videocam, color: Colors.white70, size: 40),
            );
          } else {
            media = file.existsSync()
                ? Image.file(file, fit: BoxFit.cover)
                : Container(
              color: Colors.black12,
              child: Icon(Icons.image_not_supported,
                  color: Colors.white70, size: 40),
            );
          }

          return GestureDetector(
            onTap: () {
              Get.to(() => PostViewScreen(file: file, isVideo: type == "videos"));
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                media,
                if (type == "videos")
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Icon(Icons.play_circle_fill, color: Colors.white, size: 26),
                  ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget buildVideosGrid(ProfileController controller) {
    return Obx(() {
      final videoPosts = controller.uploadedPosts
          .where((path) => controller.postType[path] == "videos")
          .toList();

      if (videoPosts.isEmpty) return Center(child: Text("No videos yet"));

      return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemCount: videoPosts.length,
        itemBuilder: (context, index) {
          final path = videoPosts[index];
          final file = File(path);

          final thumb = controller.videoThumbnails[path] ?? Uint8List(0);

          Widget media = thumb.isNotEmpty
              ? Image.memory(thumb, fit: BoxFit.cover)
              : Container(
            color: Colors.black12,
            child: Icon(Icons.videocam, color: Colors.white70, size: 40),
          );

          return GestureDetector(
            onTap: () {
              Get.to(() => PostViewScreen(file: file, isVideo: true));
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                media,
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Icon(Icons.play_circle_fill, color: Colors.white, size: 26),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

// AppBar
PreferredSizeWidget commonAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.black87,
    toolbarHeight: 70,
    title: Row(
      children: [
        Icon(Icons.lock_outline, size: 20, color: Colors.white),
        SizedBox(width: 6),
        Text(
          "Profile",
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    actions: [
      IconButton(icon: Icon(Icons.alternate_email, color: Colors.white), onPressed: () {}),
      IconButton(
          icon: Icon(Icons.menu, color: Colors.white, size: 35),
          onPressed: () {
            Get.toNamed(RoutesClass.gotoMenuScreen());
          }),
    ],
  );
}
