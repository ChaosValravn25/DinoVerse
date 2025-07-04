import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';


class DetailPage extends StatelessWidget {
  final Dinosaur dinosaur;

  const DetailPage({super.key, required this.dinosaur});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dinosaur.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(dinosaur.image),
            const SizedBox(height: 20),
            Text(
              dinosaur.description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}