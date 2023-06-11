class Category {
  final int id;
  final String name;
  final int minTemp;
  final int maxTemp;

  Category({
    required this.id,
    required this.name,
    required this.minTemp,
    required this.maxTemp,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      minTemp: json['minTemp'] as int,
      maxTemp: json['maxTemp'] as int,
    );
  }

  factory Category.empty() {
    return Category(
      id: -1,
      name: '',
      minTemp: -1,
      maxTemp: -1,
    );
  }
}
