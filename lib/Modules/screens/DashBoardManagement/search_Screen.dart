import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/resources/images.dart';
import 'package:instagram_clone/resources/strings.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../../controllers/search_screen_controller.dart';
import '../../../main.dart';
import '../../../resources/colors.dart';

class SearchScreen extends ParentWidget {
  const SearchScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(SearchScreenController());

    return Scaffold(
      backgroundColor: appColors.whitePrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.kH,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: appStrings.searchWithMetaAI,
                  hintStyle: TextStyle(
                    color: appColors.contentPlaceholderPrimary,
                    fontSize: 14,
                  ),
                  prefixIcon: Padding(
                    padding:  EdgeInsets.all(12.0),
                    child: Image.asset(AppImages.searchIcon,height: 25,),
                  ),
                  filled: true,
                  fillColor: appColors.lightGrey,
                  contentPadding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: appColors.lightGrey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: appColors.lightGrey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: appColors.lightGrey, width: 1.5),
                  ),
                ),
              ),
            ),

            Obx(() {
              return Column(
                children: [
                  postGrid(controller.images),
                  2.kH,
                  postGrid(controller.images),
                  2.kH,
                  postGrid(controller.images),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget postGrid(List<String> images) {
  return StaggeredGrid.count(
    crossAxisCount: 3,
    mainAxisSpacing: 1,
    crossAxisSpacing: 1,
    children: List.generate(images.length, (index) {
      final isTall = index == 2 || index == 5;
      return StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: isTall ? 2 : 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.asset(
            images[index],
            fit: BoxFit.cover,
          ),
        ),
      );
    }),
  );
}
