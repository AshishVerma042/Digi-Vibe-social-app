import 'package:flutter/material.dart';
import 'package:instagram_clone/common/common_widgets.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../../main.dart';

class ChatScreen extends ParentWidget {
  final Map<String, String> friend;

  const ChatScreen({required this.friend, super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final name = friend['name'] ?? "Friend";
    final imageUrl = friend['imageUrl'] ?? "";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: imageUrl.isNotEmpty ? AssetImage(imageUrl) : null,
              child: imageUrl.isEmpty ? Icon(Icons.person, color: Colors.white) : null,
            ),
            SizedBox(width: 10),
            Text(name, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Let's start chat with $name",
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commonSearchBar(
              w * 0.82,
              50,
              "Message...",
              fillColor: Colors.grey.shade800,
            ),
            10.kW,
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
