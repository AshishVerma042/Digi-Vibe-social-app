import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../Constants/network_services/api_services.dart';
import '../Modules/model/message_model.dart';

class AiChatController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  late OpenAIService _api;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _api = OpenAIService(
  apiKey: dotenv.env['OPENAI_API_KEY']!,
  model: 'gpt-4o-mini',
);
  }

  /// ------------------ Send Message ------------------
  Future<void> sendMessage() async {
    final userMessage = textController.text.trim();
    if (userMessage.isEmpty) return;

    // add user message
    messages.add(ChatMessage(sender: "user", text: userMessage));
    textController.clear();

    _scrollToBottom();
    isLoading.value = true;

    try {
      // Prepare message history (last 8 messages)
      final lastMessages =
      messages.length > 8 ? messages.sublist(messages.length - 8) : messages;

      final apiMessages = [
        {
          "role": "system",
          "content": "You are a friendly AI chat companion. Keep replies short."
        },
        ...lastMessages.map((m) => {
          "role": m.sender == "user" ? "user" : "assistant",
          "content": m.text
        }),
      ];

      final reply = await _api.sendMessage(apiMessages);
      messages.add(ChatMessage(sender: "ai", text: reply));
    } catch (e) {
      messages.add(ChatMessage(sender: "ai", text: "Error: $e"));
    } finally {
      isLoading.value = false;
      _scrollToBottom();
    }
  }

  /// ------------------ Scroll Helper ------------------
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
