class ChatMessage {
  final int id;
  final int userId;
  final String text;
  final String? imagePath;
  final bool isSentByMe;
  final DateTime timestamp;

  ChatMessage({required this.id, required this.userId, required this.text, this.imagePath, required this.isSentByMe, required this.timestamp});

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'text': text,
        'image_path': imagePath,
        'is_sent_by_me': isSentByMe ? 1 : 0,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      userId: json['user_id'],
      text: json['text'],
      imagePath: json['image_path'],
      isSentByMe: json['is_sent_by_me'] == 1,
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}