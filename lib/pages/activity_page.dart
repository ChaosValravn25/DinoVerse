import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_data.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(title: const Text("Actividad del Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Usuario: ${appData.username}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Contador actual: ${appData.counter}", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text("Reset habilitado: ${appData.resetEnabled ? "Sí" : "No"}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: appData.resetEnabled ? appData.reset : null,
              child: const Text("Reiniciar contador"),
            ),
          ],
        ),
      ),
    );
  }
}
