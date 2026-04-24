import 'package:get/get.dart';

class FriendsChatController extends GetxController {
  // Each friend is represented as a Map
  var friends = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFriends();
  }

  void loadFriends() {
    friends.assignAll([
      {
        "id": "1",
        "name": "AI Friend",
        "imageUrl": "assets/images/aiGirl.jpg",
        "lastMessage": "Hi, let's chat!",
      },
      {
        "id": "2",
        "name": "Alice",
        "imageUrl": "assets/images/avatar1.jpg",
        "lastMessage": "Hey there!",

      },
      {
        "id": "3",
        "name": "Bob",
        "imageUrl": "assets/images/avatar2.jpg",
        "lastMessage": "Let's meet today.",

      },
      {
        "id": "4",
        "name": "Charlie",
        "imageUrl": "assets/images/avatar3.jpg",
        "lastMessage": "Flutter is awesome!",

      },
    ]);
  }
}
