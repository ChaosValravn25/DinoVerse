import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre DinoVerse")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "DinoVerse",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Esta app permite explorar una colección de dinosaurios, ver detalles y responder trivia. Desarrollada en Flutter como maqueta funcional."),
            
            //Text("realizado por: Ivonne Santander Soto"),
             ],
        ),
      ),
    );
  }
}
