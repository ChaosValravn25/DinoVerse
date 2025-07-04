import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/dinosaur.dart';

class DinosaurService {
  final String _baseUrl = 'https://dinosaur-facts-api.shultzlab.com/dinosaurs';

  Future<List<Dinosaur>> fetchDinosaurs() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Dinosaur.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar dinosaurios');
    }
  }
}
