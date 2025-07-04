// list_content.dart
import 'package:flutter/material.dart';
import 'about.dart';
import 'package:flutter_application_laboratorio_3/pages/models/dinosaur.dart';
import 'package:flutter_application_laboratorio_3/pages/detail_pages.dart';

class ListContent extends StatelessWidget {
  ListContent({super.key});

  final List<Dinosaur> dinos = [
    Dinosaur(
      name: "Tyrannosaurus Rex",
      image: 'assets/images/t_rex.png',
      description: "Uno de los depredadores más grandes del periodo Cretácico.",
    ),
     Dinosaur(
      name: "Triceratops",
      image: 'assets/images/triceratops.png',
      description: "Herbívoro con tres cuernos y un escudo óseo.",
    ),
    Dinosaur(
      name: "Velociraptor",
      image: 'assets/images/velociraptor.png',
      description: "Dinosaurio ágil y rápido, cazador en grupo.",
    ),
    Dinosaur(
      name: "Brachiosaurus",
      image: 'assets/images/brachiosaurus.png',
      description: "Gigante herbívoro con cuello largo del Jurásico.",
    ),
    Dinosaur(
      name: "Spinosaurus",
      image: 'assets/images/Spinosaurus.png',
      description: "Dinosaurio semiacuático con espina dorsal distintiva.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Dinosaurios")),
      body: ListView.builder(
        itemCount: dinos.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(dinos[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(dinosaur: dinos[index]),
              ),
            );
          },
        ),
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

