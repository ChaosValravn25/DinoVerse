import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';
import 'package:flutter_application_laboratorio_3/pages/about.dart';
import 'package:flutter_application_laboratorio_3/pages/detail_pages.dart';
import 'package:flutter_application_laboratorio_3/pages/api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListContent extends StatelessWidget {
  ListContent({super.key});

  final DinosaurService _dinosaurService = DinosaurService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Dinosaurios")),
      body: FutureBuilder<List<Dinosaur>>(
        future: _dinosaurService.fetchDinosaurs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error en FutureBuilder: ${snapshot.error}'); // Depuración
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () => (context as Element).markNeedsBuild(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron dinosaurios'));
          }

          final dinos = snapshot.data!;
          return ListView.builder(
            itemCount: dinos.length,
            itemBuilder: (context, index) => ListTile(
              leading: dinos[index].image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: dinos[index].image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) {
                        print('Error al cargar imagen: $error - URL: ${dinos[index].image}'); // Depuración
                        return const Icon(Icons.error);
                      },
                    )
                  : const Icon(Icons.image_not_supported),
              title: Text(dinos[index].name.toUpperCase()),
              subtitle: Text('Dieta: ${dinos[index].diet}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(dinosaur: dinos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const About()),
          );
        },
        child: const Icon(Icons.info),
      ),
    );
  }
}