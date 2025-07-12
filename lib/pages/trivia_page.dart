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
      "question": "Who is the Dinosaurs King?",
      "options": ["Triceratops", "Tyrannosaurus Rex", "Velociraptor", "Brachiosaurus"],
      "answer": "Tyrannosaurus Rex",
    },
    {
      "question": "Who is herbivore dinosaur?",
      "options": ["Spinosaurus", "Stegosaurus", "Velociraptor", "Allosaurus"],
      "answer": "Stegosaurus",
    },
    {
      "question": "Which dinosaur had a large crest on its head?",
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
      appBar: AppBar(title: const Text('DinoVerse - Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _quizCompleted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¡Quiz Completed!",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text("your score: $_score of ${_questions.length}", style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _resetQuiz,
                    child: const Text("restart Quiz"),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
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