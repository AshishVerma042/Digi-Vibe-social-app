import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Modules/screens/ChatManagement/main_chat_screen.dart';
import 'package:instagram_clone/Modules/screens/PostManagement/post_screen.dart';
import 'package:instagram_clone/controllers/reelcontroller.dart';
import '../Modules/screens/ReelScrollManagement/reel_scroll_screen.dart';
import '../Modules/screens/DashBoardManagement/home_screen.dart';
import '../Modules/screens/ProfileManagement/profile.dart';


class CommonDashController extends GetxController {
  final ReelController reelController = Get.put(ReelController());

  var selectedIndex = 0.obs;
  int changeIndex() {
    if (selectedIndex.value <= 4) {
      return selectedIndex.value;
    } else {
      return 0;
    }
  }

  final List<Widget> pages = [
    const HomeScreen(), //index=0
     FriendsChatListScreen(), //index=1
    const PostScreen(), //index=2
    ReelScrollScreen(), //index=3
    const Profile(), //index=4
  ];


  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 3.0),
        child: ImageIcon(
          AssetImage('assets/images/messageInsta.png',),
          size: 22,
        ),
      ),
      activeIcon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 5.0),
        child: ImageIcon(
          AssetImage('assets/images/messageInsta.png'),
          size: 24,
        ),
      ),
      label: 'message',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Post'),
    BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 3.0),
        child: ImageIcon(
          AssetImage('assets/images/video.png',),
          size: 22,
        ),
      ),
      activeIcon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 5.0),
        child: ImageIcon(
          AssetImage('assets/images/video.png'),
          size: 24,
        ),
      ),
      label: 'reels',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];
}
