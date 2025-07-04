import 'package:flutter/material.dart';

class TriviaPage extends StatelessWidget {
  const TriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trivia DinoVerse")),
      body: const Center(
        child: Text(
          "Aquí iría la trivia educativa sobre dinosaurios.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}