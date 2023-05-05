class Storage {
  final int categoryId;
  final int maxAmount;

  Storage({required this.categoryId, required this.maxAmount});

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      categoryId: json['categoryId'],
      maxAmount: json['maxAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'maxAmount': maxAmount,
    };
  }
}
