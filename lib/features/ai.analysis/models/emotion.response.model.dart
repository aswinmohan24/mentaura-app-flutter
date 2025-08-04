class EmotionResponse {
  final String emotion;
  final double confidence;
  final String chatTitle;
  final String suggestedReplyTitle;
  final String suggestedReply;
  final String activityTitle;
  final String explanation;

  EmotionResponse({
    required this.emotion,
    required this.confidence,
    required this.chatTitle,
    required this.suggestedReplyTitle,
    required this.suggestedReply,
    required this.activityTitle,
    required this.explanation,
  });

  factory EmotionResponse.fromJson(Map<String, dynamic> json) {
    return EmotionResponse(
      emotion: json['emotion'] ?? '',
      confidence: (json['confidence'] ?? 0).toDouble(),
      chatTitle: json["chatTitle"] ?? "",
      suggestedReplyTitle: json['suggestedReplyTitle'] ?? '',
      suggestedReply: json['suggestedReply'] ?? '',
      activityTitle: json['activityTitle'] ?? '',
      explanation: json['explanation'] ?? '',
    );
  }
}
