class UserFeedback {
  final String userId;
  final Map<String, int> usability;
  final Map<String, int> content;
  final Map<String, int> sharing;

  UserFeedback({
    required this.userId,
    required this.usability,
    required this.content,
    required this.sharing,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'usability': usability,
      'content': content,
      'sharing': sharing,
    };
  }

  factory UserFeedback.fromJson(Map<String, dynamic> json) {
    return UserFeedback(
      userId: json['userId'] ?? '',
      usability: Map<String, int>.from(json['usability'] ?? {}),
      content: Map<String, int>.from(json['content'] ?? {}),
      sharing: Map<String, int>.from(json['sharing'] ?? {}),
    );
  }
}

class PreguntaFeedback {
  final String title;
  final int value;
  final String min;
  final String max;

  PreguntaFeedback({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
  });

  factory PreguntaFeedback.fromJson(Map<String, dynamic> json) {
    return PreguntaFeedback(
      title: json['title'],
      value: json['value'],
      min: json['min'],
      max: json['max'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'min': min,
      'max': max,
    };
  }
}
