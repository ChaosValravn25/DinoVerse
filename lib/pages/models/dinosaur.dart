class Dinosaur {
  final String name;
  final String period;
  final String diet;
  final String length;
  final String weight;
  final String image;
  final String description;

  Dinosaur({
    required this.name,
    required this.period,
    required this.diet,
    required this.length,
    required this.weight,
    required this.image,
    required this.description,
  });

  factory Dinosaur.fromJson(Map<String, dynamic> json) {
    return Dinosaur(
      name: json['name'] ?? 'Unknown',
      period: json['period'] ?? 'Unknown',
      diet: json['diet'] ?? 'Unknown',
      length: json['length'] ?? 'Unknown',
      weight: json['weight'] ?? 'Unknown',
      image: json['image'] ?? '',
      description: json['description'] ?? 'Unknown',
    );
  }
}