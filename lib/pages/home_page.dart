import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_laboratorio_3/provider/app_data.dart';
import 'package:flutter_application_laboratorio_3/pages/about.dart';
import 'package:flutter_application_laboratorio_3/pages/trivia_page.dart';
import 'package:flutter_application_laboratorio_3/pages/preferences_page.dart';
import 'package:flutter_application_laboratorio_3/pages/activity_page.dart';
import 'package:flutter_application_laboratorio_3/pages/feedback_page.dart';
import 'package:flutter_application_laboratorio_3/widgets/connection_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';
import 'package:flutter_application_laboratorio_3/pages/detail_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Logger logger = Logger();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    logger.i("HomePage loaded");
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final appData = context.read<AppData>();
      appData.setSelectedDinoImage(image.path);
    }
  }

  void _showImageSourceActionSheet() {
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
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Gallery"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();
    final displayedDinosaurs = appData.filteredDinosaurs.take(3).toList();

    return ConnectionStatus(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("DinoVerse - Home"),
          actions: [
            GestureDetector(
              onTap: _showImageSourceActionSheet,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: appData.selectedDinoImage.isNotEmpty
                      ? FileImage(File(appData.selectedDinoImage)) as ImageProvider
                      : const AssetImage('assets/icons/animal_3.svg') as ImageProvider,
                  child: appData.selectedDinoImage.isEmpty
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.explore),
                title: const Text("Explore Dinosaurs"),
                onTap: () {
                  Navigator.pop(context);
                  // No navega a ListContent aquí, solo como ejemplo
                },
              ),
              ListTile(
                leading: const Icon(Icons.quiz),
                title: const Text("Start Quiz"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TriviaPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("About"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const About()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Preferences"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PreferencesPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Activities"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ActivityPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text("Your Opinion"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbackPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (appData.dinoImage.isNotEmpty)
                  appData.dinoImage.startsWith('http') // Detecta si es una URL
                      ? CachedNetworkImage(
                          imageUrl: appData.dinoImage,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error, size: 100),
                        )
                      : Image.file(
                          File(appData.dinoImage),
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 100),
                        )
                else
                  SvgPicture.asset(
                    'assets/icons/animal_3.svg',
                    width: 200,
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Dino Universe',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (displayedDinosaurs.isNotEmpty)
                  Column(
                    children: displayedDinosaurs.map((dino) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(dinosaur: dino),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (dino.image.isNotEmpty)
                              CachedNetworkImage(
                                imageUrl: dino.image,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error, size: 100),
                              )
                            else
                              const Icon(Icons.image_not_supported, size: 100),
                            const SizedBox(width: 10),
                            Text(
                              dino.name,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}