import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/common_back.dart';
import '../../controllers/commondashcontroller.dart';
import '../../main.dart';
import '../../resources/colors.dart';
import '../../resources/font.dart';

class CommonScreen extends ParentWidget {
  const CommonScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    CommonDashController controller = Get.put(CommonDashController());
    return onBack(controller.pages[controller.selectedIndex.value], canPop: controller.selectedIndex.value == 0, (didPop, result) async {
      if (didPop == false) {
        controller.selectedIndex.value = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonDashController controller = Get.put(CommonDashController());
    return Obx(
          () => Scaffold(
        body: super.build(context),
            bottomNavigationBar: Container( height: 70, decoration: BoxDecoration(border: Border.all(width: 0.2,color: appColors.grey300)),
          child: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor:Colors.transparent, hoverColor: Colors.transparent, splashFactory: NoSplash.splashFactory),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: controller.bottomNavigationItems,
              currentIndex: controller.changeIndex(),
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(fontSize: 12, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold),
              iconSize: 28,
              selectedIconTheme: IconThemeData(size: 34, color: appColors.teal),
              unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: appFonts.NunitoRegular, color: appColors.buttonTextStateDisabled),
              selectedItemColor: appColors.black,
              unselectedItemColor: appColors.contentPlaceholderPrimary,
              onTap: (index) { controller.selectedIndex.value = index;
                controller.reelController.pauseAllVideos();

                },
              elevation: 0.0,
            ),
          ),
        ),
      ),
    );
  }
}

