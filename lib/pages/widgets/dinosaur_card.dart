import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';
import 'package:flutter_application_laboratorio_3/pages/detail_pages.dart';

class DinosaurCard extends StatelessWidget {
  final Dinosaur dinosaur;

  const DinosaurCard({super.key, required this.dinosaur});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.asset(dinosaur.image, width: 50, fit: BoxFit.cover),
        title: Text(dinosaur.name),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(dinosaur: dinosaur),
          ),
        ),
      ),
    );
  }
}