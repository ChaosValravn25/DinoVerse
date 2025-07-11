import 'package:sqflite/sqflite.dart';

class Dinosaur {
  final int? id; // ID para la base de datos, nullable para nuevos registros
  final String name;
  final String diet;
  final String period;
  final String length;
  final String weight;
  final String description;
  final String image;

  Dinosaur({
    this.id,
    required this.name,
    required this.diet,
    required this.period,
    required this.length,
    required this.weight,
    required this.description,
    required this.image,
  });

  // Convertir Dinosaur a Mapa para sqflite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'diet': diet,
      'period': period,
      'length': length,
      'weight': weight,
      'description': description,
      'image': image,
    };
  }

  // Crear Dinosaur desde un Mapa
  factory Dinosaur.fromMap(Map<String, dynamic> map) {
    return Dinosaur(
      id: map['id'],
      name: map['name'],
      diet: map['diet'],
      period: map['period'],
      length: map['length'],
      weight: map['weight'],
      description: map['description'],
      image: map['image'],
    );
  }
}