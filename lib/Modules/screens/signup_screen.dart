import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/signup_controller.dart';
import '../../main.dart';
import '../../resources/strings.dart';
import '../../utils/sized_box_extension.dart';
import '../../common/common_widgets.dart';
import '../../routes/RoutesClass.dart';

class SignupScreen extends ParentWidget {
  SignupScreen({super.key});
  final controller = Get.put(SignUpController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
             color: Colors.white
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    100.kH,
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
                                color: Color(0xFF00BCD4),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    40.kH,
          
                    GestureDetector(
                      onTap: controller.showImagePickerOptions,
                      child: Obx(
                            () => Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(color: Colors.yellow, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF00BCD4),
                                blurRadius: 10,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: controller.profileImage.value.path.isNotEmpty
                                ? Image.file(
                              controller.profileImage.value,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,

                            )
                                : Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.yellow.shade50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    30.kH,
          
                    commonTextField(
                      controller.emailController,
                      FocusNode(),
                      double.infinity,
                          (val) {},
                      hint: appStrings.phoneNumberUserNameOrEmail,
                      borderWidth: 1,
                      radius:30,
                      fillColor: Colors.white.withOpacity(0.2),
                      hintStyle: TextStyle(color: Colors.black38),
                      textStyle: TextStyle(color: Colors.black),
                      borderColor: Colors.black
                    ),
                    16.kH,
                  commonTextField(
                    controller.passwordController,
                    FocusNode(),
                    double.infinity,
                        (val) {},
                    hint: appStrings.password,
                    borderWidth: 1,
                    radius: 30,

                    hintStyle:  TextStyle(color: Colors.black38),
                    textStyle:  TextStyle(color: Colors.black),
                    obscureText: true,
                    borderColor: Colors.black,
                  ),


                  30.kH,
          
                    commonButtonWithLoader(
                      double.infinity,
                      55,
                      Colors.yellow,
                      Colors.black,
                      controller.isLoading,
                          () => controller.saveUserPreferences(),
                      hint: "Sign Up",
                      hintStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600),
                      radius: 30,

          
                    ),
                    40.kH,
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black),
                        ),
                        4.kW,
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesClass.gotoLoginScreen());
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Color(0xFF00BCD4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(top: 100,right: -1,
              child: yelloContainer(50, 50)),
          Positioned(top: 300,left: -1,
              child: yelloContainer(100, 70)),
          Positioned(bottom: -1,right: -1,
              child: yelloContainer(50, 50))
        ],
      ),
    );
  }
}

Widget yelloContainer (double h, double w){
  return  Container(height: h , width: w,decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(10),)
  );
}