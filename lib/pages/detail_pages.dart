import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DetailPage extends StatelessWidget {
  final Dinosaur dinosaur;

  const DetailPage({super.key, required this.dinosaur});

  Future<void> _shareViaWhatsApp(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(dinosaur.image));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/dino_image.jpg';
        final File imageFile = File(imagePath);
        await imageFile.writeAsBytes(response.bodyBytes);

        final String message =
            '📸 ¡Mira este dinosaurio! Nombre: ${dinosaur.name}\n¡Comparte con tus amigos! 🦖';

        await Share.shareXFiles([XFile(imagePath)], text: message);
      } else {
        throw 'No se pudo descargar la imagen';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al compartir: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dinosaur.name.toUpperCase()),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              try {
                await _shareViaWhatsApp(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al compartir: $e')),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (dinosaur.image.isNotEmpty)
                Center(
                  child: CachedNetworkImage(
                    imageUrl: dinosaur.image,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error, size: 100),
                  ),
                )
              else
                const Center(child: Icon(Icons.image_not_supported, size: 100)),
              const SizedBox(height: 20),
              Text(
                dinosaur.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Descripción: ${dinosaur.description}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                'Dieta: ${dinosaur.diet}',
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
              const SizedBox(height: 10),
              Text(
                'Período: ${dinosaur.period}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Longitud: ${dinosaur.length}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Peso: ${dinosaur.weight}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
