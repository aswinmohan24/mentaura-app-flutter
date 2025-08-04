class EmotionHistoryModel {
  final String emotion;
  final double confidence;
  final String chatTitle;
  final String suggestedReplyTitle;
  final String suggestedReply;
  final String activityTitle;
  final String explanation;
  final String userMessage;
  final DateTime createdDateTime;
  final String? id;

  EmotionHistoryModel(
      {required this.emotion,
      required this.confidence,
      required this.chatTitle,
      required this.suggestedReplyTitle,
      required this.suggestedReply,
      required this.activityTitle,
      required this.explanation,
      required this.userMessage,
      required this.createdDateTime,
      this.id});

  factory EmotionHistoryModel.fromJson(Map<String, dynamic> json) {
    return EmotionHistoryModel(
      emotion: json['emotion'] ?? '',
      confidence: (json['confidence'] ?? 0).toDouble(),
      chatTitle: json["chatTitle"] ?? "",
      id: json["_id"] ?? "",
      createdDateTime: DateTime.parse(json["createdDateTime"]),
      suggestedReplyTitle: json['suggestedReplyTitle'] ?? '',
      suggestedReply: json['suggestedReply'] ?? '',
      userMessage: json["userMessage"],
      activityTitle: json['activityTitle'] ?? '',
      explanation: json['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emotion': emotion,
      'confidence': confidence,
      'chatTitle': chatTitle,
      'suggestedReplyTitle': suggestedReplyTitle,
      'suggestedReply': suggestedReply,
      'activityTitle': activityTitle,
      'explanation': explanation,
      'createdDateTime': createdDateTime.toIso8601String(),
      "userMessage": userMessage
    };
  }

  // factory EmotionHistoryModel.fromMap(Map<String, dynamic> map) {
  //   return EmotionHistoryModel(
  //   emotion:   map['emotion'] as String,
  //  confidence:    map['confidence'] as double,
  //   chatTitle:   map['chatTitle'] as String,
  //   suggestedReplyTitle:   map['suggestedReplyTitle'] as String,
  //   suggestedReply:   map['suggestedReply'] as String,
  //   activityTitle:   map['activityTitle'] as String,
  //   explanation:   map['explanation'] as String,
  //    createdDateTime:  map['createdDateTime'] != null ? map['createdDateTime'] as String : null,
  //    id:  map['id'] != null ? map['id'] as String : null,
  //   );
  // }

  EmotionHistoryModel copyWith({
    String? emotion,
    double? confidence,
    String? chatTitle,
    String? suggestedReplyTitle,
    String? suggestedReply,
    String? activityTitle,
    String? explanation,
    String? userMessage,
    DateTime? createdDateTime,
    String? id,
  }) {
    return EmotionHistoryModel(
        emotion: emotion ?? this.emotion,
        confidence: confidence ?? this.confidence,
        chatTitle: chatTitle ?? this.chatTitle,
        suggestedReplyTitle: suggestedReplyTitle ?? this.suggestedReplyTitle,
        suggestedReply: suggestedReply ?? this.suggestedReply,
        activityTitle: activityTitle ?? this.activityTitle,
        explanation: explanation ?? this.explanation,
        userMessage: userMessage ?? this.userMessage,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        id: id ?? this.id);
  }
}
