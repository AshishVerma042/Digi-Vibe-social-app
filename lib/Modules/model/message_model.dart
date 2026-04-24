class ChatMessage {
  final String sender;
  final String text;

  ChatMessage({required this.sender, required this.text});

  Map<String, dynamic> toMap() => {
    "sender": sender,
    "text": text,
  };

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      sender: map["sender"],
      text: map["text"],
    );
  }
}
