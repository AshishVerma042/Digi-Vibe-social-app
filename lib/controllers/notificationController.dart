import 'package:get/get.dart';
import 'package:instagram_clone/resources/images.dart';

class NotificationController extends GetxController{
  final List<Map<String, String>> notifications = [
    {
      "avatar": AppImages.avatar1,
      "name": "john_doe",
      "message": "liked your photo",
      "time": "2h"
    },
    {
      "avatar": AppImages.avatarStatus,
      "name": "emma_watson",
      "message": "started following you",
      "time": "5h"
    },
    {
      "avatar": AppImages.avatar2,
      "name": "alex_smith",
      "message": "commented: Nice shot!",
      "time": "1d"
    },
    {
      "avatar": AppImages.avatar3,
      "name": "sarah_lee",
      "message": "liked your story",
      "time": "2d"
    },
  ];

}