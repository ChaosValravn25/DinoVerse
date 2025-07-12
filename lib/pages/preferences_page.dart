import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_laboratorio_3/provider/app_data.dart';
import 'package:flutter_application_laboratorio_3/pages/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  late TextEditingController _usernameController;
  late Future<List<Dinosaur>> _dinoFuture;
  final ImagePicker _picker = ImagePicker();
  String? _selectedDinoImageUrl; // Para almacenar la URL seleccionada

  @override
  void initState() {
    super.initState();
    final appData = context.read<AppData>();
    _usernameController = TextEditingController(text: appData.username);
    _dinoFuture = DinosaurService().fetchDinosaurs();
    _selectedDinoImageUrl = appData.dinoImage.isNotEmpty ? appData.dinoImage : null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final appData = context.read<AppData>();
      appData.setSelectedDinoImage(image.path);
    }
  }

  void _showProfileImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Take a Photo"),
            onTap: () {
              Navigator.pop(context);
              _pickProfileImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Gallery"),
            onTap: () {
              Navigator.pop(context);
              _pickProfileImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void _setDinoImage(String imageUrl) {
    final appData = context.read<AppData>();
    appData.setDinoImage(imageUrl); // Guardar la URL de la imagen del dinosaurio
    setState(() {
      _selectedDinoImageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(title: const Text("Preferences")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Username", style: TextStyle(fontSize: 16)),
              TextField(
                controller: _usernameController,
                onChanged: (value) {
                  appData.setUsername(value);
                },
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                ),
              ),
              const SizedBox(height: 20),
              const Text("Filter by", style: TextStyle(fontSize: 16)),
              DropdownButton<String>(
                value: appData.filterCriteria,
                items: const [
                  DropdownMenuItem(value: 'diet', child: Text("Diet")),
                  DropdownMenuItem(value: 'period', child: Text("Period")),
                ],
                onChanged: (value) {
                  if (value != null) appData.setFilterCriteria(value);
                },
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Dinosaur>>(
                future: _dinoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No dinosaurs found.');
                  }
                  final dinos = snapshot.data!;
                  final uniqueValues = <String>{};
                  if (appData.filterCriteria == 'diet') {
                    uniqueValues.addAll(dinos.map((d) => d.diet).where((d) => d.isNotEmpty).toSet());
                  } else {
                    uniqueValues.addAll(dinos.map((d) => d.period).where((d) => d.isNotEmpty).toSet());
                  }
                  return DropdownButton<String>(
                    value: appData.filterValue.isNotEmpty ? appData.filterValue : null,
                    hint: const Text("Select a value"),
                    items: uniqueValues.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) appData.setFilterValue(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text("Profile Image", style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: _showProfileImageSourceActionSheet,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: appData.selectedDinoImage.isNotEmpty
                      ? FileImage(File(appData.selectedDinoImage)) as ImageProvider
                      : const AssetImage('assets/icons/animal_3.svg') as ImageProvider,
                  child: appData.selectedDinoImage.isEmpty
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Dino Image", style: TextStyle(fontSize: 16)),
              FutureBuilder<List<Dinosaur>>(
                future: _dinoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No dinosaurs available.');
                  }
                  final dinos = snapshot.data!;
                  return DropdownButton<String>(
                    value: _selectedDinoImageUrl,
                    hint: const Text("Select a Dino Image"),
                    items: dinos.map((dino) {
                      return DropdownMenuItem<String>(
                        value: dino.image,
                        child: Text(dino.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) _setDinoImage(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("Enable Reset"),
                value: appData.resetEnabled,
                onChanged: (value) => appData.toggleReset(value),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text("Dark Mode"),
                value: appData.darkMode,
                onChanged: (value) => appData.toggleDarkMode(value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Preferences saved")),
                  );
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}