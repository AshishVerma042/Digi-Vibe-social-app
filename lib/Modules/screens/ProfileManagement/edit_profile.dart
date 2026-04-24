import 'package:flutter/material.dart';
import '../../../../resources/colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: appColors.whitePrimary,
        iconTheme: IconThemeData(color: appColors.black),
      ),
      body:Column(),
    );
  }
}
