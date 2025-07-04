import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';//para que funcione las imagenes de svg
import 'package:logger/logger.dart';//para emplear el logger 
import 'package:flutter_application_laboratorio_3/pages/about.dart';//llamar el about
import 'package:flutter_application_laboratorio_3/pages/list_content.dart';//llamar list_content
import 'package:flutter_application_laboratorio_3/pages/trivia_page.dart';
import 'package:flutter_application_laboratorio_3/pages/preferences_page.dart';
import 'package:flutter_application_laboratorio_3/pages/activity_page.dart';
import 'package:flutter_application_laboratorio_3/pages/feedback_page.dart';

class HomePage extends StatelessWidget {
  final Logger logger = Logger();

  HomePage({super.key}) {
    logger.i("HomePage loaded");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DinoVerse - Inicio")),
      body: Center(
        child: Card(
          color: Colors.green[50],
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/animal_3.svg',
                  width: 120,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bienvenido a DinoVerse',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ListContent()),
                  ),
                  child: const Text("Explorar Dinosaurios"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TriviaPage()),
                  ),
                  child: const Text("Iniciar Trivia"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const About()),
                  ),
                  child: const Text("Sobre la App"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PreferencesPage()),
                  ),
                  child: const Text("Preferencias"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ActivityPage()),
                  ),
                  child: const Text("Actividades"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbackPage()),
                  ),
                  child: const Text("Tu opinión"),
                ),


              ], 
            ),           
          ),
        ),
      ),
    );
  }
}
