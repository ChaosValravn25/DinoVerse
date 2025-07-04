import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_laboratorio_3/provider/app_data.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    final username = context.read<AppData>().username;
    _usernameController = TextEditingController(text: username);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(title: const Text("Preferencias")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nombre de Usuario", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _usernameController,
              onChanged: (value) {
                appData.setUsername(value);
              },
              decoration: const InputDecoration(
                hintText: "Ingresa tu nombre",
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text("Habilitar reinicio"),
              value: appData.resetEnabled,
              onChanged: (value) => appData.toggleReset(value),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text("Modo oscuro"),
              value: appData.darkMode,
              onChanged: (value) => appData.toggleDarkMode(value),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Preferencias guardadas")),
                );
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
