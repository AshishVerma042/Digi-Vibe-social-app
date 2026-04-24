import 'package:flutter/material.dart';

import '../resources/colors.dart';

class AppGradients {
  static final LinearGradient loginGradient = LinearGradient(colors: [appColors.contentBluePrimary, appColors.contentBluePrimaryLight], begin: Alignment.bottomLeft, end: Alignment.topRight);

  static final LinearGradient graphGradient = const LinearGradient(colors: [Color.fromARGB(255, 37, 153, 255), Color.fromARGB(255, 97, 167, 227), Color.fromARGB(255, 133, 194, 247), Color.fromARGB(255, 74, 255, 216)], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static LinearGradient tabGradient = LinearGradient(colors: [appColors.contentBrown, appColors.contentBrownLinearColor3, appColors.contentBrownLinearColor2, appColors.contentBrownLinearColor1, appColors.contentBrownLinearColor05, appColors.contentBrownLinearColor], begin: Alignment.topCenter, end: Alignment.bottomCenter, tileMode: TileMode.clamp);

  static LinearGradient customGradient = LinearGradient(
    colors: [
      Colors.black,
      Colors.white,
      Color(0xFF008080),


      Color(0xFFFBD72B),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient customGradientForText = LinearGradient(
    colors: [
      // Colors.black,
      Color(0xFF008080),


       Color(0xFFFBD72B),
     ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
