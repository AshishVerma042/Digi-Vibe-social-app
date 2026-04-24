import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../controllers/splashController.dart';
import '../../main.dart';
import '../../resources/images.dart';

class SplashScreen extends ParentWidget {
  const SplashScreen({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(195, 247, 243, 233),
      body: Stack(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 70,
                  height: 70,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text("from",style: TextStyle(color: Colors.grey.shade400,fontSize: 18,fontWeight: FontWeight.w400),),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.metaIcon,
                      scale:35 ,
                    ),4.kW,
                    Text(
                      'Meta',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      

                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
