class Supplier {
  final int id;
  final String name;
  final String address;
  final String email;
  final String phoneNum;

  Supplier({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNum,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phoneNum: json['phoneNum'],
    );
  }

  factory Supplier.empty() {
    return Supplier(id: 0, name: '', address: '', email: '', phoneNum: '');
  }
}
