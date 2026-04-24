import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/controllers/profilecontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:instagram_clone/controllers/search_screen_controller.dart';
import 'package:instagram_clone/resources/images.dart';

class HomeScreenController extends GetxController {
  final SearchScreenController searchController = Get.put(SearchScreenController());

  final profileController = Get.put(ProfileController());
  final ImagePicker picker = ImagePicker();

  final RxList<Map<String, String>> comments = RxList();
  final commentController = TextEditingController();

  var userStories = <String>[].obs;
  var storyType = <String, String>{}.obs;

  final likedPosts = <String>[].obs;
  final bookmarkedPosts = <String>[].obs;
  final postIndexes = <String, RxInt>{}.obs;
  final heartAnimations = <String, RxBool>{}.obs;

  final suggestions = [
    {"name": "Alex", "image": AppImages.avatar1},
    {"name": "Sophia", "image": AppImages.avatar2},
    {"name": "John", "image": AppImages.avatar3},
    {"name": "Emma", "image": AppImages.avatar1},
    {"name": "David", "image": AppImages.avatar2},
  ];

  @override
  void onInit() {
    super.onInit();
    loadPreferences();

  }
  void toggleLike(String postId) {
    final heart = heartAnimations[postId] ??= false.obs;

    if (likedPosts.contains(postId)) {
      likedPosts.remove(postId);
      heart.value = false;
    } else {
      likedPosts.add(postId);
      heart.value = true;

      Future.delayed(const Duration(milliseconds: 800), () {
        heart.value = false;
      });
    }
    savePreferences();
  }

  void toggleBookmark(String postId) {
    if (bookmarkedPosts.contains(postId)) {
      bookmarkedPosts.remove(postId);
    } else {
      bookmarkedPosts.add(postId);
    }
    savePreferences();
  }

  void updateIndex(String postId, int index) {
    final postIndex = postIndexes[postId] ??= 0.obs;
    postIndex.value = index;
  }

  int getCurrentIndex(String postId) => postIndexes[postId]?.value ?? 0;

  RxBool getHeart(String postId) {
    return heartAnimations[postId] ?? false.obs;
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("likedPosts", jsonEncode(likedPosts));
    await prefs.setString("bookmarkedPosts", jsonEncode(bookmarkedPosts));
    await prefs.setString("userStories", jsonEncode(userStories));
    await prefs.setString("storyType", jsonEncode(storyType));
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final liked = jsonDecode(prefs.getString("likedPosts") ?? '[]') as List;
    final bookmarks = jsonDecode(prefs.getString("bookmarkedPosts") ?? '[]') as List;
    final stories = jsonDecode(prefs.getString("userStories") ?? '[]') as List;
    final types = jsonDecode(prefs.getString("storyType") ?? '{}') as Map;

    likedPosts.assignAll(liked.map((e) => e.toString()).toList());
    bookmarkedPosts.assignAll(bookmarks.map((e) => e.toString()).toList());
    userStories.assignAll(stories.map((e) => e.toString()).toList());
    storyType.assignAll(types.map((k, v) => MapEntry(k.toString(), v.toString())));
  }

}
