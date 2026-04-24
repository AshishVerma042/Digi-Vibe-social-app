import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../../controllers/chatlist_controller.dart';
import '../../../routes/RoutesClass.dart';
import 'chat_screen.dart';


class FriendsChatListScreen extends ParentWidget {
  final FriendsChatController controller = Get.put(FriendsChatController());

  FriendsChatListScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30)),
        backgroundColor: Colors.white,

        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
        Padding(
            padding:  EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Friends...",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.grey.shade100,
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

            16.kH,
            Expanded(
              child: Obx(() {
                if (controller.friends.isEmpty) {
                  return Center(
                    child: Text(
                      "No friends found ",
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.friends.length,
                  itemBuilder: (context, index) {
                    final friend = controller.friends[index];

                    return GestureDetector(
                      onTap: () {
                        if (friend['id'] == "1") {
                          Get.put(FriendsChatController());
                          Get.toNamed(RoutesClass.gotoAiChatScreen());
                        } else {
                          Get.to(() => ChatScreen(friend: friend));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundImage: AssetImage(friend['imageUrl'] ?? ""),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            12.kW,

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    friend['name'] ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87),
                                  ),
                                  4.kH,
                                  Text(
                                    friend['lastMessage'] ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),


          ],
        ),
      ),
    );
  }
}

