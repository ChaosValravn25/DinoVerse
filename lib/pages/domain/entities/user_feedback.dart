class UserFeedback {
  final String userId;
  final Map<String, int> usabilidad;
  final Map<String, int> contenido;
  final Map<String, int> compartir;

  UserFeedback({
    required this.userId,
    required this.usabilidad,
    required this.contenido,
    required this.compartir,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'usabilidad': usabilidad,
      'contenido': contenido,
      'compartir': compartir,
    };
  }

  factory UserFeedback.fromJson(Map<String, dynamic> json) {
    return UserFeedback(
      userId: json['userId'] ?? '',
      usabilidad: Map<String, int>.from(json['usabilidad'] ?? {}),
      contenido: Map<String, int>.from(json['contenido'] ?? {}),
      compartir: Map<String, int>.from(json['compartir'] ?? {}),
    );
  }
}
class PreguntaFeedback {
  final String titulo;
  final int valor;
  final String min;
  final String max;

  PreguntaFeedback({
    required this.titulo,
    required this.valor,
    required this.min,
    required this.max,
  });

  factory PreguntaFeedback.fromJson(Map<String, dynamic> json) {
    return PreguntaFeedback(
      titulo: json['titulo'],
      valor: json['valor'],
      min: json['min'],
      max: json['max'],
    );
  }
}
