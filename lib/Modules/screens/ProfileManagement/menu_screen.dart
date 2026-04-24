import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/common/common_widgets.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/resources/colors.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../../controllers/menu_screen_controller.dart';


class MenuScreen extends ParentWidget {
  const MenuScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(MenuScreenController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.black, size: 28),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Settings and activity",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container( width: double.infinity,decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
                child: Column(
                  children: [
                    commonSearchBar(w, 40, "Search",fillColor: Colors.blueGrey.shade50 ,borderRadius: 8,prefixIcon: Icon(Icons.search,color: appColors.grey,)),
                    12.kH,
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your account",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: appColors.contentPlaceholderPrimary,fontSize: 14)),
        
                        SizedBox(
                          child: Row(children: [
                            Image.asset("assets/images/meta.png",scale: 30,), 2.kW,
                            Text("Meta",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],),
                        )
                      ],
                    ),
                    ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      leading: Icon(Icons.person),
                      title: Text("Accounts Centre",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      subtitle: Text("Password, security, personal details, ad \npreferences",style: TextStyle(fontSize: 12),),
                      trailing: Icon(Icons.arrow_forward_ios,size: 18,color: appColors.contentPlaceholderPrimary,),
                    ),
                    Text("Manage your connected experiences and account settings across \nMeta technologies.",style: TextStyle(fontSize: 11,color: appColors.contentPlaceholderPrimary),),
                  ],
                ),
              ),
            ),
            6.kH,
        
            Container( width: double.infinity,decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    menuItem(Icons.bookmark_outline, "Saved"),
                    menuItem(Icons.history, "Archive"),
                    menuItem(Icons.upload_file, "Post Reel",onTap: controller.reelcontroller.pickVideo),
                    menuItem(Icons.location_history, "Other's Story Post",),
                    menuItem(Icons.notifications_outlined, "Notifications"),
                    menuItem(Icons.watch_later_outlined, "Time Management"),
                  ],
                ),
              ),
            ),
            6.kH,
            Container( width: double.infinity,decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commontext("Login", appColors.contentPlaceholderPrimary, FontWeight.w500, 12),
                    commontext("Add account", Colors.blueAccent, FontWeight.w500, 14),
                    commontext("Log out", Colors.red, FontWeight.w400, 14,onTap: controller.logout),
                    commontext("Log out of all accounts", Colors.red, FontWeight.w400, 14),
                  ],
                ),
              ),
            ),
        
        
          ],
        ),
      ),
    );
  }

  Widget menuItem(IconData icon, String title,{void Function()? onTap}) {
    return ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: Icon(icon, color: appColors.black),
      title: Text(title, style: TextStyle(fontSize: 14)),
      trailing: GestureDetector(onTap: onTap,child: Icon(Icons.arrow_forward_ios,size: 18,color: appColors.contentPlaceholderPrimary,)),
      onTap: () {
      },
    );
  }
}

Widget commontext(String text,Color color,FontWeight weight,double size,{void Function()? onTap}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(onTap: onTap ,child: Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: weight,),)),
  );
}