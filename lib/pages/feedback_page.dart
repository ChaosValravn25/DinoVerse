import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_application_laboratorio_3/pages/domain/entities/user_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late Future<Map<String, List<PreguntaFeedback>>> _categorizedQuestions;
  final Map<String, Map<int, int>> _responsesByCategory = {};

  Future<Map<String, List<PreguntaFeedback>>> _loadQuestions() async {
    final String jsonStr = await rootBundle.loadString('assets/json/preguntas.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    final Map<String, List<PreguntaFeedback>> categorizedQuestions = {};

    for (var entry in jsonMap.entries) {
      final category = entry.key;
      final List<PreguntaFeedback> questions = [];
      for (var question in entry.value) {
        questions.add(PreguntaFeedback.fromJson(question));
      }
      categorizedQuestions[category] = questions;
      _responsesByCategory[category] = {}; // Inicializar respuestas
    }

    return categorizedQuestions;
  }

  @override
  void initState() {
    super.initState();
    _categorizedQuestions = _loadQuestions();
  }

  Future<void> _sendFeedbackEmail() async {
    final Map<String, List<PreguntaFeedback>> questionsMap = await _categorizedQuestions;
    final StringBuffer body = StringBuffer();
    body.write('Feedback Form Responses:\n\n');

    for (var category in questionsMap.entries) {
      body.write('Category: ${category.key.toUpperCase()}\n\n');
      final questions = category.value;
      final answers = _responsesByCategory[category.key]!;

      for (int i = 0; i < questions.length; i++) {
        final q = questions[i];
        final value = answers[i] ?? q.value;
        body.write('Question: ${q.title}\n');
        body.write('Value: $value ⭐ (Max: ${q.max}, Min: ${q.min})\n\n');
      }
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'gutierrezpablo121@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Feedback Form Responses - DinoVerse',
        'body': body.toString(),
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email client.')),
      );
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Opinion")),
      body: FutureBuilder<Map<String, List<PreguntaFeedback>>>(
        future: _categorizedQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading questions!"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Questions not found."));
          }

          final questionsByCategory = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: questionsByCategory.entries.expand((entry) {
                    final category = entry.key;
                    final questions = entry.value;
                    final answers = _responsesByCategory[category]!;

                    return [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...questions.asMap().entries.map((entryQ) {
                        final index = entryQ.key;
                        final q = entryQ.value;
                        final currentValue = answers[index] ?? q.value;

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(q.title),
                                  subtitle: Text("Max: ${q.max}\nMin: ${q.min}"),
                                  trailing: Text("$currentValue ⭐"),
                                ),
                                Slider(
                                  value: currentValue.toDouble(),
                                  min: 0,
                                  max: 5,
                                  divisions: 5,
                                  label: currentValue.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      answers[index] = value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                    ];
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _sendFeedbackEmail,
                  child: const Text("Send Answers"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
