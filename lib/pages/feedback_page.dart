import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_application_laboratorio_3/pages/domain/entities/user_feedback.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late Future<List<PreguntaFeedback>> _feedbackQuestions;

  Future<List<PreguntaFeedback>> _loadQuestions() async {
    final String jsonStr = await rootBundle.loadString('assets/json/preguntas.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    final List<PreguntaFeedback> questions = [];

    for (var category in jsonMap.values) {
      for (var question in category) {
        questions.add(PreguntaFeedback.fromJson(question));
      }
    }

    return questions;
  }

  @override
  void initState() {
    super.initState();
    _feedbackQuestions = _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tu Opinión")),
      body: FutureBuilder<List<PreguntaFeedback>>(
        future: _feedbackQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error cargando preguntas"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay preguntas disponibles."));
          }

          final questions = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final q = questions[index];
              return Card(
                child: ListTile(
                  title: Text(q.titulo),
                  subtitle: Text("Máx: ${q.max}\nMín: ${q.min}"),
                  trailing: Text("${q.valor} ⭐"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
