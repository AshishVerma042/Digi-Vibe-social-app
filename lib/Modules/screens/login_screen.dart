import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Modules/screens/signup_screen.dart';
import 'package:instagram_clone/resources/colors.dart';
import 'package:instagram_clone/resources/strings.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../common/common_widgets.dart';
import '../../controllers/logincontroller.dart';
import '../../main.dart';
import '../../routes/RoutesClass.dart';

class LoginScreen extends ParentWidget {
  const LoginScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/D_logo.png",height: 100,width: 100,),
                    Row(
                      children: [
                        Text(
                          "igi",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,),
                        ),
                        Text(
                          "Vibe",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Color(0xEA01B595),),
                        ),
                      ],
                    ),
                  ],
                ),
                50.kH,
                loginForm(controller),
                36.kH,
                lowerDetail(),
                16.kH,
              ],
            ),
          ),
          Positioned(child: yelloContainer(70, 50)),
          Positioned(top: 300,right: -1,child: yelloContainer(40, 40)),

          Positioned(bottom: 0,right: 50,child: yelloContainer(50, 70)),
          Positioned(bottom: 200,left: 0,child: yelloContainer(70, 30)),
        ],
      ),
    );
  }
}



Widget loginForm(LoginController controller) {
  return Column(
    children: [
      commonTextField(
        controller.emailController,
        controller.emailFocus,
        double.infinity,
            (value) {},
        hint: appStrings.phoneNumberUserNameOrEmail,
        borderWidth: 1.0,
        radius: 30,
        borderColor: Colors.black,
        focusBorderColor: const Color(0xFF00BCD4),
        fillColor: Colors.white,
      ),
      16.kH,
      commonTextField(
        controller.passwordController,
        controller.passwordFocus,
        double.infinity,
            (value) {},
        hint: appStrings.password,
        borderWidth: 1.0,
        radius: 30,
        borderColor: Colors.black,
        focusBorderColor: const Color(0xFF00BCD4),
        fillColor: Colors.white,
        obscureText: true,
      ), 16.kH,
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            appStrings.forgetPassword,
            style: TextStyle(color: appColors.black, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      24.kH,
      Container(padding: EdgeInsets.symmetric(horizontal: 50),decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(30),),
        child: commonButtonWithLoader(
          double.infinity,
          50,
          Color(0xFF00EABF),
          appColors.whitePrimary,
          controller.isLoading,
              () {
            controller.loginUser();
          },
          hint: appStrings.logIn,
          hintStyle: TextStyle(color: appColors.whitePrimary,fontSize: 18,fontWeight: FontWeight.w900),
          radius: 30,
        ),
      ),

    ],
  );
}

Widget lowerDetail() {
  return Column(
    children: [
      100.kH,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appStrings.donHaveAn,
            style: TextStyle(color: appColors.contentPlaceholderPrimary, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          4.kW,
          GestureDetector(
            onTap: () {
              Get.offNamed(RoutesClass.gotoSignupScreen());
            },
            child: Text(
              appStrings.signUp,
              style: TextStyle(color: Color(0xFF00BCD4), fontWeight: FontWeight.w400, fontSize: 15),
            ),
          ),
        ],
      ),
    ],
  );
}
