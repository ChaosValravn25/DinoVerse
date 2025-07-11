
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/dinosaur.dart';

class DinosaurService {
  final String _baseUrl = 'https://dinoapi.brunosouzadev.com/api/dinosaurs';

  Future<List<Dinosaur>> fetchDinosaurs() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print('Respuesta de la API: $jsonList'); // Imprimir para depurar
      return jsonList.map((json) => Dinosaur.fromJson(json)).toList();
    } else {
      print('Error en la API: ${response.statusCode} - ${response.body}');
      throw Exception('Error al cargar dinosaurios: ${response.statusCode}');
    }
  }
}