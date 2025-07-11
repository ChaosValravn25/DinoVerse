import 'package:flutter/material.dart';

class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  State<TriviaPage> createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "¿Qué dinosaurio es conocido como el 'Rey de los Dinosaurios'?",
      "options": ["Triceratops", "Tyrannosaurus Rex", "Velociraptor", "Brachiosaurus"],
      "answer": "Tyrannosaurus Rex",
    },
    {
      "question": "¿Cuál era un dinosaurio herbívoro?",
      "options": ["Spinosaurus", "Stegosaurus", "Velociraptor", "Allosaurus"],
      "answer": "Stegosaurus",
    },
    {
      "question": "¿Qué dinosaurio tenía una gran cresta en su cabeza?",
      "options": ["Parasaurolophus", "Tyrannosaurus Rex", "Diplodocus", "Velociraptor"],
      "answer": "Parasaurolophus",
    },
  ];

  void _answerQuestion(String selectedOption) {
    if (!_quizCompleted) {
      if (selectedOption == _questions[_currentQuestionIndex]["answer"]) {
        _score++;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
      } else {
        setState(() {
          _quizCompleted = true;
        });
      }
    }
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia de Dinosaurios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _quizCompleted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¡Quiz completado!",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text("Tu puntaje: $_score de ${_questions.length}", style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _resetQuiz,
                    child: const Text("Reintentar Trivia"),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pregunta ${_currentQuestionIndex + 1} de ${_questions.length}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_currentQuestionIndex]["question"],
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ...(_questions[_currentQuestionIndex]["options"] as List<String>).map(
                    (option) => ElevatedButton(
                      onPressed: () => _answerQuestion(option),
                      child: Text(option),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
