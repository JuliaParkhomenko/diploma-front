class Warehouse {
  final int id;
  final String name;
  final String address;
  final String? manager;

  Warehouse({
    this.manager,
    required this.id,
    required this.name,
    required this.address,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      manager: json['managers'] == null
          ? null
          : (json['managers'] as List).isEmpty
              ? null
              : json['managers'][0]['fullName'],
    );
  }
}
