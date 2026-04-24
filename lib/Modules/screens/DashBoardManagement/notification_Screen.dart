import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/resources/strings.dart';
import '../../../controllers/notificationController.dart';
import '../../../resources/colors.dart';

class NotificationScreen extends ParentWidget {
  const NotificationScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(NotificationController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appColors.whitePrimary,
        appBar: AppBar(
          backgroundColor: appColors.whitePrimary,
          title:  Text(
            appStrings.notifications,
            style: TextStyle(
              color: appColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          elevation: 0.5,
          surfaceTintColor: appColors.whitePrimary,
          iconTheme:  IconThemeData(color: appColors.black),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: appColors.black,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(icon: Text("Following",style: TextStyle(color: appColors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                Tab(icon: Text("You",style: TextStyle(color: appColors.black,fontSize: 18,fontWeight: FontWeight.bold))),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
              ListView.builder(
              itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(notification["avatar"] ?? ""),
                    ),
                    title: RichText(
                      text: TextSpan(
                        style:  TextStyle(color: appColors.black),
                        children: [
                          TextSpan(
                            text: notification["name"],
                            style:  TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: " ${notification["message"]}"),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      notification["time"] ?? "",
                      style:  TextStyle(color: appColors.grey, fontSize: 12),
                    ),
                  );
                },
              ),


                  Center(child: Text(appStrings.taggedPosts)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

