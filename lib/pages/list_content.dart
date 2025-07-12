import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';
import 'package:flutter_application_laboratorio_3/pages/about.dart';
import 'package:flutter_application_laboratorio_3/pages/detail_pages.dart';
import 'package:flutter_application_laboratorio_3/pages/api.dart';
import 'package:flutter_application_laboratorio_3/widgets/connection_status.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListContent extends StatelessWidget {
  ListContent({super.key});
  final DinosaurService _dinosaurService = DinosaurService();

  @override
  Widget build(BuildContext context) {
    return ConnectionStatus(
      child: Scaffold(
        appBar: AppBar(title: const Text("Dinosaurs List")),
        body: RefreshIndicator(
          onRefresh: () async {
            await _dinosaurService.fetchDinosaurs();
            (context as Element).markNeedsBuild();
          },
          child: FutureBuilder<List<Dinosaur>>(
            future: _dinosaurService.fetchDinosaurs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error loading: ${snapshot.error.toString()}'),
                      ElevatedButton(
                        onPressed: () => (context as Element).markNeedsBuild(),
                        child: const Text('restart'),
                      ),
                    ],
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No dinosaurs were found.'));
              }
              final dinos = snapshot.data!; // Obtener todos los dinosaurios
              return ListView.builder(
                itemCount: dinos.length, // Usar la longitud completa de la lista
                itemBuilder: (context, index) => ListTile(
                  leading: dinos[index].image.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: dinos[index].image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        )
                      : const Icon(Icons.image_not_supported),
                  title: Text(dinos[index].name.toUpperCase()),
                  subtitle: Text('Diet: ${dinos[index].diet}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailPage(dinosaur: dinos[index])),
                    );
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const About())),
          child: const Icon(Icons.info_outline),
        ),
      ),
    );
  }
}