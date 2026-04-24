import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/resources/colors.dart';
import 'package:instagram_clone/resources/images.dart';
import 'package:instagram_clone/utils/sized_box_extension.dart';
import '../../../controllers/chatcontroller.dart';
import '../../model/message_model.dart';

class AiChatScreen extends StatelessWidget {
  final AiChatController controller = Get.put(AiChatController());

  AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme:  IconThemeData(color: Colors.white),
        elevation: 0,
        title:  Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/aiGirl.jpg"),
            ),
            SizedBox(width: 10),
            Text(
              "AI Friend",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Obx(() => messageList(context))),
          Obx(() => controller.isLoading.value
              ?  Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Typing...", style: TextStyle(color: Colors.white70)),
          )
              :  SizedBox.shrink()),
          messageInput(),
        ],
      ),
    );
  }

  Widget messageList(BuildContext context) {
    final messages = controller.messages;

    return ListView.builder(
      controller: controller.scrollController,
      reverse: true,
      padding: const EdgeInsets.all(12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final ChatMessage msg = messages[messages.length - 1 - index];
        final isUser = msg.sender == "user";

        return Padding(
          padding:  EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isUser == false)
                 CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(AppImages.aiGirl),
                ),
              8.kW,
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: isUser ? appColors.teal : Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  msg.text,
                  style:  TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget messageInput() {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.black,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: controller.textController,
                  style:  TextStyle(color: Colors.white),
                  decoration:  InputDecoration(
                    hintText: "Message...",
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => controller.sendMessage(),
                ),
              ),
            ),
            10.kW,
            CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: IconButton(
                icon:  Icon(Icons.send, color: Colors.white),
                onPressed: controller.sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
